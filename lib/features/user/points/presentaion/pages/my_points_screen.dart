import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';
import 'package:wyca/features/user/home/presentation/packages_bloc/packages_bloc.dart';
import 'package:wyca/imports.dart';

class MyPointsScreen extends StatefulWidget {
  const MyPointsScreen({super.key});

  @override
  State<MyPointsScreen> createState() => _MyPointsScreenState();
}

class _MyPointsScreenState extends State<MyPointsScreen> {
  @override
  void initState() {
    context.read<UserCubit>().getMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserCubitState>(
      builder: (context, state) {
        if (state is UserCubitStateLoaded) {
          return BlocBuilder<PackagesCubit, PackagesCubitState>(
            builder: (context, packageState) {
              if (packageState is PackagesCubitStateLoaded) {
                final packages = packageState.packages.where(
                  (element) => element.byPoint != null,
                );
                return Scaffold(
                  appBar: AppBar(
                    title: Text(context.l10n.myPoints),
                  ),
                  body: Padding(
                    padding: kPadding,
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 50.h,
                        // ),
                        Lottie.asset(
                          Assets.lottie.animation12,
                          height: 90,
                          width: 120,
                        ),
                        Column(
                          children: [
                            Text(
                              (state.user.points ?? 0).toString(),
                              style: kHead1Style.copyWith(
                                fontSize: 30.sp,
                              ),
                            ),
                            Text(
                              context.l10n.points,
                              style: kBody1Style.copyWith(
                                fontSize: 16.sp,
                                color: ColorName.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        AppButton(
                          h: 36.h,
                          title: context.l10n.replace,
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SectionTitile(
                          context.l10n.exchangeDetails,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ...packages.map(
                          (e) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                Assets.svg.exchange.svg(
                                  height: 25.h,
                                  width: 25.h,
                                  color: ColorName.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '${e.byPoint} ${context.l10n.points}',
                                        style: kBody1Style.copyWith(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' = ',
                                        style: kBody1Style.copyWith(
                                          fontSize: 16.sp,
                                          color: ColorName.primaryColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '1 ${e.name}',
                                        style: kSemiBoldStyle.copyWith(
                                          fontSize: 16.sp,
                                          color: ColorName.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          );
        }
        if (state is UserCubitStateLoading) {
          return const Center(
            child: Loader(),
          );
        }
        if (state is UserCubitStateError) {
          return Center(
            child: Text(state.error.errorMessege),
          );
        }
        return const SizedBox();
      },
    );
  }
}
