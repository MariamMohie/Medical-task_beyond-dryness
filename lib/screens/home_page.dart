import 'dart:math' as math;

import 'package:desktop_game_skincare/screens/organ_discovery_page.dart';
import 'package:desktop_game_skincare/widgets/novartis_logo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          final compact = size.width < 820;
          final leftPadding = _scale(
            size.width,
            compact ? 24 : 72,
            compact ? 42 : 92,
          );
          final topPadding = _scale(
            size.height,
            compact ? 48 : 86,
            compact ? 70 : 112,
          );
          final titleSize = _scale(
            size.width,
            compact ? 54 : 118,
            compact ? 82 : 162,
          );
          final subtitleSize = _scale(
            size.width,
            compact ? 30 : 52,
            compact ? 43 : 74,
          );

          return Stack(
            fit: StackFit.expand,
            children: [
              const _HeroBackground(),
              const _BottomWash(),
              Positioned(
                right: _scale(size.width, 26, 48),
                top: _scale(size.height, 22, 44),
                child: Image(
                  image: const AssetImage('assets/images/logo.png'),
                  width: _scale(size.width, 120, 180),
                  height: _scale(size.height, 40, 70),
                ),
              ),
              Positioned(
                left: leftPadding,
                top: topPadding,
                child: _TitleBlock(
                  titleSize: titleSize,
                  subtitleSize: subtitleSize,
                  compact: compact,
                ),
              ),
              Positioned(
                right: compact ? null : _scale(size.width, 30, 75),
                left: compact ? leftPadding + 10 : null,
                top: compact ? null : size.height * 0.57,
                bottom: compact ? math.max(36, size.height * 0.12) : null,
                child: _StartButton(
                  width: compact
                      ? math.min(size.width - (leftPadding * 2), 360)
                      : _scale(size.width, 330, 430),
                  height: compact ? 58 : 72,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: compact ? size.width * 0.72 : size.width * 0.48,
                  height: compact ? 130 : 220,
                  child: Image.asset(
                    'assets/images/buildings.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static double _scale(double value, double min, double max) {
    final normalized = ((value - 390) / (1440 - 390))
        .clamp(0.0, 1.0)
        .toDouble();
    return min + ((max - min) * normalized);
  }
}

class _HeroBackground extends StatelessWidget {
  const _HeroBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/background.png',
          fit: BoxFit.cover,
          alignment: Alignment.center,
          errorBuilder: (_, __, ___) => const _FallbackBackground(),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black.withValues(alpha: 0.03),
                Colors.transparent,
                const Color(0xFFE6A462).withValues(alpha: 0.18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FallbackBackground extends StatelessWidget {
  const _FallbackBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD79959), Color(0xFFF0BE79), Color(0xFFD08249)],
        ),
      ),
      child: Image.asset(
        'assets/images/buildings.png',
        fit: BoxFit.contain,
       
      ),
    );
  }
}

class _BottomWash extends StatelessWidget {
  const _BottomWash();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF2A0068).withValues(alpha: 0.34),
          ],
          stops: const [0.72, 1],
        ),
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({
    required this.titleSize,
    required this.subtitleSize,
    required this.compact,
  });

  final double titleSize;
  final double subtitleSize;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Text(
              'BEYOND\nDRYNESS',
              style: TextStyle(
                color: const Color(0xFF26005D),
                fontFamily: 'Cheddar',
                fontSize: titleSize,

                height: 0.99,
                letterSpacing: 1,
              ),
            ),
            // Text(
            //   'BEYOND\nDRYNESS',
            //   style: TextStyle(
            //     color: const Color(0xFF26005D),
            //     fontFamily: 'Cheddar',
            //     fontSize: titleSize,
            //     fontWeight: FontWeight.w900,
            //     height: 0.86,
            //     letterSpacing: 0,
            //     shadows: [
            //       Shadow(
            //         color: const Color(0xFFE6A85E).withValues(alpha: 0.22),
            //         offset: const Offset(2, 1),
            //         blurRadius: 0,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        SizedBox(height: compact ? 16 : 22),
        Text(
          'REFRAMING\nSJ\u00D6GREN\u2019S DISEASE',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'LeagueGothic',
            fontSize: subtitleSize,

            height: 1.08,
            letterSpacing: 0,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.16),
                offset: const Offset(0, 2),
                blurRadius: 7,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const OrganDiscoveryPage()),
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 1.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: Color(0xFFb7723b).withValues(alpha: 0.6),
          textStyle: TextStyle(
            fontFamily: 'Arial',
            fontSize: math.max(22, height * 0.42),
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
        child: const Text('START THE JOURNEY'),
      ),
    );
  }
}

