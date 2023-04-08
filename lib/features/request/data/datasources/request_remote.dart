import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/data/models/request_response.dart';
import 'package:wyca/features/request/domain/params/acceptParams.dart';
import 'package:wyca/features/request/domain/params/complete_params.dart';
import 'package:wyca/features/request/domain/params/rate.dart';

abstract class IRequestRemote {
  IRequestRemote(this.apiConfig);
  final ApiClient apiConfig;

  Future<RequestClass> createRequest(Map<String, dynamic> body);
  Future<RequestClass> rate(RatingParams params);

  Future<RequestClass> acceptRequest(AcceptParams params);
  Future<RequestClass> cancelRequest(String params);
  Future<RequestClass> tryAgainRequest(String params);

  Future<RequestClass> singleReuest(String params);

  Future<RequestClass> startRequest(String params);
  Future<RequestClass> confirmRequest(String params);
  Future<RequestClass> disconfirmRequest(String params);

  Future<RequestResponse> getRequests();

  Future<RequestClass> doneRequest(String params);
  Future<RequestClass> completeRequest(CompleteRequestParams params);
}

class RequestRemote extends IRequestRemote {
  RequestRemote(super.apiConfig);

  @override
  Future<RequestClass> createRequest(Map<String, dynamic> body) async {
    print(body);
    final result = await apiConfig.post(kRequest, body: body);
    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestClass> acceptRequest(AcceptParams params) async {
    final result =
        await apiConfig.patch('$kRequest/${params.id}', body: params.toMap());

    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestClass> cancelRequest(String params) async {
    print('$kRequest/$params/cancel');

    final result = await apiConfig.patch('$kRequest/$params/cancel');
    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestClass> confirmRequest(String params) async {
    print('$kRequest/$params/confirm');

    final result = await apiConfig.patch('$kRequest/$params/confirm');
    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestClass> disconfirmRequest(String params) async {
    print('$kRequest/$params/disconfirmRequest');

    final result = await apiConfig.patch('$kRequest/$params/disconfirm');
    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestClass> tryAgainRequest(String params) async {
    final result = await apiConfig.patch('$kRequest/$params/try');
    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestClass> singleReuest(String params) async {
    final result = await apiConfig.get('$kRequest/$params');

    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestResponse> getRequests() async {
    final result = await apiConfig.get(kRequest);

    return RequestResponse.fromJson(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestClass> completeRequest(CompleteRequestParams params) async {
    final result = await apiConfig.patchUpload(
      '$kRequest/${params.id}/complete',
      body: await params.toMap(),
    );

    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestClass> startRequest(String params) async {
    final result = await apiConfig.patch('$kRequest/$params/start');

    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestClass> doneRequest(String params) async {
    final result = await apiConfig.patch('$kRequest/$params/done');

    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }

  @override
  Future<RequestClass> rate(RatingParams params) async {
    final result = await apiConfig.post(kRate, body: params.toMap());

    return RequestClass.fromMap(result.data as Map<String, dynamic>);
  }
}
