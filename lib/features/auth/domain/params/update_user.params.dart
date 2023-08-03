import 'dart:convert';

import 'package:wyca/app/view/app.dart';
import 'package:wyca/features/auth/domain/entities/provider_entity.dart';
import 'package:wyca/features/auth/domain/entities/user.dart';

class UpdateUserParameter {
  UpdateUserParameter({
    required this.user,
    this.password,
  });

  final User user;
  final String? password;

  UpdateUserParameter copyWith({
    User? user,
    String? password,
  }) {
    return UpdateUserParameter(
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (password != null) 'password': password,
      'email': user.email,
      'name': user.name,
      'gender': user.gender,
      'fcm': kFcm,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'UpdateUserParameter(user: $user, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdateUserParameter &&
        other.user == user &&
        other.password == password;
  }

  @override
  int get hashCode => user.hashCode ^ password.hashCode;
}

class UpdateProviderParameter {
  UpdateProviderParameter({
    required this.provider,
    this.password,
  });

  final Provider provider;
  String? password;

  UpdateProviderParameter copyWith({
    Provider? provider,
    String? password,
  }) {
    return UpdateProviderParameter(
      provider: provider ?? this.provider,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (password != null) 'password': password,
      'email': provider.email,
      'name': provider.name,
      'gender': provider.gender,
      'fcm': kFcm,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'UpdateUserParameter(user: $provider, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdateProviderParameter &&
        other.provider == provider &&
        other.password == password;
  }

  @override
  int get hashCode => provider.hashCode ^ password.hashCode;
}
