import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/useCase/use_case.dart';
import 'package:wyca/features/auth/domain/entities/provider_entity.dart';
import 'package:wyca/features/auth/domain/params/geo_near_params.dart';
import 'package:wyca/features/auth/domain/repositories/i_provider.dart';

class GetNearPrviders extends UseCase<List<Provider>, GetNearParams> {
  GetNearPrviders(this.repository);
  final IProviderRepository repository;

  @override
  Future<Either<NetworkExceptions, List<Provider>>> call(
    GetNearParams params,
  ) async {
    return repository.getNearProviders(params);
  }
}
