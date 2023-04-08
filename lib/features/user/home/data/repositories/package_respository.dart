import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/utils/catch_async.dart';
import 'package:wyca/features/user/home/data/datasources/package_remote.dart';
import 'package:wyca/features/user/home/data/models/package_model.dart';
import 'package:wyca/features/user/home/domain/repositories/i._package.repsoitory.dart';

class PackageRepository extends IPackageRepository {
  PackageRepository(this.packageRemote);
  final IPackageRemote packageRemote;

  @override
  Future<Either<NetworkExceptions, PackageResponse>> getPackages() =>
      guardFuture<PackageResponse>(packageRemote.getPackages);
  @override
  Future<Either<NetworkExceptions, PackageResponse>> getFeaturedPackages() =>
      guardFuture<PackageResponse>(packageRemote.getFeaturedPackages);
}
