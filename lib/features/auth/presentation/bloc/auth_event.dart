part of 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationUpdateRequested extends AuthenticationEvent {
  const AuthenticationUpdateRequested(this.params);

  final UpdateUserParameter params;
}

class AuthenticationProviderUpdateRequested extends AuthenticationEvent {
  const AuthenticationProviderUpdateRequested(this.params);

  final UpdateProviderParameter params;
}

class UpdateAddresses extends AuthenticationEvent {
  const UpdateAddresses(this.params);

  final Address params;
}

class ToggleProviderActive extends AuthenticationEvent {
  const ToggleProviderActive(this.params);

  final ToggleActiveParams params;
}

class UpdateCars extends AuthenticationEvent {
  const UpdateCars(this.params);

  final Car params;
}
