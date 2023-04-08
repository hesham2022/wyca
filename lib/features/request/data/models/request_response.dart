// To parse this JSON data, do
//
//     final OrderResponse = OrderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/user/order/data/models/order_model.dart';

RequestResponse RequestResponseFromJson(String str) =>
    RequestResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String RequestResponseToJson(RequestResponse data) =>
    json.encode(data.toJson());

class RequestResponse {
  RequestResponse({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });
  factory RequestResponse.fromJson(Map<String, dynamic> json) {
    return RequestResponse(
      results: List<RequestClass>.from(
        (json['results'] as List<dynamic>).map<RequestClass>(
          (dynamic j) => RequestClass.fromMap(j as Map<String, dynamic>),
        ),
      ),
      page: json['page'] as int,
      limit: json['limit'] as int,
      totalPages: json['totalPages'] as int,
      totalResults: json['totalResults'] as int,
    );
  }

  List<RequestClass> results;
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
