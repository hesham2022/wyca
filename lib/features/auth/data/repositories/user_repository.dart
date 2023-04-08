import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/utils/catch_async.dart';
import 'package:wyca/features/auth/data/datasources/user_remote.dart';
import 'package:wyca/features/auth/data/models/cars_model.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/domain/entities/user.dart';
import 'package:wyca/features/auth/domain/params/update_user.params.dart';
import 'package:wyca/features/auth/domain/repositories/i_user.dart';

class UserRepository extends IUserRepository {
  UserRepository(this.userRemote);

  final IUserRemote userRemote;

  @override
  Future<Either<NetworkExceptions, User>> getUser() =>
      guardFuture<User>(userRemote.getUser);

  @override
  Future<Either<NetworkExceptions, User>> updateUser(
    UpdateUserParameter params,
  ) =>
      guardFuture<User>(() => userRemote.updateUser(params.toMap()));

  @override
  Future<Either<NetworkExceptions, User>> updateUserAddresses(
    Address params,
  ) =>
      guardFuture<User>(
        () => userRemote
            .addAddresses(<String, dynamic>{'address': params.toJson()}),
      );
  @override
  Future<Either<NetworkExceptions, User>> deleteUserAddresse(
    String id,
  ) =>
      guardFuture<User>(
        () => userRemote.removeAddresse(id),
      );
  @override
  Future<Either<NetworkExceptions, User>> updateUserCars(
    Car params,
  ) async =>
      guardFuture<User>(
        () async => userRemote.addCars(await params.toUpload()),
      );
}
