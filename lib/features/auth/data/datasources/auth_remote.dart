import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/features/auth/data/models/provider_registeration_response.dart';
import 'package:wyca/features/auth/data/models/register_response.dart';
import 'package:wyca/features/auth/domain/entities/register_response.dart';

abstract class IAuthUserRemotDataSource {
  IAuthUserRemotDataSource(this.apiClient);
  final ApiClient apiClient;

  Future<RegisterUserResponse?> login(Map<String, dynamic> body);
  Future<ProviderRegisterationResponse?> loginProvider(
    Map<String, dynamic> body,
  );

  Future<RegisterUserResponse?> signUp(Map<String, dynamic> body);
  Future<ProviderRegisterationResponse?> signUpProvider(
    Map<String, dynamic> body,
  );

  Future<void> logoOtt();
  Future<String> forgotPassword(Map<String, dynamic> body);
  Future<String> verifyForgotPassword(Map<String, dynamic> body);
  Future<void> resetPassword(Map<String, dynamic> body);
}

class AuthRemotUserDataSource extends IAuthUserRemotDataSource {
  AuthRemotUserDataSource(super.apiConfig);

  @override
  Future<RegisterUserResponse?> login(Map<String, dynamic> body) async {
    final response = await apiClient.post(kLogin, body: body);
    final loginResponse = RegisterUserResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );

    return loginResponse;
  }

  @override
  Future<ProviderRegisterationResponse?> loginProvider(
    Map<String, dynamic> body,
  ) async {
    final response = await apiClient.post(kLoginProvider, body: body);
    final loginResponse = ProviderRegisterationResponse.fromJson(
      response.data as Map<String, dynamic>,
    );

    return loginResponse;
  }

  @override
  Future<void> logoOtt() {
    throw UnimplementedError();
  }

  @override
  Future<RegisterUserResponse?> signUp(Map<String, dynamic> body) async {
    final response = await apiClient.post(kRegister, body: body);
    final signInResponse = RegisterUserResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );

    return signInResponse;
  }

  @override
  Future<String> forgotPassword(Map<String, dynamic> body) async {
    final response = await apiClient.post(kForgotPassword, body: body);
    return response.data['forgetPasswordToken'] as String;
  }

  @override
  Future<String> verifyForgotPassword(Map<String, dynamic> body) async {
    final response = await apiClient.post(kverifyForgotPassword, body: body);
    return response.data['resetPasswordToken'] as String;
  }

  @override
  Future<void> resetPassword(Map<String, dynamic> body) async {
    await apiClient.post(kResetPassword, body: body);
  }

  @override
  Future<ProviderRegisterationResponse?> signUpProvider(
    Map<String, dynamic> body,
  ) async {
    final response = await apiClient.upload(kRegisterProvider, body: body);
    final signInResponse = ProviderRegisterationResponse.fromJson(
      response.data as Map<String, dynamic>,
    );

    return signInResponse;
  }
}
