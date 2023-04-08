import 'package:bloc/bloc.dart';
import 'package:wyca/features/auth/domain/params/forget_password_params.dart';
import 'package:wyca/features/auth/domain/params/reset_password_params.dart';
import 'package:wyca/features/auth/domain/params/verify_forgt_otp.dart';
import 'package:wyca/features/auth/domain/repositories/i_respository.dart';
import 'package:wyca/features/auth/presentation/forget_password_bloc/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit({
    required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(ForgetPasswordStateIntial());
  final IAuthenticationRepository _authenticationRepository;
  Future<void> forgetPassword(ForgetPasswordParam param) async {
    emit(ForgetPasswordStateLoading());
    final result = await _authenticationRepository.forgotPassword(param);
    result.fold(
      (l) => emit(ForgetPasswordStateError(l)),
      (r) => emit(ForgetPasswordStateForgetPasswordTokenLoaded(r)),
    );
  }

  Future<void> verifyForgetPasswordOtp(VerifyForgetPasswordParam param) async {
    emit(ForgetPasswordStateLoading());
    final result =
        await _authenticationRepository.verifyForgetPasswordOtp(param);
    result.fold(
      (l) => emit(ForgetPasswordStateError(l)),
      (r) => emit(ForgetPasswordStateResetTokenLoaded(r)),
    );
  }

  Future<void> resetPassword(ResetPasswordParams param) async {
    emit(ForgetPasswordStateLoading());
    final result = await _authenticationRepository.resetPassword(param);
    result.fold(
      (l) => emit(ForgetPasswordStateError(l)),
      (r) => emit(ForgetPasswordStateResetPasswordSuccess()),
    );
  }
}
