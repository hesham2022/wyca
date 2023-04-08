import 'package:flutter/material.dart';
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
