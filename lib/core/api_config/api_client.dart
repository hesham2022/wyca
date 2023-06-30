import 'package:dio/dio.dart';
import 'package:wyca/app/app.dart';

class ApiClient {
  Dio dio = Dio();
  String? token;
  void init(String? newToken) {
    token = newToken;
    if (token != null) {
      dio.interceptors.clear();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            print('_____________');
            print(options.data);
            options.headers['Authorization'] = 'Bearer $token';
            options.headers['lang'] = kLang;

            return handler.next(options); //continue
          },
          onResponse: (response, handler) {
            return handler.next(response); // continue
          },
          onError: (DioError e, handler) {
            return handler.next(e); //continue
          },
        ),
      );
    }
  }

  Future<Response> get(String url, {Map<String, dynamic>? queryParams}) async {
    queryParams ??= <String, String>{'': ''};
    return dio.get<Map<String, dynamic>>(
      url,
      queryParameters: queryParams,
    );
  }

  Future<Response> post(
    String url, {
    Map<String, dynamic>? queryParams,
    required dynamic body,
  }) async {
    queryParams ??= <String, String>{'': ''};

    print(body);
    final r = await dio.post<dynamic>(
      url,
      data: body,
      queryParameters: queryParams,
    );
    return r;
  }

  Future<Response> upload(
    String url, {
    Map<String, dynamic>? queryParams,
    required Map<String, dynamic> body,
  }) async {
    queryParams ??= <String, String>{'': ''};
    print(body);
    final r = await dio.post<Map<String, dynamic>>(
      url,
      data: FormData.fromMap(body),
      queryParameters: queryParams,
    );
    return r;
  }

  Future<Response> put(
    String url, {
    Map<String, dynamic>? queryParams,
    required Map<String, dynamic> body,
  }) async {
    queryParams ??= <String, String>{'': ''};
    return dio.put<Response>(
      url,
      data: body,
      queryParameters: queryParams,
    );
  }

  Future<Response> patch(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  }) async {
    queryParams ??= <String, String>{'': ''};
    return dio.patch<Map<String, dynamic>>(
      url,
      data: body,
      queryParameters: queryParams,
    );
  }

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  }) async {
    return dio.delete<Map<String, dynamic>>(
      url,
      data: body,
    );
  }

  Future<Response> patchUpload(
    String url, {
    Map<String, dynamic>? queryParams,
    dynamic body,
  }) async {
    queryParams ??= <String, String>{'': ''};
    return dio.patch<Map<String, dynamic>>(
      url,
      data: body,
      queryParameters: queryParams,
    );
  }
}
