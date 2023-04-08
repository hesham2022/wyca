import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wyca/core/api_config/api_constants.dart';
import 'package:wyca/features/user/home/presentation/packages_bloc/packages_bloc.dart';
import 'package:wyca/features/user/home/presentation/pages/package_screem.dart';
import 'package:wyca/features/user/order/presentation/bloc/order_bloc.dart';
import 'package:wyca/imports.dart';

class YouBalancePage extends StatefulWidget {
  const YouBalancePage({super.key});

  @override
  State<YouBalancePage> createState() => _YouBalancePageState();
}

class _YouBalancePageState extends State<YouBalancePage> {
  bool pev = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackagesCubit, PackagesCubitState>(
      builder: (context, packageState) {
        if (packageState is PackagesCubitStateLoaded) {
          return BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is GetOrdersLoaded) {
                final washNumber = state.orders.results.fold<int>(
                  0,
                  (a, b) {
                    return a + b.washNumber;
                  },
                );
                final prevOrders = state.orders.results
                    .where((element) => element.washNumber == 0)
                    .toList();
                final activeOrders = state.orders.results
                    .where((element) => element.washNumber > 0)
                    .toList();
                return Scaffold(
                  appBar: appBar(
                    context,
                    context.l10n.myBalace,
                  ),
                  body: Padding(
                    padding: kPadding,
                    child: Column(
                      children: [
                        SectionTitile(context.l10n.currentBalance),
                        SizedBox(
                          height: 40.h,
                        ),
                        Column(
                          children: [
                            Text(
                              washNumber.toString(),
                              style: kHead1Style.copyWith(
                                fontSize: 30.sp,
                                height: .1,
                              ),
                            ),
                            Text(
                              context.l10n.wash,
                              style: kBody1Style.copyWith(
                                fontSize: 16.sp,
                                color: ColorName.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        // AppButton(
                        //   h: 36.h,
                        //   title: context.l10n.addBalance,
                        //   onPressed: () {},
                        // ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                title: context.l10n.previousPurchases,
                                titleColor: pev ? null : primaryColor,
                                color: pev ? null : Colors.white,
                                onPressed: () {
                                  setState(() {
                                    pev = true;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: AppButton(
                                title: 'Active Packages',
                                titleColor: !pev ? null : primaryColor,
                                color: !pev ? null : Colors.white,
                                onPressed: () {
                                  setState(() {
                                    pev = !true;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (pev && prevOrders.isEmpty)
                          const Center(
                            child: Text('No Pervious Orders'),
                          ),
                        if (!pev && activeOrders.isEmpty)
                          const Center(
                            child: Text('No Active Orders'),
                          ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final selectedOrder =
                                  pev ? prevOrders[index] : activeOrders[index];
                              final slelctedPackage = [
                                ...packageState.packages,
                                ...packageState.featuredPackages
                              ].firstWhere(
                                (element) =>
                                    element.id == selectedOrder.package,
                              );
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PackageScreen(
                                        package: slelctedPackage,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      width: 68.h,
                                      height: 68.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            kImagePackage +
                                                slelctedPackage.image,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        color: ColorName.primaryColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    SizedBox(width: 10.w, height: 0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            slelctedPackage.name,
                                            style: kHead1Style.copyWith(
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('MMM dd, yyyy')
                                                .format(DateTime.now()),
                                            style: kBody1Style.copyWith(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount:
                                pev ? prevOrders.length : activeOrders.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
