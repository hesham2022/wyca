// To parse this JSON data, do
//
//     final providerRegisterationResponse = providerRegisterationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wyca/features/auth/data/models/register_response.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/domain/entities/provider_entity.dart';

ProviderRegisterationResponse providerRegisterationResponseFromJson(
  String str,
) =>
    ProviderRegisterationResponse.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

String providerRegisterationResponseToJson(
  ProviderRegisterationResponse data,
) =>
    json.encode(data.toJson());

class ProviderRegisterationResponse {
  ProviderRegisterationResponse({
    required this.user,
    required this.tokens,
  });
  factory ProviderRegisterationResponse.fromJson(Map<String, dynamic> json) =>
      ProviderRegisterationResponse(
        user: ProviderModel.fromMap(json['user'] as Map<String, dynamic>),
        tokens: Tokens.fromJson(json['tokens'] as Map<String, dynamic>),
      );

  final ProviderModel user;
  final Tokens tokens;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user': user.toJson(),
        'tokens': tokens.toJson(),
      };
}

class ProviderModel extends Provider {
  const ProviderModel({
    required super.gender,
    required super.role,
    required super.isEmailVerified,
    required super.name,
    required super.email,
    required super.fcm,
    required super.id,
    required super.address,
    required super.ratingsAverage,
    required super.ratingsQuantity,
    required super.active,
    required super.criminalFish,
    required super.photo,
    required super.frontId,
    required super.backId,
    required super.balance,
  });
  factory ProviderModel.fromJson(String source) =>
      ProviderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ProviderModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return ProviderModel(
      gender: map['gender'] as String,
      role: map['role'] as String,
      isEmailVerified: map['isEmailVerified'] as bool,
      name: map['name'] as String,
      email: map['email'] as String,
      fcm: map['fcm'] as String,
      id: map['id'] as String,
      address: Address.fromJson(map['address'] as Map<String, dynamic>),
      ratingsAverage: map['ratingsAverage'] as double,
      ratingsQuantity: map['ratingsQuantity'] as int,
      active: map['active'] as bool,
      criminalFish: map['criminalFish'] as String,
      photo: map['photo'] as String,
      frontId: map['frontId'] as String,
      backId: map['backId'] as String,
      balance: ((map['balance'] ?? 0) as num).toDouble(),
    );
  }
  static Provider empty = Provider(
    gender: '',
    role: '',
    isEmailVerified: false,
    name: '',
    email: '',
    fcm: '',
    id: '',
    active: false,
    address: Address(coordinates: const [], address: '', id: ''),
    backId: '',
    criminalFish: '',
    frontId: '',
    photo: '',
    ratingsAverage: 0,
    ratingsQuantity: 0,
    balance: 0,
  );

  @override
  String toString() {
    return 'Provider(gender: $gender, role: $role, isEmailVerified: $isEmailVerified, name: $name, email: $email, fcm: $fcm, id: $id, address: $address, ratingsAverage: $ratingsAverage, ratingsQuantity: $ratingsQuantity, active: $active, criminalFish: $criminalFish, photo: $photo, frontId: $frontId, backId: $backId)';
  }

  @override
  Provider copyWith({
    String? gender,
    String? role,
    bool? isEmailVerified,
    String? name,
    String? email,
    String? fcm,
    String? id,
    Address? address,
    double? ratingsAverage,
    int? ratingsQuantity,
    bool? active,
    String? criminalFish,
    String? photo,
    String? frontId,
    String? backId,
    double? balance,
  }) {
    return ProviderModel(
      gender: gender ?? this.gender,
      role: role ?? this.role,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      name: name ?? this.name,
      email: email ?? this.email,
      fcm: fcm ?? this.fcm,
      id: id ?? this.id,
      address: address ?? this.address,
      ratingsAverage: ratingsAverage ?? this.ratingsAverage,
      ratingsQuantity: ratingsQuantity ?? this.ratingsQuantity,
      active: active ?? this.active,
      criminalFish: criminalFish ?? this.criminalFish,
      photo: photo ?? this.photo,
      frontId: frontId ?? this.frontId,
      backId: backId ?? this.backId,
      balance: balance ?? this.balance,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gender': gender,
      'role': role,
      'isEmailVerified': isEmailVerified,
      'name': name,
      'email': email,
      'fcm': fcm,
      'id': id,
      'address': address.toJson(),
      'ratingsAverage': ratingsAverage,
      'ratingsQuantity': ratingsQuantity,
      'active': active,
      'criminalFish': criminalFish,
      'photo': photo,
      'frontId': frontId,
      'backId': backId,
      'balance': balance
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Provider &&
        other.gender == gender &&
        other.role == role &&
        other.isEmailVerified == isEmailVerified &&
        other.name == name &&
        other.email == email &&
        other.fcm == fcm &&
        other.id == id &&
        other.address == address &&
        other.ratingsAverage == ratingsAverage &&
        other.ratingsQuantity == ratingsQuantity &&
        other.active == active &&
        other.criminalFish == criminalFish &&
        other.photo == photo &&
        other.frontId == frontId &&
        other.backId == backId;
  }

  @override
  int get hashCode {
    return gender.hashCode ^
        role.hashCode ^
        isEmailVerified.hashCode ^
        name.hashCode ^
        email.hashCode ^
        fcm.hashCode ^
        id.hashCode ^
        address.hashCode ^
        ratingsAverage.hashCode ^
        ratingsQuantity.hashCode ^
        active.hashCode ^
        criminalFish.hashCode ^
        photo.hashCode ^
        frontId.hashCode ^
        backId.hashCode;
  }
}
