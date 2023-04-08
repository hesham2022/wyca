import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/core/routing/routes.gr.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';
import 'package:wyca/features/request/domain/params/craeet_request.dart';
import 'package:wyca/features/request/presentation/request_cubit.dart';
import 'package:wyca/features/user/adresses/presentation/pages/select_adress_screen.dart';
import 'package:wyca/features/user/order/presentation/bloc/order_bloc.dart';
import 'package:wyca/features/user/order/presentation/pages/isPackage_exist.dart';
import 'package:wyca/features/user/order/presentation/pages/payment_method_page.dart';
import 'package:wyca/features/user/order/presentation/widgets/location_app_bar.dart';
import 'package:wyca/features/user/order/presentation/widgets/location_item.dart';
import 'package:wyca/imports.dart';

class ChosseAdressePage extends StatefulWidget {
  const ChosseAdressePage({super.key, this.date, required this.packageId});
  final DateTime? date;
  final String packageId;
  @override
  State<ChosseAdressePage> createState() => _ChosseAdressePageState();
}

class _ChosseAdressePageState extends State<ChosseAdressePage> {
  late Address _currentAdress;
  @override
  void initState() {
    _currentAdress = (context.read<UserCubit>().state as UserCubitStateLoaded)
        .user
        .addresses
        .last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_currentAdress.description);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: LocationAppBar(),
      ),
      body: BlocConsumer<UserCubit, UserCubitState>(
        listener: (context, state) {
          if (state is UserCubitStateLoaded) {
            _currentAdress =
                (context.read<UserCubit>().state as UserCubitStateLoaded)
                    .user
                    .addresses
                    .last;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: kPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitile('All Addresses', color: Colors.black),
                  SizedBox(height: 15.h),
                  ...(state as UserCubitStateLoaded)
                      .user
                      .addresses
                      .map(
                        (e) => LocationItem(
                          adresses: e.address,
                          description: e.description,
                          value: e,
                          groupValue: _currentAdress,
                          onChanged: (value) {
                            setState(() {
                              _currentAdress = value!;
                            });
                          },
                        ),
                      )
                      .toList(),
                  LocationItem(
                    adresses: 'add new address',
                    value: Address(coordinates: const [], address: '', id: ''),
                    groupValue: _currentAdress,
                    onChanged: (value) async {
                      await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectAdressScreen(),
                        ),
                      );
                      // setState(() {});
                    },
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      final orders = (state as GetOrdersLoaded).orders.results;
                      print(orders);
                      final packages = orders.map((e) => e.package).toList();
                      final exist = packages.contains(
                        widget.packageId ??
                            context.read<OrderBloc>().idControoler.text,
                      );
                      return BlocListener<RequestCubit, RequestCubitState>(
                        listener: (context, state) {
                          if (state is RequestCubitStateSent) {
                            context.router.pushAndPopUntil(
                              CompleteRequestRoute(requestClass: state.request),
                              predicate: (r) => false,
                            );
                          }
                        },
                        child: AppButton(
                          h: 36.h,
                          title: (exist &&
                                  restOfWash(context, widget.packageId) != 0)
                              ? 'Service Requests'
                              : 'Next',
                          onPressed: () {
                            // context.read<OrderBloc>().idControoler.text
                            // if(){

                            // }
                            if (exist &&
                                restOfWash(context, widget.packageId) != 0) {
                              context.read<RequestCubit>().createRequest(
                                    CreateRequestParams(
                                      address: _currentAdress,
                                      date: widget.date,
                                      order: orders
                                          .firstWhere(
                                            (element) =>
                                                element.package ==
                                                widget.packageId,
                                          )
                                          .id,
                                    ),
                                  );
                            } else {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PaymentMethodPage(
                                      packageId: widget.packageId,
                                      address: _currentAdress,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
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
