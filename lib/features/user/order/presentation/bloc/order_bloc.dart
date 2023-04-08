import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wyca/core/api_errors/index.dart';
import 'package:wyca/core/useCase/use_case.dart';
import 'package:wyca/core/utils/strings_colors.dart';
import 'package:wyca/features/user/order/data/models/order_model.dart';
import 'package:wyca/features/user/order/data/models/order_response.dart';
import 'package:wyca/features/user/order/data/repositories/order_repository.dart';
import 'package:wyca/features/user/order/domain/usecases/get_orders_usecase.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required this.getOrders, required this.createOrder})
      : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
    on<RequestOrders>((event, emit) async {
      emit(GetOrdersLoading());
      final result = await getOrders(NoParams());
      result.fold(
        (l) => emit(GetOrdersFailure(l)),
        (r) => emit(GetOrdersLoaded(r)),
      );
      print(StringColors.red + state.toString());
    });
    on<CreateOrder>(
      (event, emit) async {
        final previoseRespose = (state as GetOrdersLoaded).orders;
        final result = await createOrder(
          CreatOrderParam(
            package: event.package,
            paymentMethod: event.paymentMethod,
          ),
        );
        emit(GetOrdersLoading());

        result.fold(
          (l) {
            emit(GetOrdersFailure(l));
          },
          (r) {
            if (r.paymentLink != null) {
              emit(CreateOrderSuccessStateWithPayLink(r));
            } else {
              emit(CreateOrderSuccessState(r));
            }
            previoseRespose.results.add(r);
            emit(GetOrdersLoaded(previoseRespose));
          },
        );
      },
    );
  }
  final GetOrders getOrders;
  final CreateOrderUseCase createOrder;

  final TextEditingController idControoler = TextEditingController();
}
