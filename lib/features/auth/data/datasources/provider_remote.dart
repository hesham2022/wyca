import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/features/auth/data/models/provider_registeration_response.dart';
import 'package:wyca/features/auth/domain/entities/provider_entity.dart';

abstract class IProviderRemote {
  IProviderRemote(this.apiConfig);
  final ApiClient apiConfig;
  Future<Provider> updateProvider(Map<String, dynamic> body);

  Future<Provider> getProvider();
  Future<List<Provider>> getNearProviders(Map<String, dynamic> body);

  // Future<Provider> updateProvider(Map<String, dynamic> body);

}

class ProviderRemote extends IProviderRemote {
  ProviderRemote(super.apiConfig);

  @override
  Future<Provider> getProvider() async {
    final response = await apiConfig.get(kGetMeProvider);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final providerResult =
        ProviderModel.fromMap(data['provider'] as Map<String, dynamic>);
    return providerResult;
  }

  @override
  Future<Provider> updateProvider(Map<String, dynamic> body) async {
    final response = await apiConfig.patch(kUpdateMeProvider, body: body);
    final data = response.data as Map<String, dynamic>;
    // ignore: avoid_dynamic_calls
    final userResult =
        ProviderModel.fromMap(data['user'] as Map<String, dynamic>);
    return userResult;
  }

  @override
  Future<List<Provider>> getNearProviders(dynamic body) async {
    final response = await apiConfig.post(kNear, body: body);
    
    final data = response.data as List<dynamic>;

    // ignore: avoid_dynamic_calls
    final providers = data
        .map((dynamic e) => ProviderModel.fromMap(e as Map<String, dynamic>))
        .toList();

    return providers;
  }
  // @override
  // Future<Provider> updateProvider(Map<String, dynamic> body) async {
  //   final response = await apiConfig.patch(kUpdateMe, body: body);
  //   final data = response.data as Map<String, dynamic>;
  //   // ignore: avoid_dynamic_calls
  //   final ProviderResult =
  //       ProviderModel.fromJson(data['Provider'] as Map<String, dynamic>);
  //   return ProviderResult;
  // }

}
