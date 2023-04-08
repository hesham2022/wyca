// ignore_for_file: avoid_dynamic_calls, cast_nullable_to_non_nullable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:wyca/features/auth/data/models/cars_model.dart';
import 'package:wyca/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.gender,
    required super.role,
    required super.isEmailVerified,
    required super.name,
    required super.email,
    required super.fcm,
    required super.addresses,
    required super.id,
    required super.cars,
    super.points,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      gender: json['gender'] as String,
      role: json['role'] as String,
      isEmailVerified: json['isEmailVerified'] as bool,
      name: json['name'] as String,
      email: json['email'] as String,
      fcm: json['fcm'] as String,
      points: json['points'] as int?,
      addresses: (json['addresses'] as List).isEmpty
          ? []
          : List<Address>.from(
              (json['addresses'] as List<dynamic>)
                  .map<Address>(Address.fromJson),
            ),
      cars: (json['cars'] as List).isEmpty
          ? []
          : List<Car>.from(
              (json['cars'] as List<dynamic>).map<Car>(
                (dynamic j) => Car.fromMap(j as Map<String, dynamic>),
              ),
            ),
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'gender': gender,
        'role': role,
        'isEmailVerified': isEmailVerified,
        'name': name,
        'email': email,
        'fcm': fcm,
        'points': points,
        'addresses': List<Map<String, dynamic>>.from(
          addresses.map<Map<String, dynamic>>(
            (Address e) => e.toJson(),
          ),
        ),
        'cars': List<Map<String, dynamic>>.from(
          cars.map<Map<String, dynamic>>(
            (Car e) => e.toMap(),
          ),
        ),
        'id': id,
      };
}

Address addressFromJson(String str) =>
    Address.fromJson(json.decode(str) as Map<String, dynamic>);

String addressToJson(Address data) => json.encode(data.toJson());

class Address extends Equatable {
  Address({
    required this.coordinates,
    required this.address,
    required this.id,
    this.description,
  });

  factory Address.fromJson(dynamic json) {
    return Address(
      coordinates: List<double>.from(
        (json['coordinates'] as List<dynamic>).map<dynamic>(
          (dynamic x) {
            return double.tryParse(x.toString()) as double;
          },
        ),
      ),
      address: json['address'] as String,
      id: json['_id'] as String? ?? '',
      description: json['description'] as String?,
    );
  }

  List<double> coordinates;
  String address;
  String id;
  String? description;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'coordinates': List<dynamic>.from(coordinates.map<double>((x) => x)),
        'address': address,
        'type': 'Point',
        'description': description
      };

  @override
  List<Object?> get props => [address, description];
}

