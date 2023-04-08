// To parse this JSON data, do
//
//     final PackageResponse = PackageResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wyca/features/user/home/domain/entities/package.dart';

PackageResponse packageResponseFromJson(String str) =>
    PackageResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String packageResponseToJson(PackageResponse data) =>
    json.encode(data.toJson());

class PackageResponse {
  PackageResponse({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });
  factory PackageResponse.fromJson(Map<String, dynamic> json) {
    return PackageResponse(
      results: List<PackageModel>.from(
        (json['results'] as List<dynamic>).map<PackageModel>(
          (dynamic j) => PackageModel.fromJson(j as Map<String, dynamic>),
        ),
      ),
      page: json['page'] as int,
      limit: json['limit'] as int,
      totalPages: json['totalPages'] as int,
      totalResults: json['totalResults'] as int,
    );
  }

  List<PackageModel> results;
  int page;
  int limit;
  int totalPages;
  int totalResults;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'results': List<dynamic>.from(
          results.map<Map<String, dynamic>>((x) => x.toJson()),
        ),
        'page': page,
        'limit': limit,
        'totalPages': totalPages,
        'totalResults': totalResults,
      };
}

class PackageModel extends Package {
  PackageModel({
    required super.isOffer,
    required super.name,
    required super.price,
    required super.priceDiscount,
    required super.washNumber,
    required super.description,
    required super.image,
    required super.features,
    required super.id,
    required super.byPoint,
  });
  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        isOffer: json['isOffer'] as bool,
        name: json['name'] as String,
        price: json['price'] as int,
        priceDiscount: json['priceDiscount'] as int,
        washNumber: json['washNumber'] as int,
        description: json['description'] as String,
        image: json['image'] as String,
        byPoint: json['byPoint'] as int?,
        features: List<Feature>.from(
          (json['features'] as List<dynamic>).map<Feature>(
            (dynamic j) => Feature.fromJson(j as Map<String, dynamic>),
          ),
        ),
        id: json['id'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'isOffer': isOffer,
        'name': name,
        'price': price,
        'priceDiscount': priceDiscount,
        'washNumber': washNumber,
        'description': description,
        'image': image,
        'byPoint': byPoint,
        'features': List<dynamic>.from(
          features.map<Map<String, dynamic>>((x) => x.toJson()),
        ),
        'id': id,
      };
}

class Feature {
  Feature({
    required this.id,
    required this.title,
    required this.description,
  });
  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json['_id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
      );

  final String id;
  final String title;
  final String description;

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'title': title,
        'description': description,
      };
}
