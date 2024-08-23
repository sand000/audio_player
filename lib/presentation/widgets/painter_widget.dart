import 'package:flutter/material.dart';

class PainterWidget extends CustomPainter {
  final List<double> frequencies;

  PainterWidget(this.frequencies);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF6A5ACD)
      ..style = PaintingStyle.fill;

    final double barWidth = size.width / frequencies.length;
    final double maxBarHeight = size.height;

    for (int i = 0; i < frequencies.length; i = i + 1) {
      final double barHeight = maxBarHeight * frequencies[i];
      final double x = i * (4 * barWidth);
      final double y = maxBarHeight - barHeight;

      canvas.drawRect(
        Rect.fromLTWH(x / 4, y / 3, 2, barHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
