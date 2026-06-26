import 'dart:math' as math;

import 'package:flutter/material.dart';

class NovartisLogo extends StatelessWidget {
  const NovartisLogo({super.key, required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: compact ? 28 : 34,
          height: compact ? 28 : 34,
          child: const CustomPaint(painter: NovartisMarkPainter()),
        ),
        const SizedBox(width: 8),
        Text(
          'NOVARTIS',
          style: TextStyle(
            color: const Color(0xFF070019),
            fontFamily: 'Times New Roman',
            fontSize: compact ? 20 : 29,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}

class NovartisMarkPainter extends CustomPainter {
  const NovartisMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF070019)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.11
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromLTWH(
        size.width * 0.18,
        size.height * 0.28,
        size.width * 0.64,
        size.height * 0.58,
      ),
      math.pi * 0.08,
      math.pi * 1.8,
      false,
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.12),
      Offset(size.width * 0.5, size.height * 0.55),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.02),
      Offset(size.width * 0.42, size.height * 0.34),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.06),
      Offset(size.width * 0.6, size.height * 0.34),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
