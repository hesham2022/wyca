// ignore: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/data/models/request_response.dart';
import 'package:wyca/features/request/domain/params/acceptParams.dart';
import 'package:wyca/features/request/domain/params/complete_params.dart';
import 'package:wyca/features/request/domain/params/craeet_request.dart';
import 'package:wyca/features/request/domain/params/rate.dart';

// ignore: one_member_abstracts
abstract class IRequestRespository {
  Future<Either<NetworkExceptions, RequestClass>> createOrder(
    CreateRequestParams params,
  );
  Future<Either<NetworkExceptions, RequestClass>> singleRequest(
    String params,
  );
  Future<Either<NetworkExceptions, RequestClass>> acceptRequest(
    AcceptParams params,
  );
  Future<Either<NetworkExceptions, RequestClass>> cancelRequest(
    String params,
  );
  Future<Either<NetworkExceptions, RequestClass>> tryAgainRequest(
    String params,
  );
  Future<Either<NetworkExceptions, RequestClass>> confirmRequest(
    String params,
  );
  Future<Either<NetworkExceptions, RequestClass>> disconfirmRequest(
    String params,
  );
  Future<Either<NetworkExceptions, RequestResponse>> getRequests();
  Future<Either<NetworkExceptions, RequestClass>> startRequest(
    String params,
  );
  Future<Either<NetworkExceptions, RequestClass>> doneRequest(
    String params,
  );
  Future<Either<NetworkExceptions, RequestClass>> rate(
    RatingParams params,
  );
  Future<Either<NetworkExceptions, RequestClass>> complete(
    CompleteRequestParams params,
  );
}
