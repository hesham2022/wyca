// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/app/app.dart';
import 'package:wyca/app/view/shared_storage.dart';
import 'package:wyca/bootstrap.dart';
import 'package:wyca/core/local_storage/secure_storage_instance.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  await AwesomeNotifications().initialize(
    'resource://mipmap/ic_launcher',
    [
      NotificationChannel(
        channelGroupKey: 'basic_tests',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        enableLights: true,
      )
    ],
  );
  try {
    await Fluttertoast.showToast(msg: 'background');
    // notificationsBudgeCubit.newNotifion();

    final data =
        jsonDecode(event.data['data'] as String) as Map<String, dynamic>;

    final s = data['request'] as Map<String, dynamic>;
    final id = await SharedStorage().getNotificationId(s['id'] as String);

    // await AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //     id: id,
    //     channelKey: 'basic_channel',
    //     title: event.notification!.title ?? '',
    //     // largeIcon: 'asset://${Assets.images.logo.path}',
    //     // bigPicture: 'asset://${Assets.images.logo.path}',
    //   ),
    // );

    if (data['userModel'] != null) {
      s['userModel'] = data['userModel'] as Map<String, dynamic>;
    }
    if (data['providerModel'] != null) {
      s['providerModel'] = data['providerModel'] as Map<String, dynamic>;
    }
    final newRequest = RequestClass.fromMap(s)
      ..setdate = event.sentTime ?? DateTime.now();

    await Storage.setNewRequests(newRequest);
    // await Storage.setNewRequests(newRequest);
    // await pnCubit.addNewNotification(newRequest);
    // // await Fluttertoast.showToast(msg: newRequest.canceled.toString());
    // if (globalAuthBloc != null && !globalAuthBloc!.isUser) {
    //   // appRouter.navigatorKey.currentState!.pop();
    //   if (newRequest.status == 0 || newRequest.status == 4) {
    //     await appRouter.push(
    //       ProviderNewRequestPageRoute(
    //         request: newRequest,
    //       ),
    //     );
    //   } else {
    //     await appRouter.push(
    //       RequestDetailsPageRoute(
    //         request: newRequest,
    //       ),
    //     );
    //   }
    // }
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
  }
}

final n = NotificationChannel(
  channelGroupKey: 'basic_tests',
  channelKey: 'basic_channel',
  channelName: 'Basic notifications',
  channelDescription: 'Notification channel for basic tests',
  defaultColor: const Color(0xFF9D50DD),
  ledColor: Colors.white,
  importance: NotificationImportance.Max,
);
void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  // await NotificationService().init();
  await AwesomeNotifications().initialize(
    'resource://mipmap/ic_launcher',
    [
      NotificationChannel(
        channelGroupKey: 'basic_tests',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        enableLights: true,
      ),
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final messaging = FirebaseMessaging.instance;
  // await messaging.requestPermission();
  // final settings = await messaging.requestPermission();

  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   print('User granted permission');
  // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //   print('User granted provisional permission');
  // } else {
  //   print('User declined or has not accepted permission');
  // }
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FirebaseMessaging.instance.getToken().then(print);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   Fluttertoast.showToast(msg: message.data.toString());
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   Fluttertoast.showToast(msg: 'opende');
  // });
  // await FirebaseMessaging.instance.getInitialMessage().then((v) {
  //   Fluttertoast.showToast(msg: 'opende');
  // });
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   Fluttertoast.showToast(msg: message.data.toString());
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await bootstrap(() => const App());
}
