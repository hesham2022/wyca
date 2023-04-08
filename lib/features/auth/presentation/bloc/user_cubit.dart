import 'package:bloc/bloc.dart';
import 'package:wyca/core/api_errors/index.dart';
import 'package:wyca/features/auth/domain/entities/user.dart';
import 'package:wyca/features/auth/domain/repositories/i_user.dart';

abstract class UserCubitState {}

class UserCubitStateInitial extends UserCubitState {}

class UserCubitStateLoading extends UserCubitState {}

class UserCubitStateLoaded extends UserCubitState {
  UserCubitStateLoaded(this.user);

  final User user;
}

class UserCubitStateError extends UserCubitState {
  UserCubitStateError(this.error);
  final NetworkExceptions error;
}

class UserCubit extends Cubit<UserCubitState> {
  UserCubit(this.repository) : super(UserCubitStateInitial());
  final IUserRepository repository;
  void addUser(User user) {
    emit(UserCubitStateLoading());
    emit(UserCubitStateLoaded(user));
  }

  Future<void> deleteAddress(String id) async {
    emit(UserCubitStateLoading());
    final user = await repository.deleteUserAddresse(id);

    user.fold(
      (l) {
        emit(UserCubitStateError(l));
      },
      (r) {
        emit(UserCubitStateLoaded(r));
      },
    );
  }

  Future<void> getMe() async {
    emit(UserCubitStateLoading());

    final user = await repository.getUser();
    user.fold(
      (l) {
        emit(UserCubitStateError(l));
      },
      (r) {
        emit(UserCubitStateLoaded(r));
      },
    );
  }
}
