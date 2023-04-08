import 'package:bloc/bloc.dart';
import 'package:wyca/core/api_errors/index.dart';
import 'package:wyca/core/useCase/use_case.dart';
import 'package:wyca/features/user/home/domain/entities/package.dart';
import 'package:wyca/features/user/home/domain/usecases/get_packages.dart';

abstract class PackagesCubitState {}

class PackagesCubitStateInitial extends PackagesCubitState {}

class PackagesCubitStateLoading extends PackagesCubitState {}

class PackagesCubitStateLoaded extends PackagesCubitState {
  PackagesCubitStateLoaded(this.packages, this.featuredPackages);

  final List<Package> packages;
  final List<Package> featuredPackages;
}

class PackagesCubitStateError extends PackagesCubitState {
  PackagesCubitStateError(this.error);
  final NetworkExceptions error;
}

class PackagesCubit extends Cubit<PackagesCubitState> {
  PackagesCubit({required this.getPackagesUse})
      : super(PackagesCubitStateInitial());
  final GetPackages getPackagesUse;
  Future<void> getPackages() async {
    emit(PackagesCubitStateLoading());
    final result = await getPackagesUse(NoParams());
    result.fold(
      (l) => emit(PackagesCubitStateError(l)),
      (r) async {
        final result2 = await getPackagesUse(NoParams());
        result2.fold(
          (l) => l,
          (r2) => emit(
            PackagesCubitStateLoaded(
              r.results,
              r2.results.where((element) => element.isOffer == true).toList(),
            ),
          ),
        );
      },
    );
  }
}
