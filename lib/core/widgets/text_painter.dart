import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class TextPainter extends CustomPainter {
  TextPainter({required this.animation});
  final double animation;
  @override
  void paint(Canvas canvas, Size size) {
    // create canavas paragraph

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
    final paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontSize: 20,
        fontFamily: 'Cairo',
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.justify,
      ),
    )
      ..pushStyle(ui.TextStyle(color: Colors.yellow))
      ..addText('text');
    final paragraph = paragraphBuilder.build()
      ..layout(
        ui.ParagraphConstraints(
          width: (size.width - 12.0) - (12.0),
        ),
      );
    canvas.drawParagraph(paragraph, Offset(12 * animation, 36 * animation));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
