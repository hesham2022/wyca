import 'package:bloc/bloc.dart';
import 'package:wyca/core/api_errors/index.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/domain/params/acceptParams.dart';
import 'package:wyca/features/request/domain/params/complete_params.dart';
import 'package:wyca/features/request/domain/repositories/i_request_reoository.dart';

abstract class RequestProviderCubitState {}

class RequestProviderCubitStateInitial extends RequestProviderCubitState {}

class RequestProviderCubitStateLoading extends RequestProviderCubitState {}

class RequestProviderCubitStateLoaded extends RequestProviderCubitState {
  RequestProviderCubitStateLoaded();
}

class RequestProviderCubitStateSent extends RequestProviderCubitState {
  RequestProviderCubitStateSent(this.request);

  final RequestClass request;
}

class RequestProviderCubitStateStarted extends RequestProviderCubitState {
  RequestProviderCubitStateStarted(this.request);

  final RequestClass request;
}

class RequestProviderCubitStateDone extends RequestProviderCubitState {
  RequestProviderCubitStateDone(this.request);

  final RequestClass request;
}

class RequestProviderCubitStateError extends RequestProviderCubitState {
  RequestProviderCubitStateError(this.error);
  final NetworkExceptions error;
}

class RequestProviderCubit extends Cubit<RequestProviderCubitState> {
  RequestProviderCubit({required this.requestRespository})
      : super(RequestProviderCubitStateInitial());
  final IRequestRespository requestRespository;
  Future<void> accept(AcceptParams params) async {
    emit(RequestProviderCubitStateLoading());
    final result = await requestRespository.acceptRequest(params);
    result.fold(
      (l) => emit(RequestProviderCubitStateError(l)),
      (r) => emit(RequestProviderCubitStateSent(r)),
    );
  }

  Future<void> start(String params) async {
    emit(RequestProviderCubitStateLoading());
    final result = await requestRespository.startRequest(params);
    result.fold(
      (l) => emit(RequestProviderCubitStateError(l)),
      (r) => emit(RequestProviderCubitStateStarted(r)),
    );
  }

  Future<void> done(String params) async {
    emit(RequestProviderCubitStateLoading());
    final result = await requestRespository.doneRequest(params);
    result.fold(
      (l) => emit(RequestProviderCubitStateError(l)),
      (r) => emit(RequestProviderCubitStateDone(r)),
    );
  }

  Future<void> complete(CompleteRequestParams params) async {
    emit(RequestProviderCubitStateLoading());
    final result = await requestRespository.complete(params);
    result.fold(
      (l) => emit(RequestProviderCubitStateError(l)),
      (r) => emit(RequestProviderCubitStateDone(r)),
    );
  }
}
