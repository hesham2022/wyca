import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/core/api_errors/index.dart';
import 'package:wyca/features/auth/domain/params/forget_password_params.dart';
import 'package:wyca/features/auth/domain/params/login_params.dart';
import 'package:wyca/features/auth/domain/params/peovider_register_params.dart';
import 'package:wyca/features/auth/domain/params/register_params.dart';
import 'package:wyca/features/auth/domain/params/reset_password_params.dart';
import 'package:wyca/features/auth/domain/params/verify_forgt_otp.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  authenticatedAfterSignup,
  authenticatedProvider,
  authenticatedAfterSignupProvider
}

abstract class IAuthenticationRepository {
  IAuthenticationRepository({required this.apiConfig});
  final ApiClient apiConfig;

  StreamController<AuthenticationStatus> get controller;

  Stream<AuthenticationStatus> get status;

  Future<Either<NetworkExceptions, void>> logIn(LoginParam loginParams);
  Future<Either<NetworkExceptions, void>> signIn(RegisterUserParams signParams);
  Future<Either<NetworkExceptions, void>> logInProvider(LoginParam loginParams);
  Future<Either<NetworkExceptions, void>> signInProvider(
    RegisterProviderParams signParams,
  );
  Future<Either<NetworkExceptions, String>> forgotPassword(
    ForgetPasswordParam forgetPasswordParam,
  );
  Future<Either<NetworkExceptions, String>> verifyForgetPasswordOtp(
    VerifyForgetPasswordParam verifyForgetPasswordParam,
  );
  Future<Either<NetworkExceptions, void>> resetPassword(
    ResetPasswordParams verifyForgetPasswordParam,
  );
  // Future<Either<NetworkExceptions, void>> resetPassword(
  //   ResetPasswordParam resetPasswordParam,
  // );
  // Future<Either<NetworkExceptions, void>> updatePassword(
  //   UpdatePasswordParam updatePasswordParam,
  // );
  Future<void> logOut();

  void dispose() => controller.close();
}
