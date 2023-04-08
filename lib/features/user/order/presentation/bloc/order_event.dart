part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class RequestOrders extends OrderEvent {
  const RequestOrders();
}

class CreateOrder extends OrderEvent {
  const CreateOrder(this.package, this.paymentMethod);
  final String package;
  final String paymentMethod;
}
