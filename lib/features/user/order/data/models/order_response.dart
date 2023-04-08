// To parse this JSON data, do
//
//     final OrderResponse = OrderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wyca/features/user/order/data/models/order_model.dart';

OrderResponse OrderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String OrderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  OrderResponse({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });
  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      results: List<OrderModel>.from(
        (json['results'] as List<dynamic>).map<OrderModel>(
          (dynamic j) => OrderModel.fromMap(j as Map<String, dynamic>),
        ),
      ),
      page: json['page'] as int,
      limit: json['limit'] as int,
      totalPages: json['totalPages'] as int,
      totalResults: json['totalResults'] as int,
    );
  }

  List<OrderModel> results;
  int page;
  int limit;
  int totalPages;
  int totalResults;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'results': List<dynamic>.from(
          results.map<Map<String, dynamic>>((x) => x.toMap()),
        ),
        'page': page,
        'limit': limit,
        'totalPages': totalPages,
        'totalResults': totalResults,
      };
}
