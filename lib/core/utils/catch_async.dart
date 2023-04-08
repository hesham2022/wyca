import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';

Future<Either<NetworkExceptions, T>> guardFuture<T>(
  Future<T> Function() future, {
  VoidCallback? failureCallBack,
}) async {
  try {
    return Right(await future());
  } on Exception catch (e, s) {
    if (e is DioError) {
      print(e.response);
    }
    print(e.toString() + s.toString());
    if (failureCallBack != null) {
      failureCallBack();
    }

    final networkExceptions = NetworkExceptions(e);

    return Left(networkExceptions);
  } catch (e, s) {
    if (e is DioError) {
      print(e.response);
    }
    print(e);
    print(s);
    if (failureCallBack != null) {
      failureCallBack();
    }

    return Left(NetworkExceptions(e));
  }
}

Either<NetworkExceptions, T> guard<T>(T Function<T>() body) {
  try {
    return Right(body());
  } on Exception catch (e) {
    return Left(NetworkExceptions(e));
  }
}
