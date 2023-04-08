
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GetNearParams {
  GetNearParams({
    required this.coordinates,
  });
  factory GetNearParams.fromJson(String source) =>
      GetNearParams.fromMap(json.decode(source) as Map<String, dynamic>);

  factory GetNearParams.fromMap(Map<String, dynamic> map) {
    return GetNearParams(
      coordinates: List<double>.from(map['coordinates'] as List),
    );
  }
  final List<double> coordinates;

  GetNearParams copyWith({
    List<double>? coordinates,
  }) {
    return GetNearParams(
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coordinates': coordinates,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'GetNearParams(coordinates: $coordinates)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetNearParams && listEquals(other.coordinates, coordinates);
  }

  @override
  int get hashCode => coordinates.hashCode;
}
