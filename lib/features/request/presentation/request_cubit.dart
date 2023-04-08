import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/core/api_errors/index.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/domain/params/craeet_request.dart';
import 'package:wyca/features/request/domain/params/rate.dart';
import 'package:wyca/features/request/domain/repositories/i_request_reoository.dart';

abstract class RequestCubitState {}

class RequestCubitStateInitial extends RequestCubitState {}

class RequestCubitStateLoading extends RequestCubitState {}

class RequestCubitStateLoaded extends RequestCubitState {
  RequestCubitStateLoaded();
}

class RequestCubitStateCanceled extends RequestCubitState {
  RequestCubitStateCanceled(this.request);
  final RequestClass request;
}

class RequestCubitStateTried extends RequestCubitState {
  RequestCubitStateTried(this.request);
  final RequestClass request;
}

class RequestCubitStateConfirmed extends RequestCubitState {
  RequestCubitStateConfirmed(this.request);
  final RequestClass request;
}

class RequestCubitStateDisConfirmed extends RequestCubitState {
  RequestCubitStateDisConfirmed(this.request);
  final RequestClass request;
}

class RequestCubitStateRated extends RequestCubitState {
  RequestCubitStateRated(this.request);
  final RequestClass request;
}

class SingleRequestCubitStateLoaded extends RequestCubitState {
  SingleRequestCubitStateLoaded(this.request);
  final RequestClass request;
}

class RequestCubitStateSent extends RequestCubitState {
  RequestCubitStateSent(this.request);
  final RequestClass request;
}

class RequestCubitStateError extends RequestCubitState {
  RequestCubitStateError(this.error);
  final NetworkExceptions error;
}

class RequestCubit extends Cubit<RequestCubitState> {
  RequestCubit({required this.requestRespository})
      : super(RequestCubitStateInitial());
  final IRequestRespository requestRespository;
  Future<void> createRequest(CreateRequestParams params) async {
    emit(RequestCubitStateLoading());
    final result = await requestRespository.createOrder(params);
    result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
        emit(RequestCubitStateError(l));
      },
      (r) => emit(RequestCubitStateSent(r)),
    );
  }

  Future<void> getSingelRequest(String id) async {
    emit(RequestCubitStateLoading());
    final result = await requestRespository.singleRequest(id);
    result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
        emit(RequestCubitStateError(l));
      },
      (r) => emit(SingleRequestCubitStateLoaded(r)),
    );
  }

  Future<void> rateRequest(RatingParams params) async {
    emit(RequestCubitStateLoading());
    final result = await requestRespository.rate(params);
    result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
        emit(RequestCubitStateError(l));
      },
      (r) => emit(RequestCubitStateRated(r)),
    );
  }

  Future<void> tryAgainRequest(String params) async {
    emit(RequestCubitStateLoading());
    final result = await requestRespository.tryAgainRequest(params);
    result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
        emit(RequestCubitStateError(l));
      },
      (r) => emit(RequestCubitStateTried(r)),
    );
  }

  Future<void> cancelRequest(String params) async {
    emit(RequestCubitStateLoading());
    final result = await requestRespository.cancelRequest(params);
    result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
        emit(RequestCubitStateError(l));
      },
      (r) => emit(RequestCubitStateCanceled(r)),
    );
  }

  Future<void> confirmRequest(String params) async {
    emit(RequestCubitStateLoading());
    final result = await requestRespository.confirmRequest(params);
    result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
        emit(RequestCubitStateError(l));
      },
      (r) => emit(RequestCubitStateConfirmed(r)),
    );
  }

  Future<void> disconfirmRequest(String params) async {
    emit(RequestCubitStateLoading());
    final result = await requestRespository.disconfirmRequest(params);
    result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
        emit(RequestCubitStateError(l));
      },
      (r) => emit(RequestCubitStateDisConfirmed(r)),
    );
  }
}
