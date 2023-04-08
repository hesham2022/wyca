import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

 

  @override
  LoaderState createState() => LoaderState();
}

class LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animation = Tween<double>(begin: 5, end: 3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animationController.value * 4.0 * 3.14,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CustomPaint(
                      painter: ArcPainter(radius: _animation.value),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  ArcPainter({
    this.radius = 5,
  });
  final double radius;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: size.width / radius,
      height: size.height / radius,
    );
    canvas
      ..drawArc(rect, 3.14 / 4, 3.14 / 2, false, paint)
      ..drawArc(rect, -3.14 / 4, -3.14 / 2, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
