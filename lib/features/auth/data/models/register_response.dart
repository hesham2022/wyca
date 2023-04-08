import 'dart:convert';

import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/domain/entities/register_response.dart';

RegisterUserResponseModel registerUserResponseModelFromJson(String str) =>
    RegisterUserResponseModel.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

String registerUserResponseModelToJson(RegisterUserResponseModel data) =>
    json.encode(data.toJson());

class RegisterUserResponseModel extends RegisterUserResponse {
  RegisterUserResponseModel({
    required super.user,
    required super.tokens,
  });

  factory RegisterUserResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserResponseModel(
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        tokens: Tokens.fromJson(json['tokens'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user': user.toJson(),
        'tokens': tokens.toJson(),
      };
}

class Tokens {
  Tokens({
    required this.access,
    required this.refresh,
  });
  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: Access.fromJson(json['access'] as Map<String, dynamic>),
        refresh: Access.fromJson(json['refresh'] as Map<String, dynamic>),
      );

  Access access;
  Access refresh;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'access': access.toJson(),
        'refresh': refresh.toJson(),
      };
}

class Access {
  Access({
    required this.token,
    required this.expires,
  });
  factory Access.fromJson(Map<String, dynamic> json) => Access(
        token: json['token'] as String,
        expires: DateTime.parse(json['expires'] as String),
      );

  String token;
  DateTime expires;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'token': token,
        'expires': expires.toIso8601String(),
      };
}
