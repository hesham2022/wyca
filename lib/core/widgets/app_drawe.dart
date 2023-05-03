import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/auth/presentation/pages/user_type_screen.dart';
import 'package:wyca/features/introduction/pages/splash_screen.dart';
import 'package:wyca/imports.dart';

class AppDrawerModel {
  AppDrawerModel({
    required this.title,
    required this.icon,
    this.page,
    this.iconBoxColor,
    this.onTap,
  });
  final String title;
  final Widget icon;
  final Color? iconBoxColor;
  final Widget? page;
  final VoidCallback? onTap;
}

class AppBrawer extends StatelessWidget {
  const AppBrawer({
    super.key,
    required this.items,
  });
  final List<AppDrawerModel> items;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(
                left: 36.sp,
                right: 20.sp,
                top: 20.sp,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Assets.images.drawerLogo.image(
                          height: 180.h,
                          width: 180.h,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            child: Assets.svg.drawerExit.svg(),
                          )
                        ],
                      )
                    ],
                  ),
                  ...items.map(
                    (item) => SizedBox(
                      height: 55.h,
                      child: InkWell(
                        onTap: item.onTap ??
                            () async {
                              Navigator.pop<void>(
                                context,
                              );
                              await Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => item.page!,
                                ),
                              );
                            },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3.sp),
                                  height: 23.h,
                                  width: 23.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: item.iconBoxColor ??
                                        ColorName.primaryColor,
                                  ),
                                  child: item.icon,
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Text(
                                  item.title,
                                  style: kSemiBoldStyle.copyWith(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            // Visibility(
                            //   visible: item.page != null,
                            //   child: Assets.svg.deawerArrwo.svg(),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        kUserType = '';
                        Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SplashScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: InkWell(
                        onTap: () => context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequested()),
                        child: Row(
                          children: [
                            Assets.drawerIcons.logout.svg(),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              context.l10n.logout,
                              style: kSemiBoldStyle.copyWith(
                                fontSize: 17.sp,
                                color: const Color(0xff1A0405),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
