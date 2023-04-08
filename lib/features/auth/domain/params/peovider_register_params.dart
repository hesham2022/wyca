import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

class RegisterProviderParams {
  RegisterProviderParams({
    required this.name,
    required this.email,
    required this.gender,
    required this.password,
    required this.fcm,
    required this.photo,
    required this.criminalFish,
    required this.address,
    required this.coordinates,
    required this.phoneNumber,
    required this.backId,
    required this.frontId,
  });

  final String name;
  final String email;
  final String gender;
  final String password;
  final String fcm;

  final String photo;
  final String criminalFish;
  final String address;
  final List<double> coordinates;
  final String backId;
  final String phoneNumber;
  final String frontId;

  RegisterProviderParams copyWith({
    String? name,
    String? email,
    String? gender,
    String? password,
    String? phoneNumber,
    String? fcm,
    String? photo,
    String? criminalFish,
    String? address,
    List<double>? coordinates,
    String? backId,
    String? frontId,
  }) {
    return RegisterProviderParams(
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      fcm: fcm ?? this.fcm,
      photo: photo ?? this.photo,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      criminalFish: criminalFish ?? this.criminalFish,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      backId: backId ?? this.backId,
      frontId: frontId ?? this.frontId,
    );
  }

  Future<Map<String, dynamic>> toMap() async {
  
    return <String, dynamic>{
      'name': name,
      'email': email,
      'gender': gender,
      'password': password,
      'phoneNumber': phoneNumber,
      'fcm': fcm,
      'photo': await MultipartFile.fromFile(
        photo,
        contentType: MediaType('image', 'jpeg'),
      ),
      'criminalFish': await MultipartFile.fromFile(
        criminalFish,
        contentType: MediaType('image', 'jpeg'),
      ),
      'address': address,
      'coordinates': coordinates,
      'backId': await MultipartFile.fromFile(
        backId,
        contentType: MediaType('image', 'jpeg'),
      ),
      'frontId': await MultipartFile.fromFile(
        frontId,
        contentType: MediaType('image', 'jpeg'),
      ),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'RegisterUserParams(name: $name, email: $email, gender: $gender, password: $password, fcm: $fcm, photo: $photo, criminalFish: $criminalFish, address: $address, coordinates: $coordinates, backId: $backId, frontId: $frontId)';
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterProviderParams &&
        other.name == name &&
        other.email == email &&
        other.gender == gender &&
        other.password == password &&
        other.fcm == fcm &&
        other.photo == photo &&
        other.criminalFish == criminalFish &&
        other.address == address &&
        listEquals(other.coordinates, coordinates) &&
        other.backId == backId &&
        other.frontId == frontId;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        password.hashCode ^
        fcm.hashCode ^
        photo.hashCode ^
        criminalFish.hashCode ^
        address.hashCode ^
        coordinates.hashCode ^
        backId.hashCode ^
        frontId.hashCode;
  }
}
