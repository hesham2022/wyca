import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/provider/notification/presentation/pages/info_widget.dart';
import 'package:wyca/features/request/presentation/provider_notification_cubit.dart';
import 'package:wyca/imports.dart';

class ProviderNotificationPage extends StatefulWidget {
  const ProviderNotificationPage({super.key});

  @override
  State<ProviderNotificationPage> createState() =>
      _ProviderNotificationPageState();
}

class _ProviderNotificationPageState extends State<ProviderNotificationPage> {
  @override
  void initState() {
    context.read<PNCubit>().getLocalNotifcation(
          isProvider: true,
          userId: context.read<AuthenticationBloc>().state.provider == null
              ? null
              : context.read<AuthenticationBloc>().state.provider!.id,
        );
    super.initState();
  }

  String getNotification(
    int status,
    String name,
    bool confrimed,
    bool disconfermed,
  ) {
    if (status == 2) return 'You have started washing for $name';
    if (status == 3 && !confrimed) {
      return 'You have done washing for $name wait until customer confirm request';
    }
    if (status == 3 && confrimed) {
      return '$name cofirmed You Have Done Wash';
    }
    if (disconfermed) {
      return '$name not confirmed the request please contenue waashing and contact with customer to confirm the request';
    }
    return 'You have received a request from $name';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, context.l10n.notifications),
      body: Center(
        child: Padding(
          padding: kPadding.copyWith(top: 0.h),
          child: BlocBuilder<PNCubit, PNCubitState>(
            builder: (context, state) {
              if (state is PNCubitStateLoaded) {
                final requests = state.requests
                    .where((request) => request.user != null)
                    .toList();
                return Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              RequestInfoWidgetProvider(
                                request: requests[index],
                                user: requests[index].userModel,
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          );
                          //  Column(
                          //   children: [
                          //     ListTile(
                          //       onTap: () {
                          //         Navigator.push<void>(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => RequestDetailsPage(
                          //               request: requests[index],
                          //             ),
                          //           ),
                          //         );
                          //         //WashingDonePage
                          //         if (requests[index].status == 0) {
                          //           Navigator.push<void>(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) =>
                          //                   ProviderNewRequestPage(
                          //                 request: requests[index],
                          //               ),
                          //             ),
                          //           );
                          //         }
                          //         if (requests[index].status == 4) {
                          //           Navigator.push<void>(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) =>
                          //                   ProviderNewRequestPage(
                          //                 request: requests[index],
                          //               ),
                          //             ),
                          //           );
                          //         }
                          //         if (requests[index].status == 1) {
                          //           Navigator.push<void>(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) =>
                          //                   RequestDetailsPage(
                          //                 request: requests[index],
                          //               ),
                          //             ),
                          //           );
                          //         }
                          //         if (requests[index].status == 2) {
                          //           Navigator.push<void>(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) =>
                          //                   RequestDetailsPage(
                          //                 request: requests[index],
                          //               ),
                          //             ),
                          //           );
                          //         }
                          //       },
                          //       title: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             getNotification(
                          //               requests[index].status,
                          //               requests[index].userModel!.name,
                          //               requests[index].isConfired,
                          //               requests[index].isDisConfired,
                          //             ),
                          //           ),
                          //           // if (index == 0)
                          //           Text(
                          //             // '0:10',
                          //             '${DateTime.now().difference(
                          //                   requests[index].notificationDate ??
                          //                       DateTime.now(),
                          //                 ).inMinutes}:00',
                          //             style: TextStyle(
                          //               fontSize: 12.sp,
                          //               fontWeight: FontWeight.bold,
                          //               color: ColorName.primaryColor,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       leading:
                          //           LottieWidget(Assets.lottie.animation11),
                          //     ),
                          //     SizedBox(
                          //       height: 25.h,
                          //     )
                          //   ],
                          // );
                        },
                      ),
                    ),
                  ],
                );
              }

              if (state is PNCubitStateLoading) {
                return const Center(
                  child: Loader(),
                );
              }

              if (state is PNCubitStateError) {
                return Center(
                  child: Text(state.error.errorMessege),
                );
              }
              return const Center(child: Text('Notifications'));
            },
          ),
        ),
      ),
    );
  }
}
