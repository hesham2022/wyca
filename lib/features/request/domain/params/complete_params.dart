import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class CompleteRequestParams {
  CompleteRequestParams({
    required this.note,
    required this.cars,
    required this.id,
  });
  final String id;
  final String note;
  final List<String> cars;
  Future<FormData> toMap() async {
    final map = <String, dynamic>{'note': note, 'id': id};
    final formData = FormData.fromMap(map);
    for (final file in cars) {
      formData.files.addAll([
        MapEntry(
          'photo',
          await MultipartFile.fromFile(
            file,
            contentType: MediaType('image', 'jpeg'),
          ),
        ),
      ]);
    }

    return formData;
  }
}
