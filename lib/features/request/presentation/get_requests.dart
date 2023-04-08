import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/core/api_errors/index.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/domain/repositories/i_request_reoository.dart';

abstract class GetRequestCubitState {}

class GetRequestCubitStateInitial extends GetRequestCubitState {}

class GetRequestCubitStateLoading extends GetRequestCubitState {}

class GetRequestCubitStateLoaded extends GetRequestCubitState {
  GetRequestCubitStateLoaded(this.requests);
  final List<RequestClass> requests;
}

class GetSingleRequestCubitStateLoaded extends GetRequestCubitState {
  GetSingleRequestCubitStateLoaded(this.request);
  final RequestClass request;
}

class GetRequestCubitStateError extends GetRequestCubitState {
  GetRequestCubitStateError(this.error);
  final NetworkExceptions error;
}

class GetRequestCubit extends Cubit<GetRequestCubitState> {
  GetRequestCubit({required this.requestRespository})
      : super(GetRequestCubitStateInitial());
  final IRequestRespository requestRespository;
  Future<void> getRequests() async {
    emit(GetRequestCubitStateLoading());
    final result = await requestRespository.getRequests();
    result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
        emit(GetRequestCubitStateError(l));
      },
      (r) => emit(GetRequestCubitStateLoaded(r.results)),
    );
  }

  Future<void> getSingelRequest(String id) async {
    emit(GetRequestCubitStateLoading());
    final result = await requestRespository.singleRequest(id);
    result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
        emit(GetRequestCubitStateError(l));
      },
      (r) => emit(GetSingleRequestCubitStateLoaded(r)),
    );
  }

  Future<void> addReq(RequestClass req) async {
    emit(GetRequestCubitStateLoading());
    emit(GetSingleRequestCubitStateLoaded(req));
  }
}
