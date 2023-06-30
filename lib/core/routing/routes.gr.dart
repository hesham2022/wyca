// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i22;
import 'package:flutter/material.dart' as _i23;
import 'package:geocoding/geocoding.dart' as _i26;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i25;

import '../../features/auth/presentation/pages/confirm_location_page.dart'
    as _i14;
import '../../features/auth/presentation/pages/forgot_password_page.dart'
    as _i15;
import '../../features/auth/presentation/pages/login.dart' as _i4;
import '../../features/auth/presentation/pages/provider/provider_login.dart'
    as _i7;
import '../../features/auth/presentation/pages/provider/provider_sign_up_page.dart'
    as _i11;
import '../../features/auth/presentation/pages/provider/sign_up_second.dart'
    as _i5;
import '../../features/auth/presentation/pages/provider/success_sign.dart'
    as _i6;
import '../../features/auth/presentation/pages/reset_password_page.dart'
    as _i16;
import '../../features/auth/presentation/pages/user_type_screen.dart' as _i20;
import '../../features/auth/presentation/pages/verification_page.dart' as _i18;
import '../../features/introduction/pages/intro_screen.dart' as _i13;
import '../../features/introduction/pages/splash_screen.dart' as _i1;
import '../../features/provider/home/presentation/pages/provider_home_page.dart'
    as _i2;
import '../../features/provider/new_request/presentation/pages/new_request_page.dart'
    as _i8;
import '../../features/provider/new_request/presentation/pages/request_details_page.dart'
    as _i9;
import '../../features/request/data/models/request_model.dart' as _i24;
import '../../features/user/home/presentation/pages/home_page.dart' as _i3;
import '../../features/user/notifications/presentation/pages/notifications_page.dart'
    as _i17;
import '../../features/user/notifications/presentation/pages/try_again.dart'
    as _i12;
import '../../features/user/order/presentation/pages/complete_request_page.dart'
    as _i10;
import '../../features/user/request_accepted/presentaion/pages/chat_screen.dart'
    as _i21;
import '../../features/user/request_accepted/presentaion/pages/neares_provider_screen.dart'
    as _i19;

