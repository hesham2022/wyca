import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/app/view/app.dart';

class LoginParam {
  LoginParam({
    required this.password,
    this.email,
    this.phoneNumber,
  });
  factory LoginParam.fromJson(String str) =>
      LoginParam.fromMap(json.decode(str) as Map<String, String>);

  factory LoginParam.fromMap(Map<String, dynamic> json) => LoginParam(
        password: json['password'] as String,
        email: json['email'] as String,
      );
  String toJson() => json.encode(toMap());

  final String password;
  final String? phoneNumber;

  final String? email;

  LoginParam copyWith({
    String? password,
    String? email,
    String? fcm,
  }) =>
      LoginParam(
        password: password ?? this.password,
        email: email ?? this.email,
      );

  // Map<String, dynamic> toMap() => <String, dynamic>{'password': password, 'email': email, 'fcm': fcm};
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'password': password, 'fcm': kFcm};
    if (email != null) {
      if (email!.isNotEmpty) {
        map.addAll(<String, dynamic>{'email': email});
      }
    }
    if (phoneNumber != null) {
      if (phoneNumber!.isNotEmpty) {
        map.addAll(<String, dynamic>{'phoneNumber': phoneNumber});
      }
    }
    return map;
  }
}
