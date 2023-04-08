part of 'auth_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
    this.userType = UserType.user,
    this.provider,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);
  const AuthenticationState.authenticatedProvider(Provider provider)
      : this._(
            status: AuthenticationStatus.authenticatedProvider,
            provider: provider,
            userType: UserType.provider,);
  const AuthenticationState.authenticatedAfterSignUp(User user)
      : this._(
          status: AuthenticationStatus.authenticatedAfterSignup,
          user: user,
        );
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;
  final Provider? provider;
  final UserType userType;
  @override
  List<Object> get props => [status, user];
}
