// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:wyca/features/auth/data/models/user_model.dart';

class Provider {
  const Provider({
    required this.gender,
    required this.role,
    required this.isEmailVerified,
    required this.name,
    required this.email,
    required this.fcm,
    required this.id,
    required this.address,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.active,
    required this.criminalFish,
    required this.photo,
    required this.frontId,
    required this.backId,
    required this.balance
  });

  static Provider empty = Provider(
    balance: 0,
    gender: '',
    role: '',
    isEmailVerified: false,
    name: '',
    email: '',
    fcm: '',
    id: '',
    active: false,
    address: Address(
      coordinates: [],
      address: '',
      id: '',
    ),
    backId: '',
    criminalFish: '',
    frontId: '',
    photo: '',
    ratingsAverage: 0,
    ratingsQuantity: 0,
  );

  final String gender;
  final String role;
  final bool isEmailVerified;
  final String name;
  final String email;
  final String fcm;
  final String id;

  final Address address;
  final double ratingsAverage;
  final int ratingsQuantity;
  final bool active;
  final double balance;
  final String criminalFish;
  final String photo;
  final String frontId;
  final String backId;
  @override
  String toString() {
    return 'Provider(gender: $gender, role: $role, isEmailVerified: $isEmailVerified, name: $name, email: $email, fcm: $fcm, id: $id, address: $address, ratingsAverage: $ratingsAverage, ratingsQuantity: $ratingsQuantity, active: $active, criminalFish: $criminalFish, photo: $photo, frontId: $frontId, backId: $backId)';
  }

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
    double? balance
  }) {
    return Provider(
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
      balance: balance ?? this.balance
    );
  }

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
