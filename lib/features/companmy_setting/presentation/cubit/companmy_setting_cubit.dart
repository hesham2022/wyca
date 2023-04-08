import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'companmy_setting_state.dart';

class CompanmySettingCubit extends Cubit<CompanmySettingState> {
  CompanmySettingCubit() : super(CompanmySettingInitial());
}
