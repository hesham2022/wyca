// import 'package:bloc/bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:wyca/core/api_errors/index.dart';
// import 'package:wyca/features/request/data/models/request_model.dart';
// import 'package:wyca/features/request/domain/params/craeet_request.dart';
// import 'package:wyca/features/request/domain/repositories/i_request_reoository.dart';

// abstract class GetSingleRequestCubitState {}

// class GetSingleRequestCubitStateInitial extends GetSingleRequestCubitState {}

// class GetSingleRequestCubitStateLoading extends GetSingleRequestCubitState {}

// class GetSingleRequestCubitStateLoaded extends GetSingleRequestCubitState {
//   GetSingleRequestCubitStateLoaded(this.requests);
//   final List<RequestClass> requests;
// }


// class GetSingleRequestCubitStateError extends GetSingleRequestCubitState {
//   GetSingleRequestCubitStateError(this.error);
//   final NetworkExceptions error;
// }

// class GetSingelRequestCubit extends Cubit<GetSingleRequestCubitState> {
//   GetSingelRequestCubit({required this.requestRespository})
//       : super(GetSingleRequestCubitStateInitial());
//   final IRequestRespository requestRespository;
//   Future<void> getRequests() async {
//     emit(GetSingleRequestCubitStateLoading());
//     final result = await requestRespository.getRequests();
//     result.fold(
//       (l) {
//         Fluttertoast.showToast(msg: l.errorMessege);
//         emit(GetSingleRequestCubitStateError(l));
//       },
//       (r) => emit(GetSingleRequestCubitStateLoaded(r.results)),
//     );
//   }
//    Future<void> getSingelRequest(String id) async {
//     emit(GetSingleRequestCubitStateLoading());
//     final result = await requestRespository.singleRequest(id);
//     result.fold(
//       (l) {
//         Fluttertoast.showToast(msg: l.errorMessege);
//         emit(GetSingleRequestCubitStateError(l));
//       },
//       (r) => emit(GetSingleRequestCubitStateLoaded(r)),
//     );
//   }
// }
