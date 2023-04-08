import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/features/auth/data/models/cars_model.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/domain/entities/user.dart';
import 'package:wyca/features/auth/domain/params/update_user.params.dart';

// ignore: one_member_abstracts
abstract class IUserRepository {
  Future<Either<NetworkExceptions, User>> getUser();
  Future<Either<NetworkExceptions, User>> updateUser(
    UpdateUserParameter params,
  );
  Future<Either<NetworkExceptions, User>> updateUserAddresses(
    Address params,
  );
  Future<Either<NetworkExceptions, User>> deleteUserAddresse(
    String id,
  );
  Future<Either<NetworkExceptions, User>> updateUserCars(
    Car params,
  );
}
