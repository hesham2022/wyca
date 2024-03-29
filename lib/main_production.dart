// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/app/app.dart';
import 'package:wyca/bootstrap.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  await Fluttertoast.showToast(msg: message.data.toString());
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
        enableLights: true
        
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
  await bootstrap(() => const App());
}