// class _SkylinePainter extends CustomPainter {
//   const _SkylinePainter();

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = const Color(0xFF210051);
//     final y = size.height;
//     final path = Path()
//       ..moveTo(0, y)
//       ..lineTo(size.width * 0.05, y * 0.74)
//       ..lineTo(size.width * 0.09, y * 0.61)
//       ..lineTo(size.width * 0.12, y * 0.72)
//       ..lineTo(size.width * 0.17, y * 0.54)
//       ..lineTo(size.width * 0.2, y * 0.52)
//       ..lineTo(size.width * 0.23, y * 0.72)
//       ..lineTo(size.width * 0.28, y * 0.68)
//       ..lineTo(size.width * 0.31, y * 0.72)
//       ..lineTo(size.width * 0.36, y * 0.28)
//       ..lineTo(size.width * 0.38, y * 0.04)
//       ..lineTo(size.width * 0.4, y * 0.68)
//       ..lineTo(size.width * 0.47, y * 0.58)
//       ..lineTo(size.width * 0.53, y * 0.48)
//       ..lineTo(size.width * 0.59, y * 0.85)
//       ..lineTo(size.width * 0.64, y * 0.86)
//       ..lineTo(size.width * 0.64, y * 0.45)
//       ..lineTo(size.width * 0.72, y * 0.45)
//       ..lineTo(size.width * 0.72, y * 0.86)
//       ..lineTo(size.width * 0.86, y * 0.86)
//       ..lineTo(size.width, y * 0.74)
//       ..lineTo(size.width, y)
//       ..close();
//     canvas.drawPath(path, paint);

//     final bridgePaint = Paint()
//       ..color = const Color(0xFF210051)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//     canvas.drawLine(
//       Offset(0, y * 0.85),
//       Offset(size.width * 0.42, y),
//       bridgePaint,
//     );
//     canvas.drawLine(
//       Offset(size.width * 0.03, y * 0.76),
//       Offset(size.width * 0.42, y),
//       bridgePaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class _FallbackAnatomyPainter extends CustomPainter {
//   const _FallbackAnatomyPainter();

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width * 0.5, size.height * 0.48);
//     final dustyPaint = Paint()
//       ..color = const Color(0xFF9D5E34).withValues(alpha: 0.18)
//       ..style = PaintingStyle.fill;
//     final bodyPaint = Paint()
//       ..color = const Color(0xFFC9854F).withValues(alpha: 0.5)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = math.max(2, size.width * 0.006)
//       ..strokeCap = StrokeCap.round;

//     for (var i = 0; i < 56; i++) {
//       final angle = i * 0.72;
//       final radius = 20 + (i % 9) * 18.0;
//       canvas.drawCircle(
//         Offset(
//           center.dx - 95 + math.cos(angle) * radius,
//           center.dy + math.sin(angle) * radius,
//         ),
//         2 + (i % 4),
//         dustyPaint,
//       );
//     }

//     canvas.drawOval(
//       Rect.fromCenter(
//         center: Offset(center.dx, size.height * 0.26),
//         width: size.width * 0.16,
//         height: size.height * 0.2,
//       ),
//       bodyPaint,
//     );
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromCenter(
//           center: Offset(center.dx, size.height * 0.56),
//           width: size.width * 0.28,
//           height: size.height * 0.56,
//         ),
//         Radius.circular(size.width * 0.08),
//       ),
//       bodyPaint,
//     );
//     canvas.drawLine(
//       Offset(center.dx, size.height * 0.37),
//       Offset(center.dx, size.height * 0.78),
//       bodyPaint,
//     );
//     canvas.drawOval(
//       Rect.fromCenter(
//         center: Offset(center.dx - size.width * 0.055, size.height * 0.49),
//         width: size.width * 0.08,
//         height: size.height * 0.13,
//       ),
//       bodyPaint,
//     );
//     canvas.drawOval(
//       Rect.fromCenter(
//         center: Offset(center.dx + size.width * 0.055, size.height * 0.49),
//         width: size.width * 0.08,
//         height: size.height * 0.13,
//       ),
//       bodyPaint,
//     );
//     canvas.drawOval(
//       Rect.fromCenter(
//         center: Offset(center.dx - size.width * 0.05, size.height * 0.68),
//         width: size.width * 0.06,
//         height: size.height * 0.08,
//       ),
//       bodyPaint,
//     );
//     canvas.drawOval(
//       Rect.fromCenter(
//         center: Offset(center.dx + size.width * 0.05, size.height * 0.68),
//         width: size.width * 0.06,
//         height: size.height * 0.08,
//       ),
//       bodyPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
