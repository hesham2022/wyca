part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class GetOrdersLoading extends OrderState {}

class CreateOrderSuccessState extends OrderState {
  const CreateOrderSuccessState(this.order);
  final OrderModel order;
}
class CreateOrderSuccessStateWithPayLink extends OrderState {
  const CreateOrderSuccessStateWithPayLink(this.order);
  final OrderModel order;
}


class GetOrdersLoaded extends OrderState {
  const GetOrdersLoaded(this.orders);

  final OrderResponse orders;
}

class GetOrdersFailure extends OrderState {
  const GetOrdersFailure(this.error);

  final NetworkExceptions error;
}
