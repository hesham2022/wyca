// ignore: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/features/user/home/data/models/package_model.dart';

// ignore: one_member_abstracts
abstract class IPackageRepository {
  Future<Either<NetworkExceptions, PackageResponse>> getPackages();
    Future<Either<NetworkExceptions, PackageResponse>> getFeaturedPackages();

}
