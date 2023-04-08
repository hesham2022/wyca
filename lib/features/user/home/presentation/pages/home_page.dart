import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/app/view/app.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/language_dialouge.dart';
import 'package:wyca/core/widgets/package_dropdown.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';
import 'package:wyca/features/companmy_setting/presentation/pages/about_us.dart';
import 'package:wyca/features/companmy_setting/presentation/pages/calling_page.dart';
import 'package:wyca/features/provider/about_us/presentation/pages/about_us_page.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/user/adresses/presentation/pages/adresses_page.dart';
import 'package:wyca/features/user/home/presentation/packages_bloc/packages_bloc.dart';
import 'package:wyca/features/user/home/presentation/pages/package_screem.dart';
import 'package:wyca/features/user/home/presentation/pages/setting_screen.dart';
import 'package:wyca/features/user/home/presentation/widgets/home_cursol_slider.dart';
import 'package:wyca/features/user/home/presentation/widgets/home_item.dart';
import 'package:wyca/features/user/mycars/presentation/pages/my_cars_page.dart';
import 'package:wyca/features/user/notifications/presentation/pages/notifications_page.dart';
import 'package:wyca/features/user/order/presentation/bloc/order_bloc.dart';
import 'package:wyca/features/user/order/presentation/pages/chosse_adresse_page.dart';
import 'package:wyca/features/user/order/presentation/pages/order_later_screen.dart';
import 'package:wyca/features/user/points/presentaion/pages/my_points_screen.dart';
import 'package:wyca/features/user/request_accepted/presentaion/pages/washing_done_page.dart';
import 'package:wyca/features/user/your_balance/presentation/pages/you_balance_page.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/gen/colors.gen.dart';
import 'package:wyca/l10n/l10n.dart';

class HomePAGE extends StatefulWidget {
  const HomePAGE({super.key, this.requestClass});
  final RequestClass? requestClass;
  @override
  State<HomePAGE> createState() => _HomePAGEState();
}

class _HomePAGEState extends State<HomePAGE> {
  @override
  void initState() {
    context.read<OrderBloc>().add(const RequestOrders());
    if (widget.requestClass != null) {
      Future<void>.delayed(Duration.zero,(){
         showRatePopUp(
        context,
        id: widget.requestClass!.id,
        provider: widget.requestClass!.provider!,
      );
      });
     
    }
    super.initState();
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
            page: const SettingPage(),
          ),
          AppDrawerModel(
            title: context.l10n.myPoints,
            icon: Assets.drawerIcons.heart.svg(
              color: Colors.white,
            ),
            page: const MyPointsScreen(),
          ),
          AppDrawerModel(
            title: context.l10n.myAdresses,
            icon: Assets.drawerIcons.shoppingBagSvgrepoCom.svg(
              color: Colors.white,
            ),
            page: const AdressesPage(),
          ),
          // AppDrawerModel(
          //   title: context.l10n.notifications,
          //   icon: Assets.drawerIcons.alarm.svg(
          //     color: Colors.white,
          //   ),
          //   page: const NotificationsPage(),
          // ),
          AppDrawerModel(
            title: context.l10n.balance,
            icon: Assets.drawerIcons.pay.image(
              color: Colors.white,
            ),
            page: const YouBalancePage(),
          ),
          AppDrawerModel(
            title: context.l10n.myCars,
            icon: Assets.drawerIcons.icons8Note64.image(
              color: Colors.white,
            ),
            page: const MyCarsPage(),
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

          AppDrawerModel(
            title: context.l10n.contactUs,
            icon: Assets.drawerIcons.headphone.svg(
              color: Colors.white,
            ),
            page: const CallingPage(),
          ),
          AppDrawerModel(
            title: context.l10n.termsAndConditions,
            icon: Assets.svg.hand.svg(
              color: Colors.white,
            ),
            page: const AboutUs(),
          ),
          // AppDrawerModel(
          //   title: 'Wash Control',
          //   icon: Assets.drawerIcons.icons8Lock.svg(
          //     color: Colors.white,
          //   ),
          //   page: const WashControllerPage(),
          // ),
        ],
      ),
      body: BlocBuilder<PackagesCubit, PackagesCubitState>(
        builder: (context, state) {
          if (state is PackagesCubitStateLoading) {
            return const Center(
              child: Loader(),
            );
          }
          if (state is PackagesCubitStateError) {
            return Center(
              child: Text(state.error.errorMessege),
            );
          }
          final currentState = state as PackagesCubitStateLoaded;
          return Padding(
            padding: kPadding.copyWith(top: 0, bottom: 30.sp),
            child: CustomScrollView(
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
                                              const NotificationsPage(),
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
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          BlocBuilder<UserCubit, UserCubitState>(
                            builder: (context, state) {
                              if (state is UserCubitStateLoaded) {
                                return RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${context.l10n.hello}, ',
                                        style: kSemiBoldStyle.copyWith(
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ${state.user.name},',
                                        style: kBody1Style.copyWith(
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return const Loader();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          LottieWidget(
                            height: 68.h,
                            width: 68.h,
                            Assets.lottie.animation3,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.l10n.ourPorividersOnYourWay,
                                style: kHead1Style.copyWith(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                              AppButton(
                                w: 224.w,
                                h: 36.h,
                                title: context.l10n.details,
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          // const NearesProviderScreen(),
                                          const AboutUsPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      )

                      ///
                      ,
                      SizedBox(
                        height: 20.h,
                      ),
                      SectionTitile(
                        context.l10n.offers,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // Page View offers
                      const HomeCursolSlider(),

                      SizedBox(
                        height: 20.h,
                      ),
                      SectionTitile(
                        context.l10n.orderNow,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      BlocBuilder<PackagesCubit, PackagesCubitState>(
                        builder: (context, state) {
                          final items =
                              (state as PackagesCubitStateLoaded).packages;
                          return PackageDropDownField(
                            package: context
                                    .read<OrderBloc>()
                                    .idControoler
                                    .text
                                    .isEmpty
                                ? null
                                : items.firstWhere(
                                    (element) =>
                                        element.id ==
                                        context
                                            .read<OrderBloc>()
                                            .idControoler
                                            .text,
                                  ),
                            initialValue: context
                                    .read<OrderBloc>()
                                    .idControoler
                                    .text
                                    .isEmpty
                                ? null
                                : items.firstWhere(
                                    (element) =>
                                        element.id ==
                                        context
                                            .read<OrderBloc>()
                                            .idControoler
                                            .text,
                                  ),
                            items: [...items],
                            onChanged: (value) {
                              context.read<OrderBloc>().idControoler.text =
                                  value!.id;
                            },
                            hint: context.l10n.chooseService,
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: AppButton(
                              title: context.l10n.orderNow,
                              onPressed: () {
                                if (context
                                    .read<OrderBloc>()
                                    .idControoler
                                    .text
                                    .isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        context.l10n.pleaseSelectOnePackage,
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChosseAdressePage(
                                      packageId: context
                                          .read<OrderBloc>()
                                          .idControoler
                                          .text,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Flexible(
                            child: AppButton(
                              color: Colors.white,
                              titleColor: ColorName.primaryColor,
                              title: context.l10n.orderLater,
                              onPressed: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderLaterScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SectionTitile(
                        context.l10n.packages,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      // Packages
                      SizedBox(
                        height: 200.h,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PackageScreen(
                                    package: currentState.packages[index],
                                  ),
                                ),
                              );
                            },
                            child: HomeItem(
                              package: currentState.packages[index],
                            ),
                          ),
                          itemCount: currentState.packages.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