class AppRouter extends _i22.RootStackRouter {
  AppRouter([_i23.GlobalKey<_i23.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i22.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
      );
    },
    ProviderHomeRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.ProviderHomePage(),
      );
    },
    HomePAGE.name: (routeData) {
      final args =
          routeData.argsAs<HomePAGEArgs>(orElse: () => const HomePAGEArgs());
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.HomePAGE(
          key: args.key,
          requestClass: args.requestClass,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    SignUpSecond.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.SignUpSecond(),
      );
    },
    ProviderSuccessSignUp.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ProviderSuccessSignUp(),
      );
    },
    ProviderLogin.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.ProviderLogin(),
      );
    },
    ProviderNewRequestPageRoute.name: (routeData) {
      final args = routeData.argsAs<ProviderNewRequestPageRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.ProviderNewRequestPage(
          key: args.key,
          request: args.request,
        ),
      );
    },
    RequestDetailsPageRoute.name: (routeData) {
      final args = routeData.argsAs<RequestDetailsPageRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.RequestDetailsPage(
          key: args.key,
          request: args.request,
        ),
      );
    },
    CompleteRequestRoute.name: (routeData) {
      final args = routeData.argsAs<CompleteRequestRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.CompleteRequestPage(
          key: args.key,
          requestClass: args.requestClass,
        ),
      );
    },
    ProviderSignUpRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ProviderSignUpPage(),
      );
    },
    TryAgainRoute.name: (routeData) {
      final args = routeData.argsAs<TryAgainRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.TryAgain(
          key: args.key,
          requestClass: args.requestClass,
        ),
      );
    },
    IntroScreen.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.IntroScreen(),
      );
    },
    ConfirmLocationRoute.name: (routeData) {
      final args = routeData.argsAs<ConfirmLocationRouteArgs>(
          orElse: () => const ConfirmLocationRouteArgs());
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.ConfirmLocationPage(
          key: args.key,
          onConfirm: args.onConfirm,
        ),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.ForgotPasswordPage(),
      );
    },
    ReserPasswordRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.ReserPasswordPage(),
      );
    },
    NotificationsPageRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.NotificationsPage(),
      );
    },
    VerificationRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i18.VerificationPage(),
      );
    },
    NearesProviderScreenRoute.name: (routeData) {
      final args = routeData.argsAs<NearesProviderScreenRouteArgs>(
          orElse: () => const NearesProviderScreenRouteArgs());
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.NearesProviderScreen(
          key: args.key,
          request: args.request,
        ),
      );
    },
    UserTypeScreen.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.UserTypeScreen(),
      );
    },
    ChatScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ChatScreenRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i21.ChatScreen(
          key: args.key,
          recieverId: args.recieverId,
          recieverImage: args.recieverImage,
          senderId: args.senderId,
          name: args.name,
          recieverType: args.recieverType,
        ),
      );
    },
  };

  @override
  List<_i22.RouteConfig> get routes => [
        _i22.RouteConfig(
          SplashScreen.name,
          path: '/',
        ),
        _i22.RouteConfig(
          ProviderHomeRoute.name,
          path: '/provider-home-page',
        ),
        _i22.RouteConfig(
          HomePAGE.name,
          path: '/home-pa-gE',
        ),
        _i22.RouteConfig(
          LoginRoute.name,
          path: '/login-page',
        ),
        _i22.RouteConfig(
          SignUpSecond.name,
          path: '/sign-up-second',
        ),
        _i22.RouteConfig(
          ProviderSuccessSignUp.name,
          path: '/provider-success-sign-up',
        ),
        _i22.RouteConfig(
          ProviderLogin.name,
          path: '/provider-login',
        ),
        _i22.RouteConfig(
          ProviderNewRequestPageRoute.name,
          path: '/provider-new-request-page',
        ),
        _i22.RouteConfig(
          RequestDetailsPageRoute.name,
          path: '/request-details-page',
        ),
        _i22.RouteConfig(
          CompleteRequestRoute.name,
          path: '/complete-request-page',
        ),
        _i22.RouteConfig(
          ProviderSignUpRoute.name,
          path: '/provider-sign-up-page',
        ),
        _i22.RouteConfig(
          TryAgainRoute.name,
          path: '/try-again',
        ),
        _i22.RouteConfig(
          IntroScreen.name,
          path: '/intro-screen',
        ),
        _i22.RouteConfig(
          ConfirmLocationRoute.name,
          path: '/confirm-location-page',
        ),
        _i22.RouteConfig(
          ForgotPasswordRoute.name,
          path: '/forgot-password-page',
        ),
        _i22.RouteConfig(
          ReserPasswordRoute.name,
          path: '/reser-password-page',
        ),
        _i22.RouteConfig(
          NotificationsPageRoute.name,
          path: '/notifications-page',
        ),
        _i22.RouteConfig(
          VerificationRoute.name,
          path: '/verification-page',
        ),
        _i22.RouteConfig(
          NearesProviderScreenRoute.name,
          path: '/neares-provider-screen',
        ),
        _i22.RouteConfig(
          ProviderSuccessSignUp.name,
          path: '/provider-success-sign-up',
        ),
        _i22.RouteConfig(
          UserTypeScreen.name,
          path: '/user-type-screen',
        ),
        _i22.RouteConfig(
          ChatScreenRoute.name,
          path: '/chat-screen',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreen extends _i22.PageRouteInfo<void> {
  const SplashScreen()
      : super(
          SplashScreen.name,
          path: '/',
        );

  static const String name = 'SplashScreen';
}

/// generated route for
/// [_i2.ProviderHomePage]
class ProviderHomeRoute extends _i22.PageRouteInfo<void> {
  const ProviderHomeRoute()
      : super(
          ProviderHomeRoute.name,
          path: '/provider-home-page',
        );

  static const String name = 'ProviderHomeRoute';
}

/// generated route for
/// [_i3.HomePAGE]
class HomePAGE extends _i22.PageRouteInfo<HomePAGEArgs> {
  HomePAGE({
    _i23.Key? key,
    _i24.RequestClass? requestClass,
  }) : super(
          HomePAGE.name,
          path: '/home-pa-gE',
          args: HomePAGEArgs(
            key: key,
            requestClass: requestClass,
          ),
        );

  static const String name = 'HomePAGE';
}

class HomePAGEArgs {
  const HomePAGEArgs({
    this.key,
    this.requestClass,
  });

  final _i23.Key? key;

  final _i24.RequestClass? requestClass;

  @override
  String toString() {
    return 'HomePAGEArgs{key: $key, requestClass: $requestClass}';
  }
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i22.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.SignUpSecond]
class SignUpSecond extends _i22.PageRouteInfo<void> {
  const SignUpSecond()
      : super(
          SignUpSecond.name,
          path: '/sign-up-second',
        );

  static const String name = 'SignUpSecond';
}

/// generated route for
/// [_i6.ProviderSuccessSignUp]
class ProviderSuccessSignUp extends _i22.PageRouteInfo<void> {
  const ProviderSuccessSignUp()
      : super(
          ProviderSuccessSignUp.name,
          path: '/provider-success-sign-up',
        );

  static const String name = 'ProviderSuccessSignUp';
}

/// generated route for
/// [_i7.ProviderLogin]
class ProviderLogin extends _i22.PageRouteInfo<void> {
  const ProviderLogin()
      : super(
          ProviderLogin.name,
          path: '/provider-login',
        );

  static const String name = 'ProviderLogin';
}

/// generated route for
/// [_i8.ProviderNewRequestPage]
class ProviderNewRequestPageRoute
    extends _i22.PageRouteInfo<ProviderNewRequestPageRouteArgs> {
  ProviderNewRequestPageRoute({
    _i23.Key? key,
    required _i24.RequestClass request,
  }) : super(
          ProviderNewRequestPageRoute.name,
          path: '/provider-new-request-page',
          args: ProviderNewRequestPageRouteArgs(
            key: key,
            request: request,
          ),
        );

  static const String name = 'ProviderNewRequestPageRoute';
}

class ProviderNewRequestPageRouteArgs {
  const ProviderNewRequestPageRouteArgs({
    this.key,
    required this.request,
  });

  final _i23.Key? key;

  final _i24.RequestClass request;

  @override
  String toString() {
    return 'ProviderNewRequestPageRouteArgs{key: $key, request: $request}';
  }
}

/// generated route for
/// [_i9.RequestDetailsPage]
class RequestDetailsPageRoute
    extends _i22.PageRouteInfo<RequestDetailsPageRouteArgs> {
  RequestDetailsPageRoute({
    _i23.Key? key,
    required _i24.RequestClass request,
  }) : super(
          RequestDetailsPageRoute.name,
          path: '/request-details-page',
          args: RequestDetailsPageRouteArgs(
            key: key,
            request: request,
          ),
        );

  static const String name = 'RequestDetailsPageRoute';
}

class RequestDetailsPageRouteArgs {
  const RequestDetailsPageRouteArgs({
    this.key,
    required this.request,
  });

  final _i23.Key? key;

  final _i24.RequestClass request;

  @override
  String toString() {
    return 'RequestDetailsPageRouteArgs{key: $key, request: $request}';
  }
}

/// generated route for
/// [_i10.CompleteRequestPage]
class CompleteRequestRoute
    extends _i22.PageRouteInfo<CompleteRequestRouteArgs> {
  CompleteRequestRoute({
    _i23.Key? key,
    required _i24.RequestClass requestClass,
  }) : super(
          CompleteRequestRoute.name,
          path: '/complete-request-page',
          args: CompleteRequestRouteArgs(
            key: key,
            requestClass: requestClass,
          ),
        );

  static const String name = 'CompleteRequestRoute';
}

class CompleteRequestRouteArgs {
  const CompleteRequestRouteArgs({
    this.key,
    required this.requestClass,
  });

  final _i23.Key? key;

  final _i24.RequestClass requestClass;

  @override
  String toString() {
    return 'CompleteRequestRouteArgs{key: $key, requestClass: $requestClass}';
  }
}

/// generated route for
/// [_i11.ProviderSignUpPage]
class ProviderSignUpRoute extends _i22.PageRouteInfo<void> {
  const ProviderSignUpRoute()
      : super(
          ProviderSignUpRoute.name,
          path: '/provider-sign-up-page',
        );

  static const String name = 'ProviderSignUpRoute';
}

/// generated route for
/// [_i12.TryAgain]
class TryAgainRoute extends _i22.PageRouteInfo<TryAgainRouteArgs> {
  TryAgainRoute({
    _i23.Key? key,
    required _i24.RequestClass requestClass,
  }) : super(
          TryAgainRoute.name,
          path: '/try-again',
          args: TryAgainRouteArgs(
            key: key,
            requestClass: requestClass,
          ),
        );

  static const String name = 'TryAgainRoute';
}

class TryAgainRouteArgs {
  const TryAgainRouteArgs({
    this.key,
    required this.requestClass,
  });

  final _i23.Key? key;

  final _i24.RequestClass requestClass;

  @override
  String toString() {
    return 'TryAgainRouteArgs{key: $key, requestClass: $requestClass}';
  }
}

/// generated route for
/// [_i13.IntroScreen]
class IntroScreen extends _i22.PageRouteInfo<void> {
  const IntroScreen()
      : super(
          IntroScreen.name,
          path: '/intro-screen',
        );

  static const String name = 'IntroScreen';
}

/// generated route for
/// [_i14.ConfirmLocationPage]
class ConfirmLocationRoute
    extends _i22.PageRouteInfo<ConfirmLocationRouteArgs> {
  ConfirmLocationRoute({
    _i23.Key? key,
    void Function(
      _i25.LatLng,
      _i26.Placemark,
      String,
      String,
    )?
        onConfirm,
  }) : super(
          ConfirmLocationRoute.name,
          path: '/confirm-location-page',
          args: ConfirmLocationRouteArgs(
            key: key,
            onConfirm: onConfirm,
          ),
        );

  static const String name = 'ConfirmLocationRoute';
}

class ConfirmLocationRouteArgs {
  const ConfirmLocationRouteArgs({
    this.key,
    this.onConfirm,
  });

  final _i23.Key? key;

  final void Function(
    _i25.LatLng,
    _i26.Placemark,
    String,
    String,
  )? onConfirm;

  @override
  String toString() {
    return 'ConfirmLocationRouteArgs{key: $key, onConfirm: $onConfirm}';
  }
}

/// generated route for
/// [_i15.ForgotPasswordPage]
class ForgotPasswordRoute extends _i22.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: '/forgot-password-page',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i16.ReserPasswordPage]
class ReserPasswordRoute extends _i22.PageRouteInfo<void> {
  const ReserPasswordRoute()
      : super(
          ReserPasswordRoute.name,
          path: '/reser-password-page',
        );

  static const String name = 'ReserPasswordRoute';
}

/// generated route for
/// [_i17.NotificationsPage]
class NotificationsPageRoute extends _i22.PageRouteInfo<void> {
  const NotificationsPageRoute()
      : super(
          NotificationsPageRoute.name,
          path: '/notifications-page',
        );

  static const String name = 'NotificationsPageRoute';
}

/// generated route for
/// [_i18.VerificationPage]
class VerificationRoute extends _i22.PageRouteInfo<void> {
  const VerificationRoute()
      : super(
          VerificationRoute.name,
          path: '/verification-page',
        );

  static const String name = 'VerificationRoute';
}

/// generated route for
/// [_i19.NearesProviderScreen]
class NearesProviderScreenRoute
    extends _i22.PageRouteInfo<NearesProviderScreenRouteArgs> {
  NearesProviderScreenRoute({
    _i23.Key? key,
    _i24.RequestClass? request,
  }) : super(
          NearesProviderScreenRoute.name,
          path: '/neares-provider-screen',
          args: NearesProviderScreenRouteArgs(
            key: key,
            request: request,
          ),
        );

  static const String name = 'NearesProviderScreenRoute';
}

class NearesProviderScreenRouteArgs {
  const NearesProviderScreenRouteArgs({
    this.key,
    this.request,
  });

  final _i23.Key? key;

  final _i24.RequestClass? request;

  @override
  String toString() {
    return 'NearesProviderScreenRouteArgs{key: $key, request: $request}';
  }
}

/// generated route for
/// [_i20.UserTypeScreen]
class UserTypeScreen extends _i22.PageRouteInfo<void> {
  const UserTypeScreen()
      : super(
          UserTypeScreen.name,
          path: '/user-type-screen',
        );

  static const String name = 'UserTypeScreen';
}

/// generated route for
/// [_i21.ChatScreen]
class ChatScreenRoute extends _i22.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute({
    _i23.Key? key,
    required String recieverId,
    required String recieverImage,
    required String senderId,
    required String name,
    required String recieverType,
  }) : super(
          ChatScreenRoute.name,
          path: '/chat-screen',
          args: ChatScreenRouteArgs(
            key: key,
            recieverId: recieverId,
            recieverImage: recieverImage,
            senderId: senderId,
            name: name,
            recieverType: recieverType,
          ),
        );

  static const String name = 'ChatScreenRoute';
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs({
    this.key,
    required this.recieverId,
    required this.recieverImage,
    required this.senderId,
    required this.name,
    required this.recieverType,
  });

  final _i23.Key? key;

  final String recieverId;

  final String recieverImage;

  final String senderId;

  final String name;

  final String recieverType;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, recieverId: $recieverId, recieverImage: $recieverImage, senderId: $senderId, name: $name, recieverType: $recieverType}';
  }
}
