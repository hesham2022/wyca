import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:wyca/app/customer_service/view/customer_service_view.dart';
import 'package:wyca/app/view/app.dart';
import 'package:wyca/core/api_config/api_constants.dart';
import 'package:wyca/core/routing/routes.gr.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/language_dialouge.dart';
import 'package:wyca/core/widgets/package_dropdown.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';
import 'package:wyca/features/companmy_setting/presentation/pages/about_us.dart';
import 'package:wyca/features/companmy_setting/presentation/pages/calling_page.dart';
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

Future<void> onNotificationCreatedMethod(
  ReceivedAction receivedNotification,
) async {
  if (appRouter.current.name == NotificationsPageRoute.name) {
    return;
  }
  // if NotificationsPageRoute is not in the stack push it

  await appRouter.push(const NotificationsPageRoute());
}

class _HomePAGEState extends State<HomePAGE> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<OrderBloc>().add(const RequestOrders());
    if (widget.requestClass != null) {
      Future<void>.delayed(Duration.zero, () {
        showRatePopUp(
          context,
          id: widget.requestClass!.id,
          provider: widget.requestClass!.provider!,
        );
      });
    }
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onNotificationCreatedMethod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: Assets.svg.menu.svg(
            height: 16.sp,
            width: 20.sp,
          ),
        ),
        actions: [
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
                          builder: (context) => const NotificationsPage(),
                        ),
                      );
                      context.read<NotificationsBudgeCubit>().read();
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
                      child: Text(
                        state.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              );
            },
          ),
        ],
        title: Assets.images.logo.image(
          width: 114.w,
          height: 114.h,
        ),
      ),
      drawer: AppBrawer(
        items: [
          AppDrawerModel(
            title: 'Profile',
            icon: const Icon(
              Icons.person,
              size: 20,
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
          AppDrawerModel(
            title: context.l10n.language,
            iconBoxColor: Colors.white,
            icon: Assets.drawerIcons.languageIcon.image(),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (_) => const LanguageDialuge(),
              );
            },
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
          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 300,
                            child: HomeCursorSlider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: SectionTitile(
                              '${context.l10n.orderNow} 🔥',
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child:
                                BlocBuilder<PackagesCubit, PackagesCubitState>(
                              builder: (context, state) {
                                final items =
                                    (state as PackagesCubitStateLoaded)
                                        .packages;
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
                                    context
                                        .read<OrderBloc>()
                                        .idControoler
                                        .text = value!.id;
                                  },
                                  hint: context.l10n.chooseService,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: AppButton(
                                    title: context.l10n.orderNow,
                                    onPressed: () async {
                                      if (context
                                          .read<OrderBloc>()
                                          .idControoler
                                          .text
                                          .isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              context
                                                  .l10n.pleaseSelectOnePackage,
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      final permissionStatus =
                                          await NotificationPermissions
                                              .getNotificationPermissionStatus();
                                      if (permissionStatus !=
                                          PermissionStatus.granted) {
                                        await Future.delayed(const Duration(),
                                            () async {
                                          final result =
                                              await showDialog<bool?>(
                                            context: context,
                                            builder: (c) {
                                              return Dialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .35,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .8,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 20,
                                                          bottom: 10,
                                                        ),
                                                        child: Text(
                                                          'Enable Notifications',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 20,
                                                          left: 20,
                                                          right: 20,
                                                        ),
                                                        child: Text(
                                                          'Please enable notification to get updates about your order',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 10,
                                                        ),
                                                        child: AppButton(
                                                          w: 100.w,
                                                          title: 'Enable',
                                                          onPressed: () async {
                                                            final result =
                                                                await NotificationPermissions
                                                                    .requestNotificationPermissions();
                                                            if (result ==
                                                                PermissionStatus
                                                                    .granted) {
                                                              Navigator.pop(
                                                                c,
                                                                true,
                                                              );
                                                            } else {
                                                              Navigator.pop(
                                                                c,
                                                                false,
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                          if (result == true) {
                                            await Future.delayed(Duration.zero,
                                                () async {
                                              await Navigator.push<void>(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChosseAdressePage(
                                                    packageId: context
                                                        .read<OrderBloc>()
                                                        .idControoler
                                                        .text,
                                                  ),
                                                ),
                                              );
                                            });
                                          }
                                        });
                                        return;
                                      }
                                      await Future.delayed(Duration.zero,
                                          () async {
                                        await Navigator.push<void>(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChosseAdressePage(
                                              packageId: context
                                                  .read<OrderBloc>()
                                                  .idControoler
                                                  .text,
                                            ),
                                          ),
                                        );
                                      });
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
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: SectionTitile(
                              context.l10n.packages,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 230,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                              ),
                              itemCount: currentState.packages.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  try {
                                    final currentAdress = (context
                                            .read<UserCubit>()
                                            .state as UserCubitStateLoaded)
                                        .user
                                        .addresses
                                        .last;

                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PackageScreen(
                                          package: currentState.packages[index],
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    showLocationDialog(context);
                                  }
                                },
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      6,
                                    ),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: cashedImage(
                                          url: kImagePackage +
                                              currentState
                                                  .packages[index].image,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: autoSizeText(
                                            text: currentState
                                                .packages[index].description,
                                            fontWeight: FontWeight.w600,
                                            size: 18,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: autoSizeText(
                                            text:
                                                '${currentState.packages[index].price} ${context.l10n.le}',
                                            color: ColorName.primaryColor,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorName.primaryColor,
        child: SvgPicture.asset(
          'assets/svg/message.svg',
          width: 35,
        ),
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomerService(),
              // const AboutUsPage(),
            ),
          );
        },
      ),
    );
  }
}

Future<void> showLocationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context, barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          context.l10n.sorry,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                context.l10n.selectYourLocation,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              context.l10n.selectLocation,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdressesPage(),
                ),
              );
            },
          ),
          TextButton(
            child: Text(
              context.l10n.cancel,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
