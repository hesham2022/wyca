import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/local_storage/secure_storage_instance.dart';
import 'package:wyca/core/local_storage/token_storage.dart';
import 'package:wyca/core/utils/catch_async.dart';
import 'package:wyca/features/auth/data/datasources/auth_remote.dart';
import 'package:wyca/features/auth/domain/params/forget_password_params.dart';
import 'package:wyca/features/auth/domain/params/login_params.dart';
import 'package:wyca/features/auth/domain/params/peovider_register_params.dart';
import 'package:wyca/features/auth/domain/params/register_params.dart';
import 'package:wyca/features/auth/domain/params/reset_password_params.dart';
import 'package:wyca/features/auth/domain/params/verify_forgt_otp.dart';
import 'package:wyca/features/auth/domain/repositories/i_respository.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  AuthenticationRepository({
    required this.authenticationLocalDataSource,
    required this.authRemotDataSource,
    required super.apiConfig,
  }) : _apiConfig = apiConfig;
  final ApiClient _apiConfig;

  final ITokenStorage authenticationLocalDataSource;
  final IAuthUserRemotDataSource authRemotDataSource;

  @override
  final controller = StreamController<AuthenticationStatus>.broadcast();

  @override
  Stream<AuthenticationStatus> get status async* {
    final token = await authenticationLocalDataSource.getToken();
    final userType = await Storage.getUserType() ?? 'user';

    if (token == null) {
      yield AuthenticationStatus.unauthenticated;
    } else {
      _apiConfig.init(token);
      if (userType == 'user') {
        yield AuthenticationStatus.authenticated;
      } else {
        yield AuthenticationStatus.authenticatedProvider;
      }
    }

    yield* controller.stream;
  }

  @override
  Future<Either<NetworkExceptions, void>> logIn(
    LoginParam loginParams,
  ) =>
      guardFuture(
        () async {
          final loginResponse =
              (await authRemotDataSource.login(loginParams.toMap()))!;

          _apiConfig.init(loginResponse.tokens.access.token);
          await authenticationLocalDataSource
              .saveToken(loginResponse.tokens.access.token);
          await Storage.setIsFirst();
          await Storage.setPassword(loginParams.password);
          await Storage.setUserType('user');
          controller.add(AuthenticationStatus.authenticated);
        },
        failureCallBack: () =>
            controller.add(AuthenticationStatus.unauthenticated),
      );
  @override
  Future<Either<NetworkExceptions, void>> logInProvider(
    LoginParam loginParams,
  ) =>
      guardFuture(
        () async {
          final loginResponse =
              (await authRemotDataSource.loginProvider(loginParams.toMap()))!;

          _apiConfig.init(loginResponse.tokens.access.token);
          await authenticationLocalDataSource
              .saveToken(loginResponse.tokens.access.token);
          await Storage.setIsFirst();
          await Storage.setPassword(loginParams.password);
          await Storage.setUserType('provider');
          controller.add(AuthenticationStatus.authenticatedProvider);
        },
        failureCallBack: () =>
            controller.add(AuthenticationStatus.unauthenticated),
      );
  @override
  Future<void> logOut() async {
    await authenticationLocalDataSource.deletToken();
    _apiConfig.init(null);

    controller.add(AuthenticationStatus.unauthenticated);
    await Storage.removePassword();
  }

  @override
  Future<Either<NetworkExceptions, void>> signIn(
    RegisterUserParams signParams,
  ) =>
      guardFuture(
        () async {
          final loginResponse =
              (await authRemotDataSource.signUp(signParams.toMap()))!;
          _apiConfig.init(loginResponse.tokens.access.token);
          await authenticationLocalDataSource
              .saveToken(loginResponse.tokens.access.token);
          await Storage.setIsFirst();
          await Storage.setPassword(signParams.password);
          await Storage.setUserType('user');
          controller.add(AuthenticationStatus.authenticatedAfterSignup);
        },
        failureCallBack: () =>
            controller.add(AuthenticationStatus.authenticated),
      );

  @override
  Future<Either<NetworkExceptions, void>> signInProvider(
    RegisterProviderParams signParams,
  ) {
    return guardFuture(
      () async {
        final loginResponse = (await authRemotDataSource
            .signUpProvider(await signParams.toMap()))!;
        _apiConfig.init(loginResponse.tokens.access.token);
        await authenticationLocalDataSource
            .saveToken(loginResponse.tokens.access.token);
        await Storage.setIsFirst();
        await Storage.setPassword(signParams.password);
        await Storage.setUserType('provider');
        controller.add(AuthenticationStatus.authenticatedProvider);
      },
      failureCallBack: () =>
          controller.add(AuthenticationStatus.unauthenticated),
    );
  }

  @override
  Future<Either<NetworkExceptions, String>> forgotPassword(
    ForgetPasswordParam forgetPasswordParam,
  ) {
    return guardFuture<String>(
      () async {
        return authRemotDataSource.forgotPassword(forgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, String>> verifyForgetPasswordOtp(
    VerifyForgetPasswordParam verifyForgetPasswordParam,
  ) {
    return guardFuture<String>(
      () async {
        return authRemotDataSource
            .verifyForgotPassword(verifyForgetPasswordParam.toMap());
      },
    );
  }

  @override
  Future<Either<NetworkExceptions, void>> resetPassword(
    ResetPasswordParams verifyForgetPasswordParam,
  ) {
    return guardFuture<void>(
      () async {
        return authRemotDataSource
            .resetPassword(verifyForgetPasswordParam.toMap());
      },
    );
  }

  // @override
  // Future<Either<NetworkExceptions, void>> resetPassword(
  //   ResetPasswordParam resetPasswordParam,
  // ) {
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<NetworkExceptions, void>> updatePassword(
  //   UpdatePasswordParam updatePasswordParam,
  // ) {
  //   throw UnimplementedError();
  // }
}
