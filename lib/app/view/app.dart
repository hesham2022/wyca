// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:wyca/app/view/chat_data.dart';
import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/core/local_storage/secure_storage_instance.dart';
import 'package:wyca/core/routing/routes.gr.dart' as router;
import 'package:wyca/core/routing/routes.gr.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/domain/repositories/i_respository.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/auth/presentation/bloc/provider_cubit.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';
import 'package:wyca/features/auth/presentation/forget_password_bloc/forget_password_cubit.dart';
import 'package:wyca/features/chat/data/models/chat_model.dart';
import 'package:wyca/features/companmy_setting/presentation/bloc/calling_bloc.dart';
import 'package:wyca/features/companmy_setting/presentation/bloc/comlainment_cubit.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/presentation/provider_notification_cubit.dart';
import 'package:wyca/features/request/presentation/request_cubit.dart';
import 'package:wyca/features/request/presentation/request_provider.dart';
import 'package:wyca/features/user/home/presentation/packages_bloc/packages_bloc.dart';
import 'package:wyca/features/user/order/presentation/bloc/order_bloc.dart';
import 'package:wyca/imports.dart';

String kFcm = '';
String kLang = 'en';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications',
  importance: Importance.max,
  description: 'notification descriptip',
);

class NotificationsBudgeCubit extends Cubit<int> {
  NotificationsBudgeCubit() : super(0);
  void newNotifion() => emit(state + 1);
  void read() => emit(0);
}

final notificationsBudgeCubit = NotificationsBudgeCubit();

class App extends StatefulWidget {
  const App({super.key});

  static void changeLanguage(BuildContext context, String language) =>
      context.findRootAncestorStateOfType<_AppState>()!.setLocale(language);
  static FormState? formState(BuildContext context) =>
      context.findRootAncestorStateOfType<FormState>();
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final IAuthenticationRepository authenticationRepository = getIt();
  final _appRouter = router.AppRouter();
  final chatCubit = ChatCubit();
  final AuthenticationBloc authBloc = getIt();
  final navKey = GlobalKey<NavigatorState>();
  void setLocale(String locale) {
    setState(() {
      _locale = locale;
    });
    Storage.setLang(locale);
    kLang = locale;
  }

  Socket socket = io(
    domain,
    OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect() // disable auto-connection
        .setExtraHeaders(<String, String>{'foo': 'bar'}) // optional
        .build(),
  );

