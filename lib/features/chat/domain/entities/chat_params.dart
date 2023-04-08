import 'dart:convert';

class CreateChatParams {
  CreateChatParams({
    required this.user,
    required this.provider,
  });
  factory CreateChatParams.fromJson(String source) =>
      CreateChatParams.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CreateChatParams.fromMap(Map<String, dynamic> map) {
    return CreateChatParams(
      user: map['user'] as String,
      provider: map['provider'] as String,
    );
  }
  final String user;
  final String provider;

  CreateChatParams copyWith({
    String? user,
    String? provider,
  }) {
    return CreateChatParams(
      user: user ?? this.user,
      provider: provider ?? this.provider,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'provider': provider,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CreateChatParams(user: $user, provider: $provider)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateChatParams &&
        other.user == user &&
        other.provider == provider;
  }

  @override
  int get hashCode => user.hashCode ^ provider.hashCode;
}
