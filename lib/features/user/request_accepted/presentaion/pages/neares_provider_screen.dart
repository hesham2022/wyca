import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyca/core/api_config/api_constants.dart';
import 'package:wyca/core/routing/routes.gr.dart';
import 'package:wyca/core/utils/map_utils/map_helper.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/auth/data/models/provider_registeration_response.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/presentation/get_requests.dart';
import 'package:wyca/features/request/presentation/provider_notification_cubit.dart';
import 'package:wyca/features/request/presentation/request_cubit.dart';
import 'package:wyca/features/user/request_accepted/presentaion/pages/chat_screen.dart';
import 'package:wyca/imports.dart';

class NearesProviderScreen extends StatefulWidget {
  const NearesProviderScreen({super.key, this.request});
  final RequestClass? request;
  @override
  State<NearesProviderScreen> createState() => _NearesProviderScreenState();
}

String formattedTime(int seconds) {
  final _hours = (seconds ~/ 60).toString();
  final _seconds = (seconds % 60).toString();

  return '$_hours:$_seconds';
}

class _NearesProviderScreenState extends State<NearesProviderScreen> {
  final googeHelper = MapHelper();
  Duration? duration;
  @override
  void initState() {
    _requestClass = widget.request;
    provider = _requestClass!.providerModel;
    // if (_requestClass!.startDate != null) {
    //   duration = DateTime.now().difference(_requestClass!.startDate!);
    // }
    // if (_requestClass!.startDate != null && _requestClass!.endDate == null) {
    //   Timer.periodic(const Duration(seconds: 1), (v) {
    //     duration = Duration(seconds: duration!.inSeconds + 1);

    //     Future.delayed(Duration.zero, () {
    //       setState(() {});
    //     });
    //   });
    // }
    googeHelper.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  ProviderModel? provider;
  RequestClass? _requestClass;
  ImageProvider image() {
    if (provider != null) {
      return NetworkImage('$domain/img/providers/${provider!.photo}');
    } else {
      return AssetImage(
        Assets.images.pexelsKindelMedia84869073x.path,
      );
    }
  }

// (education2016wyca)
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetRequestCubit>(
          create: (context) => GetRequestCubit(requestRespository: getIt())
            ..getSingelRequest(_requestClass!.id),
        ),
        BlocProvider<RequestCubit>(
          create: (context) => RequestCubit(requestRespository: getIt()),
        ),
      ],
      child: Scaffold(
        // appBar: const PreferredSize(
        //   preferredSize: Size.fromHeight(kToolbarHeight),
        //   child: LocationAppBar(),
        // ),
        appBar: appBar(context, 'Request Details'),
        body: BlocConsumer<GetRequestCubit, GetRequestCubitState>(
          listener: (context, state) {
            if (state is GetSingleRequestCubitStateLoaded) {
              final req = state.request;
              context.read<PNCubit>().updateNotification(
                    req,
                  );
            }
          },
          builder: (context, state) {
            if (state is GetSingleRequestCubitStateLoaded) {
              final req = state.request;

              return ScreenBox(
                request: req,
                provider: req.providerModel ?? provider,
              );
            }
            return const Text('...');
          },
        ),
      ),
    );
  }
}

class ScreenBox extends StatefulWidget {
  const ScreenBox({super.key, required this.request, required this.provider});
  final RequestClass request;
  final ProviderModel? provider;
  @override
  State<ScreenBox> createState() => _ScreenBoxState();
}

