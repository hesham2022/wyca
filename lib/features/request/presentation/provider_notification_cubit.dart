import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wyca/core/api_errors/index.dart';
import 'package:wyca/core/local_storage/secure_storage_instance.dart';
import 'package:wyca/features/request/data/models/request_model.dart';

abstract class PNCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PNCubitStateInitial extends PNCubitState {}

class PNCubitStateLoading extends PNCubitState {}

class PNCubitStateLoaded extends PNCubitState {
  PNCubitStateLoaded(this.requests);
  final List<RequestClass> requests;
  @override
  List<Object?> get props => [requests];
}

class PNCubitStateSent extends PNCubitState {}

class PNCubitStateError extends PNCubitState {
  PNCubitStateError(this.error);
  final NetworkExceptions error;
}

class PNCubit extends Cubit<PNCubitState> {
  PNCubit() : super(PNCubitStateInitial());
  RequestClass? newReq;
  Future<void> getLocalNotifcation({
    bool isProvider = false,
    String? userId,
  }) async {
    emit(PNCubitStateLoading());
    try {
      final r = await Storage.getNewRequests(
        isProvider: isProvider,
        userId: userId,
      );

      emit(PNCubitStateLoaded(r));
    } catch (e) {
      emit(PNCubitStateError(NetworkExceptions(e)));
    }
  }

  Future<void> updateNotification(RequestClass request) async {
    emit(PNCubitStateLoading());
    try {
      await Storage.updateNewRequests(request);
      final r = await Storage.getNewRequests();
      emit(PNCubitStateLoaded(r));
    } catch (e) {
      emit(PNCubitStateError(NetworkExceptions(e)));
    }
  }

  Future<void> removeNotification(RequestClass request) async {
    emit(PNCubitStateLoading());
    try {
      await Storage.removeNewRequests(request);
      final r = await Storage.getNewRequests();
      emit(PNCubitStateLoaded(r));
    } catch (e) {
      emit(PNCubitStateError(NetworkExceptions(e)));
    }
  }

  Future<void> addNewNotification(RequestClass n) async {
    final l = await Storage.setNewRequests(n);

    newReq = n;
    if (state is PNCubitStateInitial) {
      emit(PNCubitStateLoaded(const []));
    }
    emit(PNCubitStateLoaded([...l]));
  }
}
