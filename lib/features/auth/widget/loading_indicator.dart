import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class LinedCirclePainter extends CustomPainter {
  final Color color;
  final double progress;

  LinedCirclePainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Number of lines in the circle
    const int linesCount = 8;

    for (int i = 0; i < linesCount; i++) {
      // Calculate angle for this line
      final angle = 2 * math.pi * i / linesCount;

      // Calculate opacity based on animation progress
      // This creates a "fade in and out" effect as the spinner rotates
      final fadePosition = (progress + (i / linesCount)) % 1.0;
      double opacity = fadePosition < 0.5
          ? fadePosition * 2
          : (1.0 - fadePosition) * 2;
      opacity = math.max(0.3, opacity); // Keep a minimum opacity for visibility

      final paint = Paint()
        // ignore: deprecated_member_use
        ..color = color.withOpacity(opacity)
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // Calculate line coordinates
      final lineLength = radius * 0.3;
      final startRadius = radius - lineLength;

      final startX = center.dx + startRadius * math.cos(angle);
      final startY = center.dy + startRadius * math.sin(angle);

      final endX = center.dx + radius * math.cos(angle);
      final endY = center.dy + radius * math.sin(angle);

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant LinedCirclePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
