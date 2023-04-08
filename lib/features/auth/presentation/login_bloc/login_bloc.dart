import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:wyca/app/view/app.dart';
import 'package:wyca/features/auth/domain/params/login_params.dart';
import 'package:wyca/features/auth/domain/params/peovider_register_params.dart';
import 'package:wyca/features/auth/domain/params/register_params.dart';
import 'package:wyca/features/auth/domain/repositories/i_respository.dart';
import 'package:wyca/features/auth/domain/validation/email.dart';
import 'package:wyca/features/auth/domain/validation/files_fileds.dart';
import 'package:wyca/features/auth/domain/validation/gender.dart';
import 'package:wyca/features/auth/domain/validation/name.dart';
import 'package:wyca/features/auth/domain/validation/password.dart';
import 'package:wyca/features/auth/domain/validation/phone_number.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginNameChanged>(_onNameChanged);
    on<LoginGenderhanged>(_onGenderChanged);
    on<LoginLastNameChanged>(_onLastNameChanged);
    on<LoginPhoneNumberChanged>(_onPhoneNumberChanged);

    on<LoginRegisterSubmitted>(_onRegisterSubmitted);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginProviderSubmitted>(_onProviderSubmitted);
    on<ChangeErrorMessage>(_onChangeErrorMessage);
    on<LoginEmailOrPhoneChanged>(
      (event, emit) {
        final username = EmailOrPhone.dirty(event.username);

        emit(
          state.copyWith(
            emailOrPhone: username,
            status: Formz.validate(
              [
                state.password,
                username,
              ],
            ),
          ),
        );
      },
    );
  }

  final IAuthenticationRepository _authenticationRepository;
  void _onChangeErrorMessage(
    ChangeErrorMessage event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(failureMessege: event.msg));
  }

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Email.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [
            state.password,
            username,
          ],
        ),
      ),
    );
  }

  void _onNameChanged(
    LoginNameChanged event,
    Emitter<LoginState> emit,
  ) {
    final name = Name.dirty(event.name);

    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([
          state.password,
          state.username,
        ]),
      ),
    );
  }

  void _onLastNameChanged(
    LoginLastNameChanged event,
    Emitter<LoginState> emit,
  ) {
    final name = LastName.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: name,
        status: Formz.validate([
          state.password,
          state.username,
        ]),
      ),
    );
  }

  void _onPhoneNumberChanged(
    LoginPhoneNumberChanged event,
    Emitter<LoginState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([
          state.password,
          state.username,
        ]),
      ),
    );
  }

  void _onGenderChanged(
    LoginGenderhanged event,
    Emitter<LoginState> emit,
  ) {
    final gender = Gender.dirty(event.gender);
    emit(
      state.copyWith(
        gender: gender,
        status: Formz.validate([
          state.password,
          state.username,
        ]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          password,
          state.emailOrPhone,
        ]),
      ),
    );
  }

  Future<void> _onProviderSubmitted(
    LoginProviderSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final result = await _authenticationRepository.logInProvider(
        LoginParam(
          password: state.password.value,
          email: state.emailOrPhone.isEmail ? state.emailOrPhone.value : null,
          phoneNumber: !state.emailOrPhone.isEmail
              ? phoneNumberFormatter(state.emailOrPhone.value)
              : null,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            failureMessege: l.errorMessege,
          ),
        ),
        (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
      );
    }
  }

  String phoneNumberFormatter(String value) {
    if (!value.startsWith('+') && value.startsWith('2')) return '+$value';
    if (!value.startsWith('+2')) return '+2$value';

    return value;
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final result = await _authenticationRepository.logIn(
        LoginParam(
          password: state.password.value,
          email: state.emailOrPhone.isEmail ? state.emailOrPhone.value : null,
          phoneNumber: !state.emailOrPhone.isEmail
              ? phoneNumberFormatter(state.emailOrPhone.value)
              : null,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            failureMessege: l.errorMessege,
          ),
        ),
        (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
      );
    }
  }

  Future<void> _onRegisterSubmitted(
    LoginRegisterSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final result = await _authenticationRepository.signIn(
        RegisterUserParams(
          password: state.password.value,
          email: state.username.value,
          gender: state.gender.value,
          fcm: kFcm,
          name: state.name.value,
          phoneNumber: state.phoneNumber.value,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            failureMessege: l.errorMessege,
          ),
        ),
        (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
      );
    }
  }
}

