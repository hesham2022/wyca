import 'dart:convert';

class ForgetPasswordParam {
  ForgetPasswordParam({
    this.email,
    this.phoneNumber,
  });
  factory ForgetPasswordParam.fromJson(String source) => ForgetPasswordParam.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ForgetPasswordParam.fromMap(Map<String, dynamic> map) {
    return ForgetPasswordParam(
      email: map['email'] as String,
    );
  }
  final String? email;
  final String? phoneNumber;

  ForgetPasswordParam copyWith({
    String? email,
  }) {
    return ForgetPasswordParam(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (email != null) map['email'] = email;
    if (phoneNumber != null) map['phoneNumber'] = phoneNumber;

    return map;
    return <String, dynamic>{
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'ForgetPasswordParam(email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ForgetPasswordParam && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}
