import 'package:auto_route/auto_route.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/core/routing/routes.gr.dart';
import 'package:wyca/core/theme/colors.dart';
import 'package:wyca/features/introduction/widget/faded_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // create animation
  late AnimationController _controller;
  late Animation<double> _animation;
// fade animation
  bool _logovisible = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _animation
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _logovisible = true;
        }
      });
    _controller.forward();
    Fluttertoast.showToast(
      msg: 'Welcome to Wyca',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: kPrimaryColor,
      textColor: Colors.white,
      fontSize: 16,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // TestPage();
        Scaffold(
      body: Stack(
        children: [
          Center(
            // container with blue color
            child: _logovisible
                ? const FadedLogo()
                : CustomPaint(
                    painter: OpenPainter(_animation.value),
                  ),
          ),
        ],
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  OpenPainter(this.animation);

  final double animation;
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 1000 * animation, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
    BuildContext context,
  ) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    await Fluttertoast.showToast(
      msg: 'Notification Received',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: kPrimaryColor,
      textColor: Colors.white,
      fontSize: 16,
    );
    await context.router.push(
      const NotificationsPageRoute(),
    );
  }
}
