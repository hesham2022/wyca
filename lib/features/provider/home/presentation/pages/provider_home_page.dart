import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/app/view/app.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/language_dialouge.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/domain/params/toggle_active_params.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/auth/presentation/bloc/provider_cubit.dart';
import 'package:wyca/features/companmy_setting/presentation/pages/calling_page.dart';
import 'package:wyca/features/provider/about_us/presentation/pages/about_us_page.dart';
import 'package:wyca/features/provider/branches/presentation/pages/branches_page.dart';
import 'package:wyca/features/provider/how_to_wash_car/pages/provider_how_wash_page.dart';
import 'package:wyca/features/provider/notification/presentation/pages/provider_notification_page.dart';
import 'package:wyca/features/provider/provider_balance/presentation/pages/provider_balance_page.dart';
import 'package:wyca/features/user/home/presentation/pages/setting_provider_screen.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/l10n/l10n.dart';

class ProviderHomePage extends StatefulWidget {
  const ProviderHomePage({super.key});

  @override
  State<ProviderHomePage> createState() => _ProviderHomePageState();
}

class _ProviderHomePageState extends State<ProviderHomePage> {
  @override
  void initState() {
    super.initState();
  }

  bool off = false;
  void toggleOff() {
    setState(() {
      off = !off;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppBrawer(
        items: [
          AppDrawerModel(
            title: context.l10n.settings,
            icon: Assets.drawerIcons.icons8Settings.svg(
              color: Colors.white,
            ),
            page: const SettingProviderPage(),
          ),
          AppDrawerModel(
            title: context.l10n.howToWashCar,
            icon: Assets.drawerIcons.heart.svg(
              color: Colors.white,
            ),
            page: const ProviderHowWashPage(),
          ),
          AppDrawerModel(
            title: context.l10n.branched,
            icon: Assets.drawerIcons.shoppingBagSvgrepoCom.svg(
              color: Colors.white,
            ),
            page: const BranchesPage(),
          ),

          // AppDrawerModel(
          //   title: context.l10n.notifications,
          //   icon: Assets.drawerIcons.alarm.svg(
          //     color: Colors.white,
          //   ),
          //   page: const ProviderNotificationPage(),
          // ),
          AppDrawerModel(
            title: context.l10n.balance,
            icon: Assets.drawerIcons.pay.image(
              color: Colors.white,
            ),
            page: const ProviderBalancePage(),
          ),
          AppDrawerModel(
            title: context.l10n.language,
            iconBoxColor: Colors.white,
            //  icon: Assets.drawerIcons.icons8GoogleTranslate.svg(),
            icon: Assets.drawerIcons.languageIcon.image(),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (_) => const LanguageDialuge(),
              );
            },
          ),

          // AppDrawerModel(
          //   title: context.l10n.paymentMethods,
          //   icon: Assets.drawerIcons.pay.image(
          //     color: Colors.white,
          //   ),
          //   page: const ProviderPaymentMethods(),
          // ),
          AppDrawerModel(
            title: context.l10n.contactUs,
            icon: Assets.drawerIcons.headphone.svg(
              color: Colors.white,
            ),
            page: const CallingPage(),
          ),
          // AppDrawerModel(
          //   title: context.l10n.aboutUs,
          //   icon: Assets.drawerIcons.icons8Lock.svg(
          //     color: Colors.white,
          //   ),
          //   page: const AboutUsPage(),
          // ),
          AppDrawerModel(
            title: context.l10n.termsAndConditions,
            icon: Assets.drawerIcons.icons8Note64.image(
              color: Colors.white,
            ),
            page: const AboutUsPage(),
          ), //Ambient Space
          // AppDrawerModel(
          //   title: context.l10n.ambiantSpace,
          //   icon: Assets.drawerIcons.icons8Note64.image(
          //     color: Colors.white,
          //   ),
          //   page: const AmbientSpacePage(),
          // ), //Ambient Space
        ],
      ),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: kPadding.copyWith(top: 0, bottom: 30.sp),
            child: BlocBuilder<ProviderCubit, ProviderCubitState>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: Assets.svg.menu.svg(
                                  height: 16.sp,
                                  width: 20.sp,
                                ),
                              ),
                              Assets.images.logo.image(
                                width: 114.w,
                                height: 114.h,
                              ),
                              BlocBuilder<NotificationsBudgeCubit, int>(
                                // buildWhen: (previous, current) => index == 3,
                                builder: (context, state) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProviderNotificationPage(),
                                            ),
                                          );
                                          context
                                              .read<NotificationsBudgeCubit>()
                                              .read();
                                        },
                                        icon: Assets.svg.bill.svg(
                                          height: 25.sp,
                                          width: 25.sp,
                                        ),
                                      ),
                                      if (state == 0)
                                        const SizedBox()
                                      else
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                          ),
                                          child: Positioned(
                                            top: -10,
                                            right: -4,
                                            child: Text(
                                              state.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  );
                                },
                              )
                              // IconButton(
                              //   padding: EdgeInsets.zero,
                              //   onPressed: () {
                              //     Navigator.push<void>(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             const ProviderNotificationPage(),
                              //       ),
                              //     );
                              //   },
                              //   icon: Assets.svg.bill.svg(
                              //     height: 16.sp,
                              //     width: 16.sp,
                              //   ),
                              // ),
                            ],
                          ),
                          WelcomWidget(
                            name: (state as ProviderCubitStateLoaded)
                                .provider
                                .name,
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                          if (state.provider.active)
                            LottieWidget(
                              key: const Key('11'),
                              Assets.lottie.animation10,
                              height: 244.h,
                              width: 244.w,
                            )
                          else
                            LottieWidget(
                              key: const Key('13'),
                              Assets.lottie.animation13,
                              height: 244.h,
                              width: 244.w,
                            ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            !state.provider.active
                                ? context.l10n.readyToReciveToday
                                : context.l10n.areYouFinishedToday,
                            style: kHead1Style.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // TextButton(
                          //   onPressed: () async {
                          //     await AwesomeNotifications().createNotification(
                          //       content: NotificationContent(
                          //         id: 978123,
                          //         channelKey: 'basic_channel',
                          //         title: 'hello',
                          //       ),
                          //     );
                          //   },
                          //   child: const Text('Show Button'),
                          // ),
                          AppButton(
                            h: 36.h,
                            title: !state.provider.active
                                ? context.l10n.turnOn
                                : context.l10n.turnOff,
                            onPressed: () {
                              context.read<AuthenticationBloc>().add(
                                    ToggleProviderActive(
                                      ToggleActiveParams(
                                        active: !state.provider.active,
                                      ),
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
