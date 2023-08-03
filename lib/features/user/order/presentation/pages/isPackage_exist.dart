import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/features/user/order/presentation/bloc/order_bloc.dart';

bool isPackageExist(BuildContext context, String id) {
  final state = context.read<OrderBloc>().state;
  if (state is GetOrdersLoaded) {
    final orders = state.orders.results;
    final packages = orders.map((e) => e.package).toList();
    return packages.contains(
      id,
    );
  }
  return false;
}

int restOfWash(BuildContext context, String id) {
  final state = context.read<OrderBloc>().state;
  if (state is GetOrdersLoaded) {
    final orders = state.orders.results;

    final packages = orders.map((e) => e.package).toList();
    if (packages.contains(
      id,
    )) {
      final all = orders
          .where((element) => element.package == id && element.washNumber > 0)
          .toList();
      if (all.isEmpty) {
        return orders.firstWhere((element) => element.package == id).washNumber;
      } else {
        return all
            .map((e) => e.washNumber)
            .reduce((value, element) => value + element);
      }
    }
  }
  return 0;
}