class _ScreenBoxState extends State<ScreenBox> {
  late ProviderModel? provider;
  late RequestClass _requestClass;
  Duration? duration;
  Timer? timer;
  @override
  void initState() {
    provider = widget.provider;
    _requestClass = widget.request;
    startTimer();
    googeHelper.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void startTimer() {
    if (_requestClass.startDate != null) {
      duration = DateTime.now().difference(_requestClass.startDate!);
    }
    if (_requestClass.endDate != null) {
      duration = _requestClass.endDate!.difference(_requestClass.startDate!);
    }
    if (_requestClass.startDate != null && _requestClass.endDate == null) {
      if (timer != null) {
        if (!timer!.isActive) {
          timer = Timer.periodic(const Duration(seconds: 1), (v) {
            duration = Duration(seconds: duration!.inSeconds + 1);
            if (mounted) {
              setState(() {});
            } else {
              timer!.cancel();
            }
          });
        }
      } else {
        timer = Timer.periodic(const Duration(seconds: 1), (v) {
          duration = Duration(seconds: duration!.inSeconds + 1);
          if (mounted) {
            setState(() {});
          } else {
            timer!.cancel();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  ImageProvider image() {
    if (provider != null) {
      return NetworkImage('$domain/img/providers/${provider!.photo}');
    } else {
      return AssetImage(
        Assets.images.pexelsKindelMedia84869073x.path,
      );
    }
  }

  final googeHelper = MapHelper();
  bool takeFromNotifcation = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<PNCubit, PNCubitState>(
      listener: (context, state) {
        if (context.read<PNCubit>().newReq != null) {
          if (context.read<PNCubit>().newReq!.id == _requestClass.id) {
            setState(() {
              _requestClass = context.read<PNCubit>().newReq!;
            });

            if (_requestClass.startDate != null &&
                _requestClass.endDate == null) {
              startTimer();
              return;
            }
            if (_requestClass.startDate != null &&
                _requestClass.endDate != null) {
              if (timer!.isActive) {
                timer!.cancel();
              }
              if (_requestClass.isConfired) {}
              return;
            }
          }
        }
      },
      child: BlocConsumer<RequestCubit, RequestCubitState>(
        listener: (context, requestCubitState) {
          if (requestCubitState is RequestCubitStateConfirmed) {
            context.read<PNCubit>().newReq = requestCubitState.request;

            context.read<PNCubit>().updateNotification(
                  requestCubitState.request.copyWith(
                    providerModel: widget.request.providerModel,
                  ),
                );
            AutoRouter.of(context).pushAndPopUntil(
              HomePAGE(
                requestClass: requestCubitState.request,
              ),
              predicate: (r) => false,
            );

            // context.read<GetRequestCubit>().addReq(requestCubitState.request);
          }
          if (requestCubitState is RequestCubitStateDisConfirmed) {
            context.read<PNCubit>().newReq = requestCubitState.request;

            context.read<PNCubit>().updateNotification(
                  requestCubitState.request.copyWith(
                    providerModel: widget.request.providerModel,
                  ),
                );
          }
        },
        builder: (context, requestCubitState) {
          return SingleChildScrollView(
            child: Padding(
              padding: kPadding.copyWith(top: 0, bottom: 0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: image(),
                  ),
                  if (duration != null)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Time Start Wash: '),
                          Text(
                            formattedTime(duration!.inSeconds),
                            style: kHead1Style,
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Name: '),
                      Text(
                        provider != null ? provider!.name : 'Mustafa Helal',
                        style: kHead1Style.copyWith(
                          color: ColorName.black,
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   provider != null ? provider!.name : 'Mustafa Helal',
                  //   style: kHead1Style.copyWith(
                  //     color: ColorName.black,
                  //     fontSize: 16.sp,
                  //   ),
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16.sp,
                      ),
                      Text(
                        provider != null
                            ? provider!.ratingsAverage.toString()
                            : '4.5',
                        style: kBody1Style.copyWith(
                          color: Colors.amber,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Icon(
                        Icons.location_on,
                        size: 12.sp,
                        color: ColorName.primaryColor,
                      ),
                      Text(
                        '1.5 km',
                        style: kBody1Style.copyWith(
                          color: ColorName.primaryColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // RichText(
                  //   maxLines: 1,
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: 'Estimated Time Of Arrival : ',
                  //         style: kHead1Style.copyWith(fontSize: 16.sp),
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
                  const SizedBox(
                    height: 15,
                  ),
                  const SectionTitile('Location'),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 180.h,
                    width: 302.w,
                    child: GoogleMap(
                      markers: googeHelper.markers,
                      onTap: (argument) {
                        googeHelper.addMarker(
                          LatLng(argument.latitude, argument.longitude),
                        );
                      },
                      onMapCreated: (controller) {
                        googeHelper
                          ..init(controller)
                          ..addMarker(
                            provider != null
                                ? (_requestClass.providerLocation != null
                                    ? LatLng(
                                        _requestClass.address.coordinates[0],
                                        _requestClass.address.coordinates[1],
                                      )
                                    : LatLng(
                                        provider!.address.coordinates[0],
                                        provider!.address.coordinates[1],
                                      ))
                                : const LatLng(30, 31),
                          );
                        googeHelper.controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: provider != null
                                  ? (_requestClass.providerLocation != null
                                      ? LatLng(
                                          _requestClass.address.coordinates[0],
                                          _requestClass.address.coordinates[1],
                                        )
                                      : LatLng(
                                          provider!.address.coordinates[0],
                                          provider!.address.coordinates[1],
                                        ))
                                  : const LatLng(30, 31),
                              zoom: 15,
                            ),
                          ),
                        );
                      },
                      initialCameraPosition: googeHelper.initialPosition,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          titleStyle: kHead1Style.copyWith(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                          title: 'Start Chat',
                          onPressed: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  name: provider!.name,
                                  recieverId:
                                      provider != null ? provider!.id : '',
                                  recieverType: 'provider',
                                  recieverImage: provider != null
                                      ? '$domain/img/providers/${provider!.photo}'
                                      : '',
                                  senderId: context
                                      .read<AuthenticationBloc>()
                                      .state
                                      .user
                                      .id,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: AppButton(
                          color: Colors.white,
                          titleStyle: kHead1Style.copyWith(
                            color: ColorName.primaryColor,
                            fontSize: 14.sp,
                          ),
                          titleColor: ColorName.primaryColor,
                          title: 'Home Page',
                          onPressed: () {
                            Future.delayed(Duration.zero, () {
                              AutoRouter.of(context).pushAndPopUntil(
                                HomePAGE(),
                                predicate: (route) => false,
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  if (_requestClass.isDone && !_requestClass.isConfired)
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Provider finished his wash , please confirm if it done?',
                          style: kHead1Style.copyWith(fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                color: Colors.white,
                                titleStyle: kHead1Style.copyWith(
                                  color: ColorName.primaryColor,
                                  fontSize: 14.sp,
                                ),
                                titleColor: ColorName.primaryColor,
                                title: 'Confirm',
                                onPressed: () async {
                                  await context
                                      .read<RequestCubit>()
                                      .confirmRequest(_requestClass.id);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: AppButton(
                                color: Colors.white,
                                titleStyle: kHead1Style.copyWith(
                                  color: ColorName.primaryColor,
                                  fontSize: 14.sp,
                                ),
                                titleColor: ColorName.primaryColor,
                                title: 'disconfirm',
                                onPressed: () async {
                                  await context
                                      .read<RequestCubit>()
                                      .disconfirmRequest(_requestClass.id);
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  if (_requestClass.canceled)
                    const Text('You Have Canceled This Request'),
                  if ((_requestClass.isMissed ||
                          _requestClass.isAccepetd ||
                          _requestClass.isOpened) &&
                      !_requestClass.canceled)
                    Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        AppButton(
                          color: Colors.white,
                          titleStyle: kHead1Style.copyWith(
                            color: ColorName.primaryColor,
                            fontSize: 14.sp,
                          ),
                          titleColor: ColorName.primaryColor,
                          title: 'Cnacel',
                          onPressed: () async {
                            await context
                                .read<RequestCubit>()
                                .cancelRequest(_requestClass.id)
                                .then((value) {
                              context
                                  .read<GetRequestCubit>()
                                  .getSingelRequest(_requestClass.id);
                            });
                          },
                        ),
                      ],
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
