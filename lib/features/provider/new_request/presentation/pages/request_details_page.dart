import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/core/routing/routes.gr.dart';
import 'package:wyca/core/utils/map_utils/map_helper.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/auth/data/models/cars_model.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/domain/params/complete_params.dart';
import 'package:wyca/features/request/presentation/get_requests.dart';
import 'package:wyca/features/request/presentation/provider_notification_cubit.dart';
import 'package:wyca/features/request/presentation/request_provider.dart';
import 'package:wyca/imports.dart';

class RequestDetailsPage extends StatefulWidget {
  const RequestDetailsPage({super.key, required this.request});
  final RequestClass request;
  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final googeHelper = MapHelper();
  late UserModel user;
  Car? car;
  bool startWashing = false;
  bool done = false;
  late RequestClass _req;
  final GetRequestCubit bloc = GetRequestCubit(requestRespository: getIt());
  @override
  void initState() {
    bloc.getSingelRequest(widget.request.id);
    setState(() {
      _req = widget.request;
    });
    user = _req.userModel!;
    if (user.cars.isNotEmpty) {
      car = user.cars.last;
    }
    googeHelper.addListener(() {
      setState(() {});
    });
    if (_req.status > 0) {
      setState(() {
        startWashing = true;
      });
    }
    if (_req.status == 3) {
      setState(() {
        done = true;
      });
    }
    super.initState();
  }

