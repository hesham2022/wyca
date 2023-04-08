import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/useCase/use_case.dart';
import 'package:wyca/features/auth/domain/entities/user.dart';
import 'package:wyca/features/auth/domain/repositories/i_user.dart';

class GetUser extends UseCase<User, NoParams> {
  GetUser(this.repository);
  final IUserRepository repository;

  @override
  Future<Either<NetworkExceptions, User>> call(NoParams params) async {
    return repository.getUser();
  }
}
