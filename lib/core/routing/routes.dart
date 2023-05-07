import 'package:auto_route/annotations.dart';
import 'package:wyca/features/auth/presentation/pages/confirm_location_page.dart';
import 'package:wyca/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:wyca/features/auth/presentation/pages/login.dart';
import 'package:wyca/features/auth/presentation/pages/provider/provider_login.dart';
import 'package:wyca/features/auth/presentation/pages/provider/provider_sign_up_page.dart';
import 'package:wyca/features/auth/presentation/pages/provider/sign_up_second.dart';
import 'package:wyca/features/auth/presentation/pages/provider/success_sign.dart';
import 'package:wyca/features/auth/presentation/pages/reset_password_page.dart';
import 'package:wyca/features/auth/presentation/pages/user_type_screen.dart';
import 'package:wyca/features/auth/presentation/pages/verification_page.dart';
import 'package:wyca/features/introduction/pages/intro_screen.dart';
import 'package:wyca/features/introduction/pages/splash_screen.dart';
import 'package:wyca/features/provider/home/presentation/pages/provider_home_page.dart';
import 'package:wyca/features/provider/new_request/presentation/pages/new_request_page.dart';
import 'package:wyca/features/provider/new_request/presentation/pages/request_details_page.dart';
import 'package:wyca/features/user/home/presentation/pages/home_page.dart';
import 'package:wyca/features/user/notifications/presentation/pages/notifications_page.dart';
import 'package:wyca/features/user/notifications/presentation/pages/try_again.dart';
import 'package:wyca/features/user/order/presentation/pages/complete_request_page.dart';
import 'package:wyca/features/user/request_accepted/presentaion/pages/chat_screen.dart';
import 'package:wyca/features/user/request_accepted/presentaion/pages/neares_provider_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: SplashScreen, initial: true),
    AutoRoute<dynamic>(page: ProviderHomePage),
    AutoRoute<dynamic>(page: HomePAGE),
    AutoRoute<dynamic>(page: LoginPage),
    AutoRoute<dynamic>(page: SignUpSecond),
    AutoRoute<dynamic>(page: ProviderSuccessSignUp),
    //
    AutoRoute<dynamic>(page: ProviderLogin),
    AutoRoute<dynamic>(
      page: ProviderNewRequestPage,
      name: 'ProviderNewRequestPageRoute',
    ),
    AutoRoute<dynamic>(
      page: RequestDetailsPage,
      name: 'RequestDetailsPageRoute',
    ),

    AutoRoute<dynamic>(page: CompleteRequestPage),

    AutoRoute<dynamic>(page: ProviderSignUpPage),
        AutoRoute<dynamic>(page: TryAgain, name: 'TryAgainRoute'),

    AutoRoute<dynamic>(page: IntroScreen),
    AutoRoute<dynamic>(page: ConfirmLocationPage),
    AutoRoute<dynamic>(page: ForgotPasswordPage),
    AutoRoute<dynamic>(page: ReserPasswordPage),
    AutoRoute<dynamic>(page: NotificationsPage, name: 'NotificationsPageRoute'),

    AutoRoute<dynamic>(page: VerificationPage),
    AutoRoute<dynamic>(
      page: NearesProviderScreen,
      name: 'NearesProviderScreenRoute',
    ),

    AutoRoute<dynamic>(page: ProviderSuccessSignUp),
    AutoRoute<dynamic>(page: UserTypeScreen),
    AutoRoute<dynamic>(page: ChatScreen, name: 'ChatScreenRoute'),
  ],
)
class $AppRouter {}
// flutter pub run build_runner watch --delete-conflicting-outputs