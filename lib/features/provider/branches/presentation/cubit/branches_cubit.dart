import 'package:bloc/bloc.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/features/auth/domain/entities/provider_entity.dart';
import 'package:wyca/features/auth/domain/params/geo_near_params.dart';
import 'package:wyca/features/auth/domain/usecases/get_near_providers.dart';

abstract class BranchesCubitState {}

class BranchesCubitStateInitial extends BranchesCubitState {}

class BranchesCubitStateLoading extends BranchesCubitState {}

class BranchesCubitStateLoaded extends BranchesCubitState {
  BranchesCubitStateLoaded(this.providers);
  final List<Provider> providers;
}

class BranchesCubitStateError extends BranchesCubitState {
  BranchesCubitStateError(this.error);

  final NetworkExceptions error;
}

class BranchesCubit extends Cubit<BranchesCubitState> {
  BranchesCubit(this.getNearPrviders) : super(BranchesCubitStateInitial());
  final GetNearPrviders getNearPrviders;

  Future<void> getNearBranches(GetNearParams params) async {
    final result = await getNearPrviders(params);
    result.fold(
      (l) => emit(BranchesCubitStateError(l)),
      (r) => emit(BranchesCubitStateLoaded(r)),
    );
  }

}
