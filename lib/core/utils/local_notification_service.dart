// // import 'package:firebase_messaging/firebase_messaging.dart';
// // ignore_for_file: unused_element

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:wyca/imports.dart';

// class NotificationService {
//   factory NotificationService() {
//     return _notificationService;
//   }
//   NotificationService._internal();
//   //NotificationService a singleton object
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   static const channelId = '123';

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     const initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/launcher_icon');

//     const initializationSettingsIOS = IOSInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );

//     const initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     tz.initializeTimeZones();
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: selectNotification,
//     );
//   }

//   final AndroidNotificationChannel channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     importance: Importance.max,
//   );
//   final AndroidNotificationDetails _androidNotificationDetails =
//       const AndroidNotificationDetails(
//     'channel ID',
//     'channel name',
//     priority: Priority.high,
//     importance: Importance.high,
//     color: ColorName.primaryColor,
//     colorized: true,
//   );
//   Future<void> showNotifications({
//     required int id,
//     required String titel,
//     required String body,
//   }) async {
//     try {
//       await flutterLocalNotificationsPlugin.show(
//         id,
//         titel,
//         body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//           ),
//         ),
//       );
//     } catch (e) {
//       print(e);
//     }

//     Future<void> scheduleNotifications() async {
//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'Notification Title',
//         'This is the Notification Body!',
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//         NotificationDetails(android: _androidNotificationDetails),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//       );
//     }

//     Future<void> cancelNotifications(int id) async {
//       await flutterLocalNotificationsPlugin.cancel(id);
//     }

//     Future<void> cancelAllNotifications() async {
//       await flutterLocalNotificationsPlugin.cancelAll();
//     }
//   }

//   Future<void> selectNotification(String? payload) async {
//     //handle your logic here
//   }
// }
