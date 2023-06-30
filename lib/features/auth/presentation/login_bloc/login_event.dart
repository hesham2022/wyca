part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginPhoneNumberChanged extends LoginEvent {
  const LoginPhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class LoginLastNameChanged extends LoginEvent {
  const LoginLastNameChanged(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class LoginGenderhanged extends LoginEvent {
  const LoginGenderhanged(this.gender);

  final String gender;

  @override
  List<Object> get props => [gender];
}

class LoginNameChanged extends LoginEvent {
  const LoginNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class LoginCriminalFishChanged extends LoginEvent {
  const LoginCriminalFishChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class LoginBackIdChanged extends LoginEvent {
  const LoginBackIdChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class LoginAddAddress extends LoginEvent {
  const LoginAddAddress({required this.address, required this.coordinates});

  final String address;
  final List<double> coordinates;

  @override
  List<Object> get props => [address, coordinates];
}

class LoginFrontIdChanged extends LoginEvent {
  const LoginFrontIdChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class LoginPhotoChanged extends LoginEvent {
  const LoginPhotoChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class ChangeErrorMessage extends LoginEvent {
  const ChangeErrorMessage(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class LoginProviderSubmitted extends LoginEvent {
  const LoginProviderSubmitted();
}

class LoginRegisterSubmitted extends LoginEvent {
  const LoginRegisterSubmitted();
}

class LoginEmailOrPhoneChanged extends LoginEvent {
  const LoginEmailOrPhoneChanged(this.username);
  final String username;

  @override
  List<Object> get props => [username];
}

class LoginSubmittedNew extends LoginEvent {
  const LoginSubmittedNew({required this.username, required this.password});

  final String username;
  final String password;
  @override
  List<Object> get props => [username, password];
}
