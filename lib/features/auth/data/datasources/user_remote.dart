import 'package:dio/dio.dart';
import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/domain/entities/user.dart';

abstract class IUserRemote {
  IUserRemote(this.apiConfig);
  final ApiClient apiConfig;

  Future<User> getUser();
  Future<User> updateUser(Map<String, dynamic> body);
  Future<User> addCars(Map<String, dynamic> body);
  Future<User> addAddresses(Map<String, dynamic> body);
  Future<User> removeAddresse(String id);
}

class UserRemote extends IUserRemote {
  UserRemote(super.apiConfig);

  @override
  Future<User> getUser() async {
    final response = await apiConfig.get(kGetMe);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return userResult;
  }

  @override
  Future<User> updateUser(Map<String, dynamic> body) async {
    final response = await apiConfig.patch(kUpdateMe, body: body);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return userResult;
  }

  @override
  Future<User> addCars(Map<String, dynamic> body) async {
    final response =
        await apiConfig.patchUpload(kUpdateCars, body: FormData.fromMap(body));
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return userResult;
  }

  @override
  Future<User> addAddresses(Map<String, dynamic> body) async {
    final response = await apiConfig.patch(kUpdateAddresses, body: body);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return userResult;
  }

  @override
  Future<User> removeAddresse(String id) async {
    final response = await apiConfig
        .patch(kDeleteAddresses, body: <String, dynamic>{'id': id});
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return userResult;
  }
}
