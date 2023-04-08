import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/useCase/use_case.dart';
import 'package:wyca/features/user/home/data/models/package_model.dart';
import 'package:wyca/features/user/home/domain/repositories/i._package.repsoitory.dart';

class GetPackages extends UseCase<PackageResponse, NoParams> {
  GetPackages(this.repository);
  final IPackageRepository repository;

  @override
  Future<Either<NetworkExceptions, PackageResponse>> call(
    NoParams params,
  ) async {
    return repository.getPackages();
  }
}
class GetFeaturedackages extends UseCase<PackageResponse, NoParams> {
  GetFeaturedackages(this.repository);
  final IPackageRepository repository;

  @override
  Future<Either<NetworkExceptions, PackageResponse>> call(
    NoParams params,
  ) async {
    return repository.getFeaturedPackages();
  }
}
