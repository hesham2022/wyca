import 'dart:convert';

class ProviderLocation {
  ProviderLocation({
    required this.coordinates,
  });
  factory ProviderLocation.fromMap(Map<String, dynamic> map) {
    return ProviderLocation(
      coordinates: List<double>.from(
        (map['coordinates'] as List).map<double>(
          (
            dynamic e,
          ) =>
              double.parse(e.toString()),
        ),
      ),
    );
  }
  factory ProviderLocation.fromJson(String source) =>
      ProviderLocation.fromMap(json.decode(source) as Map<String, dynamic>);
  Map<String, dynamic> toMap() => <String, dynamic>{'coordinates': coordinates};
  final List<double> coordinates;

  ProviderLocation copyWith({
    List<double>? coordinates,
  }) {
    return ProviderLocation(
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
