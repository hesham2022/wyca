import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/features/auth/domain/entities/provider_entity.dart';
import 'package:wyca/features/auth/domain/params/geo_near_params.dart';
import 'package:wyca/features/auth/domain/params/toggle_active_params.dart';
import 'package:wyca/features/auth/domain/params/update_user.params.dart';

// ignore: one_member_abstracts
abstract class IProviderRepository {
  Future<Either<NetworkExceptions, Provider>> getProvider();
  Future<Either<NetworkExceptions, Provider>> updateProvider(
    UpdateProviderParameter params,
  );
  Future<Either<NetworkExceptions, Provider>> toggleActive(
    ToggleActiveParams params,
  );
  Future<Either<NetworkExceptions, List<Provider>>> getNearProviders(
    GetNearParams params,
  );

  // Future<Either<NetworkExceptions, Provider>> updateUser(
  //   UpdateUserParameter params,
  // );
}