class RegisterBloc extends Bloc<LoginEvent, LoginState> {
  RegisterBloc({
    required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginNameChanged>(_onNameChanged);
    on<LoginGenderhanged>(_onGenderChanged);
    on<LoginLastNameChanged>(_onLastNameChanged);
    on<LoginPhoneNumberChanged>(_onPhoneNumberChanged);
    on<ChangeErrorMessage>(_onChangeErrorMessage);

    on<LoginRegisterSubmitted>(_onRegisterSubmitted);
    on<LoginSubmitted>(_onSubmitted);
  }

  final IAuthenticationRepository _authenticationRepository;
  void _onChangeErrorMessage(
    ChangeErrorMessage event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(failureMessege: event.msg));
  }

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Email.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [
            state.password,
            username,
            state.gender,
            state.lastName,
            state.name,
            state.phoneNumber
          ],
        ),
      ),
    );
  }

  void _onNameChanged(
    LoginNameChanged event,
    Emitter<LoginState> emit,
  ) {
    final name = Name.dirty(event.name);

    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([
          state.password,
          state.username,
          state.gender,
          state.lastName,
          name,
          state.phoneNumber
        ]),
      ),
    );
  }

  void _onLastNameChanged(
    LoginLastNameChanged event,
    Emitter<LoginState> emit,
  ) {
    final name = LastName.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: name,
        status: Formz.validate([
          state.password,
          state.username,
          state.gender,
          state.lastName,
          name,
          state.phoneNumber
        ]),
      ),
    );
  }

  void _onPhoneNumberChanged(
    LoginPhoneNumberChanged event,
    Emitter<LoginState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([
          state.password,
          state.username,
          state.gender,
          state.lastName,
          state.name,
          phoneNumber
        ]),
      ),
    );
  }

  void _onGenderChanged(
    LoginGenderhanged event,
    Emitter<LoginState> emit,
  ) {
    final gender = Gender.dirty(event.gender);
    emit(
      state.copyWith(
        gender: gender,
        status: Formz.validate([
          state.password,
          state.username,
          gender,
          state.lastName,
          state.name,
          state.phoneNumber
        ]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          password,
          state.username,
          state.gender,
          state.lastName,
          state.name,
          state.phoneNumber
        ]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final result = await _authenticationRepository.logIn(
        LoginParam(
          password: state.password.value,
          email: state.username.value,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            failureMessege: l.errorMessege,
          ),
        ),
        (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
      );
    }
  }

  Future<void> _onRegisterSubmitted(
    LoginRegisterSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final result = await _authenticationRepository.signIn(
        RegisterUserParams(
          password: state.password.value,
          email: state.username.value,
          gender: state.gender.value,
          fcm: kFcm,
          name: state.name.value,
          phoneNumber: state.phoneNumber.value,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            failureMessege: l.errorMessege,
          ),
        ),
        (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
      );
    }
  }
}

