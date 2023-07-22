import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/features/auth/data/models/cars_model.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/domain/entities/provider_entity.dart';
import 'package:wyca/features/auth/domain/entities/user.dart';
import 'package:wyca/features/auth/domain/params/toggle_active_params.dart';
import 'package:wyca/features/auth/domain/params/update_user.params.dart';
import 'package:wyca/features/auth/domain/repositories/i_provider.dart';
import 'package:wyca/features/auth/domain/repositories/i_respository.dart';
import 'package:wyca/features/auth/domain/repositories/i_user.dart';
import 'package:wyca/features/auth/presentation/bloc/provider_cubit.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum UserType { user, provider }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required IAuthenticationRepository authenticationRepository,
    required IUserRepository userRepository,
    required IProviderRepository providerRepository,
    required UserCubit userCubit,
    required ProviderCubit providerCubit,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _providerRepository = providerRepository,
        _userCubit = userCubit,
        _providerubit = providerCubit,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationProviderUpdateRequested>(
      _onAuthenticationProviderUpdateRequested,
    );
    on<AuthenticationUpdateRequested>(_onAuthenticationUpdateRequested);

    on<UpdateAddresses>(_onAuthenticationUpdateAddresses);
    on<UpdateCars>(_onAuthenticationUpdateCars);
    on<ToggleProviderActive>(_onToggleProviderActive);

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final IAuthenticationRepository _authenticationRepository;

  final IUserRepository _userRepository;
  final IProviderRepository _providerRepository;

  final UserCubit _userCubit;
  final ProviderCubit _providerubit;

  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  bool get isUser => state.user.role == 'user';
  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    // print(event.status);
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.authenticatedAfterSignup:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthenticationState.authenticatedAfterSignUp(user)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.authenticatedProvider:
        final provider = await _tryGetProvider();
        return emit(
          provider != null
              ? AuthenticationState.authenticatedProvider(provider)
              : const AuthenticationState.unauthenticated(),
        );

      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<void> _onAuthenticationUpdateRequested(
    AuthenticationUpdateRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    final user = await _userRepository.updateUser(event.params);
    user.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
      },
      _userCubit.addUser,
    );
  }

  Future<void> _onAuthenticationProviderUpdateRequested(
    AuthenticationProviderUpdateRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    final user = await _providerRepository.updateProvider(event.params);
    user.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
      },
      _providerubit.addProvider,
    );
  }

  Future<void> _onAuthenticationUpdateAddresses(
    UpdateAddresses event,
    Emitter<AuthenticationState> emit,
  ) async {
    final user = await _userRepository.updateUserAddresses(event.params);
    user.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
      },
      _userCubit.addUser,
    );
  }

  Future<void> _onAuthenticationUpdateCars(
    UpdateCars event,
    Emitter<AuthenticationState> emit,
  ) async {
    final user = await _userRepository.updateUserCars(event.params);
    user.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
      },
      _userCubit.addUser,
    );
  }

  Future<void> _onToggleProviderActive(
    ToggleProviderActive event,
    Emitter<AuthenticationState> emit,
  ) async {
    final user = await _providerRepository.toggleActive(event.params);
    user.fold(
      (l) {
        Fluttertoast.showToast(msg: l.errorMessege);
      },
      _providerubit.addProvider,
    );
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user.fold((l) => null, (r) {
        _userCubit.addUser(r);
        add(
          AuthenticationUpdateRequested(
            UpdateUserParameter(
              user: r,
            ),
          ),
        );
        return r;
      });
    } catch (_) {
      return null;
    }
  }

  Future<Provider?> _tryGetProvider() async {
    try {
      final user = await _providerRepository.getProvider();
      // print(user);
      return user.fold((l) => null, (r) {
        _providerubit.addProvider(r);
        return r;
      });
    } catch (e) {
      // print(e);
      return null;
    }
  }
}
