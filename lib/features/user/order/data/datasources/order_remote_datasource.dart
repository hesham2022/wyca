import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/features/user/order/data/models/order_model.dart';
import 'package:wyca/features/user/order/data/models/order_response.dart';

abstract class IOrderRemote {
  IOrderRemote(this.apiConfig);
  final ApiClient apiConfig;

  Future<OrderResponse> getOrders();
  Future<OrderModel> createOrder(Map<String, dynamic> body);
}

class OrderRemote extends IOrderRemote {
  OrderRemote(super.apiConfig);

  @override
  Future<OrderResponse> getOrders() async {
    final response = await apiConfig.get(kOrder);
    final data = response.data as Map<String, dynamic>;
    final packageResult = OrderResponse.fromJson(data);
    return packageResult;
  }

  @override
  Future<OrderModel> createOrder(Map<String, dynamic> body) async {
    final response = await apiConfig.post(kOrder, body: body);
    final data = response.data as Map<String, dynamic>;
    final packageResult = OrderModel.fromMap(data);
    return packageResult;
  }
}
