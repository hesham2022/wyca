import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/utils/catch_async.dart';
import 'package:wyca/features/auth/data/datasources/provider_remote.dart';
import 'package:wyca/features/auth/domain/entities/provider_entity.dart';
import 'package:wyca/features/auth/domain/params/geo_near_params.dart';
import 'package:wyca/features/auth/domain/params/toggle_active_params.dart';
import 'package:wyca/features/auth/domain/params/update_user.params.dart';
import 'package:wyca/features/auth/domain/repositories/i_provider.dart';

class ProviderRepository extends IProviderRepository {
  ProviderRepository(this.providerRemote);
  final IProviderRemote providerRemote;

  @override
  Future<Either<NetworkExceptions, Provider>> getProvider() =>
      guardFuture<Provider>(providerRemote.getProvider);

  @override
  Future<Either<NetworkExceptions, Provider>> toggleActive(
    ToggleActiveParams params,
  ) =>
      guardFuture<Provider>(
        () => providerRemote.updateProvider(params.toMap()),
      );

  @override
  Future<Either<NetworkExceptions, Provider>> updateProvider(
    UpdateProviderParameter params,
  ) =>
      guardFuture<Provider>(
        () => providerRemote.updateProvider(params.toMap()),
      );

  @override
  Future<Either<NetworkExceptions, List<Provider>>> getNearProviders(
    GetNearParams params,
  ) =>
      guardFuture<List<Provider>>(
        () => providerRemote.getNearProviders(params.toMap()),
      );

  // Future<Either<NetworkExceptions, Provider>> updateUser(
  //   UpdateUserParameter params,
  // ) =>
  //     guardFuture<User>(() => userRemote.up(params.toMap()));

}
