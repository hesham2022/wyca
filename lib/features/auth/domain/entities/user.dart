import 'package:wyca/features/auth/data/models/cars_model.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';

class User {
  const User({
    required this.gender,
    required this.role,
    required this.isEmailVerified,
    required this.name,
    required this.email,
    required this.fcm,
    required this.addresses,
    required this.id,
    required this.cars,
    this.points,
  });
  static const User empty = User(
    gender: '',
    role: '',
    isEmailVerified: false,
    name: '',
    email: '',
    fcm: '',
    addresses: [],
    cars: [],
    id: '',
  );
  UserModel toModel() => UserModel(
        gender: gender,
        role: role,
        isEmailVerified: isEmailVerified,
        name: name,
        email: email,
        fcm: fcm,
        addresses: addresses,
        cars: cars,
        id: id,
        points: points,
      );
  final String gender;
  final String role;
  final bool isEmailVerified;
  final String name;
  final String email;
  final String fcm;
  final List<Address> addresses;
  final List<Car> cars;
  final int? points;
  final String id;
  @override
  String toString() {
    return 'name: $name email: $email id: $id role: $role gender: $gender ';
  }

  User copyWith({
    String? gender,
    String? role,
    bool? isEmailVerified,
    String? name,
    String? email,
    String? fcm,
    List<Address>? addresses,
    List<Car>? cars,
    String? id,
    int? points,
  }) {
    return User(
      gender: gender ?? this.gender,
      role: role ?? this.role,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      name: name ?? this.name,
      email: email ?? this.email,
      fcm: fcm ?? this.fcm,
      addresses: addresses ?? this.addresses,
      id: id ?? this.id,
      cars: cars ?? this.cars,
      points: points ?? this.points,
    );
  }
}