class RegisterProviderBloc extends Bloc<LoginEvent, LoginState> {
  RegisterProviderBloc({
    required IAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginNameChanged>(_onNameChanged);
    on<LoginGenderhanged>(_onGenderChanged);
    on<LoginLastNameChanged>(_onLastNameChanged);
    on<LoginPhoneNumberChanged>(_onPhoneNumberChanged);
    on<LoginPhotoChanged>(_onPhotoChanged);
    on<LoginCriminalFishChanged>(_onCriminalFishChanged);
    on<LoginBackIdChanged>(_onBackIdChanged);
    on<LoginFrontIdChanged>(_onFrontIdChanged);

    on<LoginRegisterSubmitted>(_onRegisterSubmitted);
    on<LoginAddAddress>(_onAddressChanged);

    on<LoginSubmitted>(_onSubmitted);
  }

  final IAuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Email.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [
            state.password,
            username,
            state.gender,
            state.lastName,
            state.name,
            state.phoneNumber,
            state.backId,
            state.frontId,
            state.criminalFish,
            state.photo
          ],
        ),
      ),
    );
  }

  void _onNameChanged(
    LoginNameChanged event,
    Emitter<LoginState> emit,
  ) {
    final name = Name.dirty(event.name);

    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([
          state.password,
          state.username,
          state.gender,
          state.lastName,
          name,
          state.phoneNumber,
          state.backId,
          state.frontId,
          state.criminalFish,
          state.photo
        ]),
      ),
    );
  }

  void _onLastNameChanged(
    LoginLastNameChanged event,
    Emitter<LoginState> emit,
  ) {
    final name = LastName.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: name,
        status: Formz.validate([
          state.password,
          state.username,
          state.gender,
          state.lastName,
          name,
          state.phoneNumber,
          state.backId,
          state.frontId,
          state.criminalFish,
          state.photo
        ]),
      ),
    );
  }

  void _onPhoneNumberChanged(
    LoginPhoneNumberChanged event,
    Emitter<LoginState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([
          state.password,
          state.username,
          state.gender,
          state.lastName,
          state.name,
          phoneNumber,
          state.backId,
          state.frontId,
          state.criminalFish,
          state.photo
        ]),
      ),
    );
  }

  void _onGenderChanged(
    LoginGenderhanged event,
    Emitter<LoginState> emit,
  ) {
    final gender = Gender.dirty(event.gender);
    emit(
      state.copyWith(
        gender: gender,
        status: Formz.validate([
          state.password,
          state.username,
          gender,
          state.lastName,
          state.name,
          state.phoneNumber,
          state.backId,
          state.frontId,
          state.criminalFish,
          state.photo
        ]),
      ),
    );
  }

  void _onPhotoChanged(
    LoginPhotoChanged event,
    Emitter<LoginState> emit,
  ) {
    final photo = Photo.dirty(event.name);
    emit(
      state.copyWith(
        photo: photo,
        status: Formz.validate([
          state.password,
          state.username,
          state.gender,
          state.lastName,
          state.name,
          state.phoneNumber,
          state.backId,
          state.frontId,
          state.criminalFish,
          state.photo
        ]),
      ),
    );
  }

  void _onCriminalFishChanged(
    LoginCriminalFishChanged event,
    Emitter<LoginState> emit,
  ) {
    final photo = CriminalFish.dirty(event.name);
    emit(
      state.copyWith(
        criminalFish: photo,
        status: Formz.validate([
          state.password,
          state.username,
          state.gender,
          state.lastName,
          state.name,
          state.phoneNumber,
          state.backId,
          state.frontId,
          state.criminalFish,
          photo
        ]),
      ),
    );
  }

  void _onFrontIdChanged(
    LoginFrontIdChanged event,
    Emitter<LoginState> emit,
  ) {
    final frontId = FrontId.dirty(event.name);
    emit(
      state.copyWith(
        frontId: frontId,
        status: Formz.validate([
          state.password,
          state.username,
          state.gender,
          state.lastName,
          state.name,
          state.phoneNumber,
          state.backId,
          frontId,
          state.criminalFish,
          state.photo
        ]),
      ),
    );
  }

  void _onBackIdChanged(
    LoginBackIdChanged event,
    Emitter<LoginState> emit,
  ) {
    final backId = BackId.dirty(event.name);
    emit(
      state.copyWith(
        backId: backId,
        status: Formz.validate([
          state.password,
          state.username,
          state.gender,
          state.lastName,
          state.name,
          state.phoneNumber,
          state.backId,
          backId,
          state.criminalFish,
          state.photo
        ]),
      ),
    );
  }

  void _onAddressChanged(
    LoginAddAddress event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        address: event.address,
        coordinates: event.coordinates,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          password,
          state.username,
          state.gender,
          state.lastName,
          state.name,
          state.phoneNumber,
          state.backId,
          state.frontId,
          state.criminalFish,
          state.photo
        ]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final result = await _authenticationRepository.logIn(
        LoginParam(
          password: state.password.value,
          email: state.username.value,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            failureMessege: l.errorMessege,
          ),
        ),
        (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
      );
    }
  }

  Future<void> _onRegisterSubmitted(
    LoginRegisterSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final result = await _authenticationRepository.signInProvider(
      RegisterProviderParams(
        coordinates: state.coordinates,
        backId: state.backId.value,
        frontId: state.frontId.value,
        phoneNumber: '+2${state.phoneNumber.value}',
        criminalFish: state.criminalFish.value,
        address: state.address,
        photo: state.photo.value,
        password: state.password.value,
        email: state.username.value,
        gender: state.gender.value.toLowerCase(),
        fcm: kFcm,
        name: state.name.value,
      ),
    );
    result.fold(
      (l) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            failureMessege: l.errorMessege,
          ),
        );
      },
      (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
    );
  }
}
