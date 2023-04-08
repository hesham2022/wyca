import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/features/user/home/data/models/package_model.dart';

abstract class IPackageRemote {
  IPackageRemote(this.apiConfig);
  final ApiClient apiConfig;

  Future<PackageResponse> getPackages();
  Future<PackageResponse> getFeaturedPackages();
}

class PackageRemote extends IPackageRemote {
  PackageRemote(super.apiConfig);

  @override
  Future<PackageResponse> getPackages() async {
    final response = await apiConfig.get(kPackage);
    final data = response.data as Map<String, dynamic>;
    final packageResult = PackageResponse.fromJson(data);
    return packageResult;
  }

  @override
  Future<PackageResponse> getFeaturedPackages() async {
    final response = await apiConfig
        .get(kPackage, queryParams: <String, dynamic>{'isOffer': true});
    final data = response.data as Map<String, dynamic>;
    final packageResult = PackageResponse.fromJson(data);
    return packageResult;
  }
}
