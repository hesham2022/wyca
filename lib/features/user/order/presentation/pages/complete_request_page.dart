import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/core/routing/routes.gr.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/presentation/provider_notification_cubit.dart';
import 'package:wyca/features/request/presentation/request_cubit.dart';
import 'package:wyca/imports.dart';

bool kAceeptedScreen = false;

class CompleteRequestPage extends StatelessWidget {
  const CompleteRequestPage({super.key, required this.requestClass});

  final RequestClass requestClass;

  @override
  Widget build(BuildContext context) {
    kAceeptedScreen = true;
    return WillPopScope(
      onWillPop: () async {
        kAceeptedScreen = false;
        return true;
      },
      child: BlocListener<PNCubit, PNCubitState>(
        listener: (context, state) {
          if (state is PNCubitStateLoaded) {
            showAboutDialog(context: context, children: [const Text('done')]);

            if (state.requests
                .map((e) => e.id)
                .toList()
                .contains(requestClass.id)) {
              context.router.pushAndPopUntil(
                HomePAGE(),
                predicate: (r) => false,
              );
              //  context.router.popUntilRoot();

              final request = state.requests
                  .firstWhere((element) => element.id == requestClass.id);
              if (request.status == 4) {
                Fluttertoast.showToast(
                  msg: 'No Provider Found',
                );

                context.router.push(
                  TryAgainRoute(
                    requestClass: request,
                  ),
                );
                return;
              } else {
                context.router.push(
                  NearesProviderScreenRoute(
                    request: request,
                  ),
                );
              }

              // Navigator.push<void>(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => NearesProviderScreenRoyte(
              //       request: state.requests.firstWhere(
              //         (element) => element.id == requestClass.id,
              //       ),
              //     ),
              //   ),
              // );
              // context.( NearesProviderScreen());
              // context.router.popAndPushAll(
              //   [const HomePAGE(), const NotificationsPageRoute()],
              // );
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.request_complete),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(null),
            ),
          ),
          body: Padding(
            padding: kPadding,
            child: Column(
              children: [
                LottieBuilder.asset(
                  'assets/lottie/search.json',
                  height: 144.h,
                  width: 144.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  context.l10n.request_completed,
                  textAlign: TextAlign.center,
                  style: kHead1Style.copyWith(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  context.l10n.select_provider,
                  textAlign: TextAlign.center,
                  style: kHead1Style.copyWith(fontSize: 16.sp),
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
                        title: context.l10n.cancel,
                        onPressed: () {},
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
                        title: context.l10n.home,
                        onPressed: () {
                          Future<void>.delayed(Duration.zero, () {
                            AutoRouter.of(context).pushAndPopUntil(
                              HomePAGE(),
                              predicate: (route) => false,
                            );
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