  List<String> cars = [];
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)!.settings.name;

    return BlocProvider<GetRequestCubit>.value(
      value: bloc,
      child: Scaffold(
        appBar: appBar(
          context,
          'User Details',
          back: () {
            AutoRouter.of(context).pushAndPopUntil(
              const ProviderHomeRoute(),
              predicate: (route) => false,
            );
          },
        ),
        body: BlocConsumer<PNCubit, PNCubitState>(
          listener: (context, pNCubitState) {
            if (pNCubitState is PNCubitStateLoaded) {
              setState(() {
                final r = pNCubitState.requests.firstWhere(
                  (element) => element.id == _req.id,
                  orElse: () {
                    return _req;
                  },
                );
                setState(() {
                  _req = r;
                });
              });
              if (_req.canceled) {
                AutoRouter.of(context).pushAndPopUntil(
                  const ProviderHomeRoute(),
                  predicate: (route) => false,
                );
              }
              //  bloc.getSingelRequest(widget.request.id);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: kPadding,
                child: BlocConsumer<GetRequestCubit, GetRequestCubitState>(
                  listener: (context, state) {
                    if (state is GetSingleRequestCubitStateLoaded) {
                      setState(() {
                        _req = state.request;
                      });
                      if (_req.canceled) {
                        context
                            .read<PNCubit>()
                            .removeNotification(state.request);
                        return;
                      }
                      context.read<PNCubit>().updateNotification(state.request);
                    }
                  },
                  builder: (context, state) {
                    return BlocConsumer<RequestProviderCubit,
                        RequestProviderCubitState>(
                      listener: (context, state) async {
                        if (state is RequestProviderCubitStateStarted) {
                          startWashing = true;
                          setState(() {
                            _req = state.request;
                          });
                          await context
                              .read<PNCubit>()
                              .updateNotification(state.request);
                          // if (state.request.status == 3) {
                          //   await AutoRouter.of(context).pushAndPopUntil(
                          //     const ProviderHomeRoute(),
                          //     predicate: (route) => false,
                          //   );
                          // }
                        }
                        if (state is RequestProviderCubitStateDone) {
                          startWashing = true;

                          await context
                              .read<PNCubit>()
                              .updateNotification(state.request);
                          setState(() {
                            _req = state.request;
                          });
                          if (_req.status == 3) {
                            setState(() {
                              done = true;
                            });
                          }
                          // await AutoRouter.of(context).pushAndPopUntil(
                          //   const ProviderHomeRoute(),
                          //   predicate: (route) => false,
                          // );
                          // if (state.request.status == 3) {
                          //   await AutoRouter.of(context).pushAndPopUntil(
                          //     const ProviderHomeRoute(),
                          //     predicate: (route) => false,
                          //   );
                          // }
                        }
                        if (state is RequestProviderCubitStateError) {
                          await Fluttertoast.showToast(
                            msg: state.error.errorMessege.toString(),
                          );

                          // await Future.delayed(Duration.zero, () async {
                          //   await Navigator.push<void>(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => RequestDetailsPage(
                          //         request: request,
                          //       ),
                          //     ),
                          //   );
                          // });
                        }
                        // if (state is RequestProviderCubitStateSent) {
                        //   if (state.request.status == 2) {
                        //     startWashing = true;
                        //     setState(() {});
                        //   }
                        // }
                      },
                      builder: (context, state) {
                        print('#' * 100);

                        print(_req.carPhotos);
                        return ((_req.isDone && _req.isConfired) &&
                                _req.carPhotos.isEmpty)
                            ? CompleteWidget(
                                request: _req,
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundImage: NetworkImage(
                                        '$domain/img/cars/${user.cars.last.photo}',
                                        //   'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                      ),
                                    ),
                                  ),
                                  if (car != null)
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10.w, height: 0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text('Car Number: '),
                                                    Text(
                                                      //  '562-AME',
                                                      car!.number,
                                                      style:
                                                          kHead1Style.copyWith(
                                                        fontSize: 16.sp,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text('Car Type; '),
                                                    Text(
                                                      car!.type,
                                                      // DateFormat('Mercedes').format(DateTime.now()),
                                                      style:
                                                          kHead1Style.copyWith(
                                                        fontSize: 16.sp,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text('Car Color: '),
                                                    Text(
                                                      // DateFormat('Blue').format(DateTime.now()),
                                                      car!.color,
                                                      style:
                                                          kHead1Style.copyWith(
                                                        fontSize: 16.sp,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  // SizedBox(height: 20.h),
                                  // Text(_req.status.toString()),
                                  // RichText(
                                  //   maxLines: 1,
                                  //   text: TextSpan(
                                  //     children: [
                                  //       TextSpan(
                                  //         text: 'Estimated Time Of Arrival : ',
                                  //         style: kHead1Style.copyWith(
                                  //           fontSize: 16.sp,
                                  //         ),
                                  //       ),
                                  //       TextSpan(
                                  //         text: '20 Minutes',
                                  //         style: kHead1Style.copyWith(
                                  //           fontSize: 14.sp,
                                  //           color: Colors.black,
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   height: 15,
                                  // ),
                                  // const SizedBox(
                                  //   height: 15,
                                  // ),
                                  // RichText(
                                  //   maxLines: 1,
                                  //   text: TextSpan(
                                  //     children: [
                                  //       TextSpan(
                                  //         text: 'The Distance Between You : ',
                                  //         style: kHead1Style.copyWith(
                                  //           fontSize: 16.sp,
                                  //         ),
                                  //       ),
                                  //       TextSpan(
                                  //         text: '25 km',
                                  //         style: kHead1Style.copyWith(
                                  //           fontSize: 14.sp,
                                  //           color: Colors.black,
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const SectionTitile('Location'),
                                  Row(
                                    children: [
                                      RichText(
                                        maxLines: 1,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Open In Driving Mode',
                                              style: kHead1Style.copyWith(
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final posisiton =
                                              await determinePosition();
                                          await launch(
                                            launcTrackingLink(
                                              posisiton.altitude,
                                              posisiton.longitude,
                                              _req.address.coordinates[0],
                                              _req.address.coordinates[1],
                                            ),
                                          );
                                        },
                                        child: const Icon(Icons.open_in_new),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    height: 280.h,
                                    width: 302.w,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: GoogleMap(
                                            markers: googeHelper.markers,
                                            onTap: (argument) {
                                              // googeHelper.addMarker(
                                              //   LatLng(
                                              //     argument.latitude,
                                              //     argument.longitude,
                                              //   ),
                                              // );
                                            },
                                            onMapCreated: (controller) {
                                              googeHelper
                                                ..init(controller)
                                                ..addMarker(
                                                  LatLng(
                                                    _req.address.coordinates[0],
                                                    _req.address.coordinates[1],
                                                  ),
                                                );
                                              googeHelper.controller
                                                  .animateCamera(
                                                CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                                    target: LatLng(
                                                      _req.address
                                                          .coordinates[0],
                                                      _req.address
                                                          .coordinates[1],
                                                      // googeHelper.markers.first.position.longitude,
                                                    ),
                                                    zoom: 15,
                                                  ),
                                                ),
                                              );
                                            },
                                            initialCameraPosition:
                                                googeHelper.initialPosition,
                                          ),
                                        ),
                                        AppButton(
                                          title: 'Center Loctation',
                                          h: 20,
                                          onPressed: () {
                                            googeHelper.controller
                                                .animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                  target: LatLng(
                                                    _req.address.coordinates[0],
                                                    _req.address.coordinates[1],
                                                    // googeHelper.markers.first.position.longitude,
                                                  ),
                                                  zoom: 18,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Text(currentRoute ?? 'null'),
                                  Row(
                                    children: [
                                      if (!_req.carPhotos.isNotEmpty)
                                        Expanded(
                                          child: BlocBuilder<
                                              RequestProviderCubit,
                                              RequestProviderCubitState>(
                                            builder: (context, state) {
                                              // final isStarted = startWashing;
                                              // state is RequestProviderCubitStateStarted ||
                                              //     state is RequestProviderCubitStateDone;

                                              return AppButton(
                                                color: _req.status == 1
                                                    ? Colors.white
                                                    : ColorName.primaryColor,
                                                titleStyle:
                                                    kHead1Style.copyWith(
                                                  color: _req.status == 1
                                                      ? ColorName.primaryColor
                                                      : Colors.white,
                                                  fontSize: 14.sp,
                                                ),
                                                title: 'Start Chat',
                                                onPressed: () {
                                                  context.router.push(
                                                    ChatScreenRoute(
                                                      name: user.name,
                                                      recieverId: user.id,
                                                      recieverImage: '',
                                                      senderId: context
                                                          .read<
                                                              AuthenticationBloc>()
                                                          .state
                                                          .provider!
                                                          .id,
                                                      recieverType: 'user',
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      if (_req.status != 3 && !_req.canceled)
                                        BlocBuilder<RequestProviderCubit,
                                            RequestProviderCubitState>(
                                          builder: (context, state) {
                                            // final isStarted = startWashing;

                                            // state is RequestProviderCubitStateStarted ||
                                            //     state is RequestProviderCubitStateDone;
                                            return Expanded(
                                              child: AppButton(
                                                color: _req.status == 1
                                                    ? ColorName.primaryColor
                                                    : Colors.white,
                                                titleStyle:
                                                    kHead1Style.copyWith(
                                                  color: !(_req.status == 1)
                                                      ? ColorName.primaryColor
                                                      : Colors.white,
                                                  // color: ColorName.primaryColor,
                                                  fontSize: 14.sp,
                                                ),
                                                titleColor: Colors.white,
                                                title: _req.status == 2
                                                    ? 'Washing Done'
                                                    : 'Start Washing',
                                                //    'Washing Done',
                                                onPressed: () {
                                                  if (_req.status == 2) {
                                                    context
                                                        .read<
                                                            RequestProviderCubit>()
                                                        .done(
                                                          widget.request.id,
                                                        );

                                                    // Navigator.pushAndRemoveUntil<void>(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //     builder: (context) =>
                                                    //         const ProviderHomePage(),
                                                    //   ),
                                                    //   (route) => false,
                                                    // );
                                                  } else {
                                                    context
                                                        .read<
                                                            RequestProviderCubit>()
                                                        .start(
                                                          widget.request.id,
                                                        );
                                                    // setState(() {
                                                    //   startWashing = true;
                                                    // });
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                  if (_req.startDate != null &&
                                      _req.endDate != null)
                                    Text(
                                      'Your wash time  ${formatedTime(timeInSecond: _req.endDate!.difference(_req.startDate!).inSeconds)}',
                                    ),
                                  if (_req.note != null)
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text('Your Note'),
                                        TextFormField(
                                          enabled: false,
                                          controller: TextEditingController()
                                            ..text = _req.note!,
                                          maxLines: 5,
                                        ).commonFild2(context),
                                      ],
                                    ),
                                  if (_req.carPhotos.isNotEmpty)
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text('Car Photos'),
                                        SizedBox(
                                          height: 300,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: GridView.builder(
                                                    itemCount:
                                                        _req.carPhotos.length,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                    ),
                                                    itemBuilder: (
                                                      BuildContext context,
                                                      int index,
                                                    ) {
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .all(6),
                                                        height: 80,
                                                        width: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              '$domain/img/cars/${_req.carPhotos[index]}',
                                                            ),
                                                            fit: BoxFit.fill,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            8,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (!startWashing)
                                    Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Lottie.asset(
                                            height: 84.h,
                                            width: 84.h,
                                            Assets.lottie.animation8,
                                          ),
                                          SizedBox(
                                            height: 10.sp,
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              'If You Are More Than 30 Minutes Late, The Customer Can Cancel The Order',
                                              style: kHead1Style.copyWith(
                                                fontSize: 12.sp,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  SizedBox(
                                    height: 70.h,
                                  ),
                                ],
                              );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return Geolocator.getCurrentPosition();
}

class CompleteWidget extends StatefulWidget {
  const CompleteWidget({
    super.key,
    required this.request,
  });
  final RequestClass request;

  @override
  State<CompleteWidget> createState() => _CompleteWidgetState();
}

String formatedTime({required int timeInSecond}) {
  final sec = timeInSecond % 60;
  final min = (timeInSecond / 60).floor();
  final minute = min.toString().length <= 1 ? '0$min' : '$min';
  final second = sec.toString().length <= 1 ? '0$sec' : '$sec';
  return '$minute : $second';
}

class _CompleteWidgetState extends State<CompleteWidget> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  Future<void> selectImages() async {
    final selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print('Image List Length:${imageFileList!.length}');
    setState(() {});
  }

  final _key = GlobalKey<FormState>();
  String note = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          if (widget.request.startDate != null &&
              widget.request.endDate != null)
            Column(
              children: [
                Text(
                  'Your wash Time  ${formatedTime(timeInSecond: widget.request.endDate!.difference(widget.request.startDate!).inSeconds)}',
                ),
              ],
            ),
          const SizedBox(
            height: 20,
          ),
          const Text('Your Note (required)'),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (value) => note = value,
            maxLines: 5,
            validator: (value) => value!.isEmpty ? 'Please add Note' : null,
          ).commonFild2(context),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 260,
            decoration: BoxDecoration(
              border: Border.all(width: .5, color: kPrimaryColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                if (imageFileList!.isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: GridView.builder(
                        itemCount: imageFileList!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(6),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(imageFileList![index].path),
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    imageFileList!.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                  onPressed: selectImages,
                  title: 'Select Images',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          AppButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                if (imageFileList!.isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'Please select at least one image',
                  );
                  return;
                }

                context.read<RequestProviderCubit>().complete(
                      CompleteRequestParams(
                        id: widget.request.id,
                        note: note,
                        cars: imageFileList!.map((e) => e.path).toList(),
                      ),
                    );
              }
            },
            title: 'Complete',
          ),
        ],
      ),
    );
  }
}
