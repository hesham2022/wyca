import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/utils/catch_async.dart';
import 'package:wyca/features/request/data/datasources/request_remote.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/data/models/request_response.dart';
import 'package:wyca/features/request/domain/params/acceptParams.dart';
import 'package:wyca/features/request/domain/params/complete_params.dart';
import 'package:wyca/features/request/domain/params/craeet_request.dart';
import 'package:wyca/features/request/domain/params/rate.dart';
import 'package:wyca/features/request/domain/repositories/i_request_reoository.dart';

class RequestRepository extends IRequestRespository {
  RequestRepository(this.requestRemote);
  final IRequestRemote requestRemote;

  @override
  Future<Either<NetworkExceptions, RequestClass>> createOrder(
    CreateRequestParams params,
  ) =>
      guardFuture<RequestClass>(
        () => requestRemote.createRequest(params.toMap()),
      );
  @override
  Future<Either<NetworkExceptions, RequestClass>> singleRequest(
    String params,
  ) =>
      guardFuture<RequestClass>(
        () => requestRemote.singleReuest(params),
      );
  @override
  Future<Either<NetworkExceptions, RequestClass>> rate(
    RatingParams params,
  ) =>
      guardFuture<RequestClass>(
        () => requestRemote.rate(params),
      );
  @override
  Future<Either<NetworkExceptions, RequestClass>> acceptRequest(
    AcceptParams params,
  ) =>
      guardFuture<RequestClass>(
        () => requestRemote.acceptRequest(params),
      );
  @override
  Future<Either<NetworkExceptions, RequestClass>> cancelRequest(
    String params,
  ) =>
      guardFuture<RequestClass>(
        () => requestRemote.cancelRequest(params),
      );
  @override
  Future<Either<NetworkExceptions, RequestClass>> tryAgainRequest(
    String params,
  ) =>
      guardFuture<RequestClass>(
        () => requestRemote.tryAgainRequest(params),
      );
        @override
  Future<Either<NetworkExceptions, RequestClass>> confirmRequest(
    String params,
  ) =>
      guardFuture<RequestClass>(
        () => requestRemote.confirmRequest(params),
      );  @override
  Future<Either<NetworkExceptions, RequestClass>> disconfirmRequest(
    String params,
  ) =>
      guardFuture<RequestClass>(
        () => requestRemote.disconfirmRequest(params),
      );
  @override
  Future<Either<NetworkExceptions, RequestResponse>> getRequests() =>
      guardFuture<RequestResponse>(
        requestRemote.getRequests,
      );
  @override
  Future<Either<NetworkExceptions, RequestClass>> startRequest(
    String params,
  ) =>
      guardFuture<RequestClass>(
        () => requestRemote.startRequest(params),
      );
  @override
  Future<Either<NetworkExceptions, RequestClass>> doneRequest(
    String params,
  ) =>
      guardFuture<RequestClass>(
        () => requestRemote.doneRequest(params),
      );

  @override
  Future<Either<NetworkExceptions, RequestClass>> complete(
    CompleteRequestParams params,
  ) {
    return guardFuture<RequestClass>(
      () => requestRemote.completeRequest(params),
    );
  }
}
