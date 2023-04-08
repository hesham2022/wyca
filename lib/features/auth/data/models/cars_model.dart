import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class Car {
  Car({
    required this.photo,
    required this.number,
    required this.color,
    required this.type,
  });
  factory Car.fromJson(String source) =>
      Car.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      photo: map['photo'] as String? ?? '',
      number: map['number'] as String? ?? '',
      color: map['color'] as String? ?? '',
      type: map['type'] as String? ?? '',
    );
  }
  final String photo;
  final String number;
  final String color;
  final String type;

  Car copyWith({
    String? photo,
    String? number,
    String? color,
    String? type,
  }) {
    return Car(
      photo: photo ?? this.photo,
      number: number ?? this.number,
      color: color ?? this.color,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photo': photo,
      'number': number,
      'color': color,
      'type': type,
    };
  }

  Future<Map<String, dynamic>> toUpload() async {
    return <String, dynamic>{
      'photo': await MultipartFile.fromFile(
        File(photo).path,
        contentType: MediaType('image', 'jpeg'),
      ),
      'number': number,
      'color': color,
      'type': type,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Car(photo: $photo, number: $number, color: $color, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Car &&
        other.photo == photo &&
        other.number == number &&
        other.color == color &&
        other.type == type;
  }

  @override
  int get hashCode {
    return photo.hashCode ^ number.hashCode ^ color.hashCode ^ type.hashCode;
  }
}