  String _locale = 'en';
  final pnCubit = PNCubit();
  @override
  void initState() {
    // Storage.rsestData();
    socket
      ..connect()
      ..on('getMessage', (dynamic data) {
        final message = data as Map<String, dynamic>;
        final _message = Messages.fromJson(
          data,
        );

        chatCubit
          ..addNewChat(
            message['senderId'].toString(),
            message['chatId'] as String,
          )
          ..addMessage(_message);
      })
      ..onAny((event, dynamic data) {
        print(event);
      });
    FirebaseMessaging.instance.getToken().then((value) {
      debugPrint('fcm $value');

      return kFcm = value!;
    });
    FirebaseMessaging.onMessage.listen((event) async {
      await Fluttertoast.showToast(msg: 'new msg');
      notificationsBudgeCubit.newNotifion();

      try {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: event.hashCode,
            channelKey: 'basic_channel',
            title: event.notification!.title ?? '',
            // largeIcon: 'asset://${Assets.images.logo.path}',
            // bigPicture: 'asset://${Assets.images.logo.path}',
          ),
        );

        final data =
            jsonDecode(event.data['data'] as String) as Map<String, dynamic>;

        final s = data['request'] as Map<String, dynamic>;
        if (data['userModel'] != null) {
          s['userModel'] = data['userModel'] as Map<String, dynamic>;
        }
        if (data['providerModel'] != null) {
          s['providerModel'] = data['providerModel'] as Map<String, dynamic>;
        }
        final newRequest = RequestClass.fromMap(s)
          ..setdate = event.sentTime ?? DateTime.now();

        // await Storage.setNewRequests(newRequest);
        await pnCubit.addNewNotification(newRequest);
        await Fluttertoast.showToast(msg: newRequest.canceled.toString());
        if (!authBloc.isUser) {
          // _appRouter.navigatorKey.currentState!.pop();
          if (newRequest.status == 0) {
            await _appRouter.push(
              ProviderNewRequestPageRoute(
                request: newRequest,
              ),
            );
          } else {
            await _appRouter.push(
              RequestDetailsPageRoute(
                request: newRequest,
              ),
            );
          }
        }
      } catch (e, s) {
        print(e);
        print(s);
      }
    });
    Storage.getLang().then(
      (value) {
        setState(() {
          if (value != null) {
            _locale = value;
          }
        });
        kLang = value ?? 'en';

        // _locale = _locale;
      },
    );
    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: (receivedAction) async {
    //     await Navigator.push<void>(
    //       context,
    //       MaterialPageRoute(builder: (_) => const NotificationsPage()),
    //     );
    //   },
    //   // onNotificationCreatedMethod:
    //   //     NotificationController.onNotificationCreatedMethod,
    //   onNotificationDisplayedMethod: (receivedNotification) async {
    //     return;
    //   },
    //   // onDismissActionReceivedMethod:
    //   //     NotificationController.onDismissActionReceivedMethod,
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>.value(value: authBloc),
            BlocProvider<UserCubit>(create: (ctx) => getIt()),
            BlocProvider<ProviderCubit>(create: (ctx) => getIt()),
            BlocProvider<OrderBloc>(create: (ctx) => getIt()),
            BlocProvider<RequestCubit>(create: (ctx) => getIt()),
            BlocProvider<RequestProviderCubit>(create: (ctx) => getIt()),
            BlocProvider<PNCubit>(create: (ctx) => pnCubit),
            BlocProvider<ChatCubit>(create: (ctx) => chatCubit),
            BlocProvider<ForgetPasswordCubit>(create: (ctx) => getIt()),
            BlocProvider<PackagesCubit>(
              create: (_) => getIt()..getPackages(),
            ),
            BlocProvider<NotificationsBudgeCubit>.value(
              value: notificationsBudgeCubit,
            ),
            BlocProvider<CallingBloc>(
              create: (_) => getIt(),
            ),
            BlocProvider<ComplaintCubit>(
              create: (_) => getIt(),
            ),
          ],
          child: RepositoryProvider<Socket>(
            create: (_) => socket,
            child: MaterialApp.router(
              key: navKey,
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
              builder: (context, child) =>
                  BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) async {
                  await Future<void>.delayed(const Duration(seconds: 2));

                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      socket.emit(
                        'addUser',
                        {'userId': state.user.id, 'userType': 'user'},
                      );

                      await _appRouter.pushAndPopUntil(
                        router.HomePAGE(),
                        predicate: (d) => false,
                      );

                      break;
                    case AuthenticationStatus.authenticatedProvider:
                      socket.emit(
                        'addUser',
                        {'userId': state.provider!.id, 'userType': 'provider'},
                      );
                      await _appRouter.pushAndPopUntil(
                        const router.ProviderHomeRoute(),
                        predicate: (d) => false,
                      );

                      break;
                    case AuthenticationStatus.authenticatedAfterSignup:
                      await _appRouter.pushAndPopUntil(
                        router.ConfirmLocationRoute(
                          onConfirm: (p0, p1, p2) {
                            context.read<AuthenticationBloc>().add(
                                  UpdateAddresses(
                                    Address(
                                      id: '',
                                      address: p2,
                                      coordinates: [p0.latitude, p0.longitude],
                                    ),
                                  ),
                                );
                            _appRouter.pushAndPopUntil(
                              router.HomePAGE(),
                              predicate: (d) => false,
                            );
                          },
                        ),
                        predicate: (d) => false,
                      );

                      break;
                    case AuthenticationStatus.unauthenticated:
                      final isFirst = await Storage.isFirst();
                      // await Navigator.push<void>(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => const TestPage()),
                      // );
                      //await Future<void>.delayed(const Duration(seconds: 1));
                      await _appRouter.pushAndPopUntil(
                        isFirst
                            ? const router.IntroScreen()
                            : const router.UserTypeScreen(),
                        predicate: (d) => false,
                      );

                      break;
                  }
                },
                child: Directionality(
                  textDirection:
                      _locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                  child: child!,
                ),
              ),
              theme: theme,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              locale: Locale(_locale),
              supportedLocales: AppLocalizations.supportedLocales,
            ),
          ),
        ),
      ),
    );
  }
}

class FirstWidget extends StatelessWidget {
  const FirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Material(
          color: Colors.black,
          child: Padding(
            padding: kPadding,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 300,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: 'logo',
                    child: Material(child: TextFormField()),
                  ),
                ),
                Positioned(
                  top: 370,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: 'logo2',
                    child: Material(child: TextFormField()),
                  ),
                ),
                Positioned(
                  top: 600,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: 1,
                    child: Hero(
                      tag: 'second',
                      child: AppButton(
                        title: 'go to second',
                        onPressed: () {
                          Navigator.push<void>(
                            context,

                            PageRouteBuilder(
                              transitionDuration: const Duration(seconds: 1),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: const Material(
                                    child: SecondWidget(),
                                  ),
                                );
                              },
                            ),

                            // MaterialPageRoute(
                            //   builder: (context) =>
                            //       const Material(child: SecondWidget()),
                            // ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class SecondWidget extends StatelessWidget {
  const SecondWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Material(
          child: Padding(
            padding: kPadding,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 360,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: 'logo',
                    child: Material(child: Container(child: TextFormField())),
                  ),
                ),
                const Positioned(
                  top: 600,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: 1,
                    child: Text('s'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
