import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/utils/catch_async.dart';
import 'package:wyca/features/user/order/data/datasources/order_remote_datasource.dart';
import 'package:wyca/features/user/order/data/models/order_model.dart';
import 'package:wyca/features/user/order/data/models/order_response.dart';
import 'package:wyca/features/user/order/domain/repositories/i_order_respository.dart';

class OrderRepository extends IOrderRespository {
  OrderRepository(this.orderRemote);
  final IOrderRemote orderRemote;

  @override
  Future<Either<NetworkExceptions, OrderResponse>> getOrders() =>
      guardFuture<OrderResponse>(orderRemote.getOrders);

  @override
  Future<Either<NetworkExceptions, OrderModel>> createOrder(CreatOrderParam package) =>
      guardFuture<OrderModel>(
        () => orderRemote.createOrder(package.toMap()),
      );
}

class CreatOrderParam {
  final String package;
  final String paymentMethod;
  CreatOrderParam({
    required this.package,
    required this.paymentMethod,
  });
  

  CreatOrderParam copyWith({
    String? package,
    String? paymentMethod,
  }) {
    return CreatOrderParam(
      package: package ?? this.package,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'package': package,
      'paymentMethod': paymentMethod,
    };
  }



}
