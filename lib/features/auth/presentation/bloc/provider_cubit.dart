import 'package:bloc/bloc.dart';
import 'package:wyca/features/auth/domain/entities/provider_entity.dart';

abstract class ProviderCubitState {}

class ProviderCubitStateInitial extends ProviderCubitState {}

class ProviderCubitStateLoading extends ProviderCubitState {}

class ProviderCubitStateLoaded extends ProviderCubitState {
  ProviderCubitStateLoaded(this.provider);

  final Provider provider;
}

class ProviderCubitStateError extends ProviderCubitState {}

class ProviderCubit extends Cubit<ProviderCubitState> {
  ProviderCubit() : super(ProviderCubitStateInitial());

  void addProvider(Provider provider) {
    print('provider is: ${provider.id}');
    emit(ProviderCubitStateLoading());
    emit(ProviderCubitStateLoaded(provider));
  }
}
