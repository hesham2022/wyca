import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wyca/features/companmy_setting/domain/repositories/i_company_setting_repo.dart';

import '../../../../core/api_errors/network_exceptions.dart';
import '../../data/models/company_seting_model.dart';

part 'calling_event.dart';
part 'calling_state.dart';

class CallingBloc extends Bloc<CallingEvent, CallingState> {
  CallingBloc({required this.repository}) : super(CallingInitial()) {
    on<CallingEvent>((event, emit) {});
    on<GetComapnySettingsEvent>((event, emit) async {
      emit(CallingLoading());
      final result = await repository.getCompanySettings();
      result.fold((l) => emit(CallingFailed(l)), (r) => emit(CallingLoaded(r)));
    });
  }
  final IComapnySettingsRepository repository;
}
