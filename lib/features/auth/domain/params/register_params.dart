import 'dart:convert';

class RegisterUserParams {
  RegisterUserParams({
    required this.name,
    required this.email,
    required this.gender,
    required this.password,
    required this.phoneNumber,
    required this.fcm,
  });
  factory RegisterUserParams.fromJson(String source) =>
      RegisterUserParams.fromMap(json.decode(source) as Map<String, String>);

  factory RegisterUserParams.fromMap(Map<String, String> map) {
    return RegisterUserParams(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      fcm: map['fcm'] ?? '',
    );
  }

  final String name;
  final String email;
  final String gender;
  final String password;
  final String phoneNumber;

  final String fcm;
  RegisterUserParams copyWith({
    String? name,
    String? email,
    String? gender,
    String? phoneNumber,
    String? password,
    String? fcm,
  }) {
    return RegisterUserParams(
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fcm: fcm ?? this.fcm,
    );
  }

  String formatedPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      return '+2$phoneNumber';
    }
    if (phoneNumber.startsWith('2')) {
      return '+$phoneNumber';
    }
    return phoneNumber;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'gender': gender,
      'password': password,
      'phoneNumber': formatedPhoneNumber(phoneNumber),
      'fcm': fcm,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '''RegisterUserParams(name: $name, email: $email, gender: $gender, password: $password)''';
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterUserParams &&
        other.name == name &&
        other.email == email &&
        other.gender == gender &&
        other.fcm == fcm &&
        other.password == password;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ gender.hashCode ^ password.hashCode;
  }
}
