import 'dart:convert';

class ToggleActiveParams {
  ToggleActiveParams({
    required this.active,
  });
  factory ToggleActiveParams.fromJson(String source) =>
      ToggleActiveParams.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ToggleActiveParams.fromMap(Map<String, dynamic> map) {
    return ToggleActiveParams(
      active: map['active'] as bool? ?? false,
    );
  }
  final bool active;

  ToggleActiveParams copyWith({
    bool? active,
  }) {
    return ToggleActiveParams(
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'active': active,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'ToggleActiveParams(active: $active)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ToggleActiveParams && other.active == active;
  }

  @override
  int get hashCode => active.hashCode;
}
