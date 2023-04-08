// ignore: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/features/user/order/data/models/order_model.dart';
import 'package:wyca/features/user/order/data/models/order_response.dart';

import '../../data/repositories/order_repository.dart';

// ignore: one_member_abstracts
abstract class IOrderRespository {
  Future<Either<NetworkExceptions, OrderResponse>> getOrders();
  Future<Either<NetworkExceptions, OrderModel>> createOrder(
    CreatOrderParam package,
  );
}
