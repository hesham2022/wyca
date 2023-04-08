import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/useCase/use_case.dart';
import 'package:wyca/features/user/order/data/models/order_model.dart';
import 'package:wyca/features/user/order/data/models/order_response.dart';
import 'package:wyca/features/user/order/domain/repositories/i_order_respository.dart';

import '../../data/repositories/order_repository.dart';

class GetOrders extends UseCase<OrderResponse, NoParams> {
  GetOrders(this.repository);
  final IOrderRespository repository;

  @override
  Future<Either<NetworkExceptions, OrderResponse>> call(
    NoParams params,
  ) async {
    return repository.getOrders();
  }
}

class CreateOrderUseCase extends UseCase<OrderModel, CreatOrderParam> {
  CreateOrderUseCase(this.repository);
  final IOrderRespository repository;

  @override
  Future<Either<NetworkExceptions, OrderModel>> call(
    CreatOrderParam params,
  ) async {
    return repository.createOrder(params);
  }
}
