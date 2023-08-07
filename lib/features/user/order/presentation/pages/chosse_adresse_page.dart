import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/core/routing/routes.gr.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';
import 'package:wyca/features/request/domain/params/craeet_request.dart';
import 'package:wyca/features/request/presentation/request_cubit.dart';
import 'package:wyca/features/user/adresses/presentation/pages/select_adress_screen.dart';
import 'package:wyca/features/user/order/presentation/bloc/order_bloc.dart';
import 'package:wyca/features/user/order/presentation/pages/isPackage_exist.dart';
import 'package:wyca/features/user/order/presentation/pages/payment_method_page.dart';
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
  Address? _currentAdress;
  @override
  void initState() {
    // context.read<OrderBloc>().add(const RequestOrders());
    _currentAdress = (context.read<UserCubit>().state as UserCubitStateLoaded)
            .user
            .addresses
            .isEmpty
        ? null
        : (context.read<UserCubit>().state as UserCubitStateLoaded)
            .user
            .addresses
            .last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.chose_address,
        ),
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
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .25,
                  child: Lottie.asset('assets/lottie/location_select.json'),
                ),
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
                      child: Center(
                        child: AppButton(
                          h: 36.h,
                          title: (exist &&
                                  restOfWash(context, widget.packageId) != 0)
                              ? context.l10n.serviceRequest
                              : context.l10n.next,
                          onPressed: () {
                            if (_currentAdress == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    context.l10n.pleaseSelectAddress,
                                  ),
                                ),
                              );
                              return;
                            }

                            if (exist &&
                                restOfWash(context, widget.packageId) != 0) {
                              final all = orders.where(
                                (element) =>
                                    element.package == widget.packageId &&
                                    element.washNumber > 0,
                              );
                              String? selectedOrder;
                              if (all.isNotEmpty) {
                                selectedOrder = all.first.id;
                              } else {
                                selectedOrder = orders
                                    .firstWhere(
                                      (element) =>
                                          element.package == widget.packageId,
                                    )
                                    .id;
                              }

                              context.read<RequestCubit>().createRequest(
                                    CreateRequestParams(
                                      address: _currentAdress!,
                                      date: widget.date,
                                      order: selectedOrder,
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
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
