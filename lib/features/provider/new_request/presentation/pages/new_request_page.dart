import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/core/theme/app_theme.dart';
import 'package:wyca/core/widgets/app_bar_global.dart';
import 'package:wyca/core/widgets/app_button.dart';
import 'package:wyca/core/widgets/welocme_widget.dart';
import 'package:wyca/features/companmy_setting/presentation/widgets/common_container.dart';
import 'package:wyca/features/provider/home/presentation/pages/provider_home_page.dart';
import 'package:wyca/features/provider/new_request/presentation/pages/request_details_page.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/domain/params/acceptParams.dart';
import 'package:wyca/features/request/presentation/provider_notification_cubit.dart';
import 'package:wyca/features/request/presentation/request_provider.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/gen/colors.gen.dart';

class ProviderNewRequestPage extends StatefulWidget {
  const ProviderNewRequestPage({super.key, required this.request});
  final RequestClass request;

  @override
  State<ProviderNewRequestPage> createState() => _ProviderNewRequestPageState();
}

class _ProviderNewRequestPageState extends State<ProviderNewRequestPage> {
  late RequestClass _req;
  @override
  void initState() {
    setState(() {
      _req = widget.request;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PNCubit, PNCubitState>(
      listener: (context, state) {
        if (state is PNCubitStateLoaded) {
          setState(() {
            _req =
                state.requests.firstWhere((element) => element.id == _req.id);
          });
        }
      },
      child: _req.status > 0 && _req.status < 4
          ? RequestDetailsPage(
              request: _req,
            )
          : Scaffold(
              appBar: appBar(context, 'Request Status'),
              body: Padding(
                padding: kPadding,
                child: Column(
                  children: [
                    const WelcomWidget(),
                    Lottie.asset(Assets.lottie.animation9),
                    Text(
                      'You Have A New Request',
                      style: kHead1Style.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BlocConsumer<RequestProviderCubit,
                              RequestProviderCubitState>(
                            listener: (context, state) async {
                              if (state is RequestProviderCubitStateSent) {
                                await context
                                    .read<PNCubit>()
                                    .updateNotification(state.request);
                                // await Future.delayed(Duration.zero, () async {
                                //   await Navigator.push<void>(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => RequestDetailsPage(
                                //         request: widget.request,
                                //       ),
                                //     ),
                                //   );
                                // });
                              }
                              if (state is RequestProviderCubitStateError) {
                                await Fluttertoast.showToast(
                                  msg: state.error.errorMessege,
                                );
                              }
                            },
                            builder: (context, state) {
                              return AppButton(
                                title: 'Accept',
                                onPressed: () async {
                                  final prosition =
                                      await _determinePosition(context);
                                  await context
                                      .read<RequestProviderCubit>()
                                      .accept(
                                        AcceptParams(
                                          id: widget.request.id,
                                          coordinates: [
                                            prosition.latitude,
                                            prosition.longitude
                                          ],
                                        ),
                                      );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: BlocConsumer<RequestProviderCubit,
                              RequestProviderCubitState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return AppButton(
                                color: Colors.white,
                                titleColor: ColorName.primaryColor,
                                title: 'Reject',
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ProviderHomePage(),
                                    ),
                                    (route) => false,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (c) => Dialog(
          // backgroundColor: Colors.white.withOpacity(.8),
          insetPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: CommonContainer(
            color: Colors.white,
            height: 130,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enable Location',
                    style: textStyleWithPrimaryBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppButton(
                    title: 'Try Again',
                    // size: const Size(200, 20),
                    onPressed: () async {
                      serviceEnabled =
                          await Geolocator.isLocationServiceEnabled();
                      if (!serviceEnabled) {
                        return;
                      }
                      Future.delayed(Duration.zero, () {
                        _determinePosition(c);
                        Navigator.pop(c);
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          // actions: const [Button1(title: 'Try Again')],
        ),
      );
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return Geolocator.getCurrentPosition();
  }
}
