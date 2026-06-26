import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LungsPage extends StatefulWidget {
  const LungsPage({super.key});

  @override
  State<LungsPage> createState() => _LungsPageState();
}

class _LungsPageState extends State<LungsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _percent;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _percent = Tween<double>(
      begin: 0,
      end: 20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const purple = Color(0xFF31115E);

  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    const referenceHeight = 800.0;
    final heightScale = (size.height / referenceHeight).clamp(0.5, 1.0);

    return Scaffold(
      body: Stack(
        children: [
          /// Background image
          Positioned.fill(
            child: Image.asset(
              "assets/images/lungs2.png",
              fit: BoxFit.cover,
            ),
          ),

          /// Beige overlay
          Positioned.fill(child: Container(decoration: const BoxDecoration())),

          /// Bottom purple fade
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 140,
            child: IgnorePointer(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xAA4A1E63)],
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 70 : 24,
                vertical: isDesktop ? 15 : 10,
              ),
              child: Column(
                children: [
                  /// Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 200 * heightScale,
                        height: 50 * heightScale,
                      ),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildContent(isDesktop, heightScale)),

                      SizedBox(width: 30 * heightScale),
                    ],
                  ),

                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildFooter(isDesktop, heightScale),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(bool isDesktop, double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: (isDesktop ? 20 : 10) * scale),

        Text(
          "LUNGS",
          style: TextStyle(
            color: purple,
            fontWeight: FontWeight.w700,
            fontSize: (isDesktop ? 95 : 70) * scale,
            fontFamily: 'LeagueGothic',
            height: 0.95,
          ),
        ),

        SizedBox(height: (isDesktop ? 25 : 10) * scale),

        Row(
          children: [
            AnimatedBuilder(
              animation: _percent,
              builder: (context, _) {
                return PercentRing(
                  percent: _percent.value,
                  size: (isDesktop ? 120 : 100) * scale,
                );
              },
            ),

            SizedBox(width: 20 * scale),

            Expanded(
              child: Text(
                "Lung involvement occurs  \nin up to 20% of patients.¹",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28 * scale,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: (isDesktop ? 30 : 20) * scale),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/smalllung.png',
              width: 120 * scale,
              height: 150 * scale,
            ),
            Gap(10 * scale),
            Expanded(
              child: Text(
                "Inflammation and glandular damage in\n"
                "Sjögren’s disease can affect the airways\n"
                "including the trachea, bronchi, and\n"
                "bronchioles. This may lead to airway\n"
                "disease or interstitial lung disease (ILD).¹",
                style: TextStyle(
                  color: purple,
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/lungs3.png',
              width: 120 * scale,
              height: 150 * scale,
            ),
            Gap(10 * scale),
            Expanded(
              child: Text(
                "Lung involvement in Sjögren’s disease\n"
                "increases mortality fourfold.²\n",
                style: TextStyle(
                  color: purple,
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooter(bool desktop, double scale) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            "References:\n"
            "1. Flament T, Bigot A, Chaigne B, Henique H, Diot E, Marchand-Adam S. Pulmonary manifestations of Sjögren's syndrome. European Respiratory Review. 2016;25(140):110-23.\n"
            "2. Stojan G, Baer AN, Danoff SK. Pulmonary manifestations of Sjögren’s syndrome. Current allergy and asthma reports. 2013;13(4):354-60.",
            style: TextStyle(
              color: Colors.white.withOpacity(.9),
              fontSize: (desktop ? 9 : 7) * scale.clamp(0.8, 1.0),
              height: 1.4,
            ),
          ),
        ),

        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 70 * scale,
            height: 70 * scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white),
              color: const Color(0xff7b5c59).withOpacity(0.8),
            ),
            child: Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 34 * scale,
            ),
          ),
        ),
      ],
    );
  }
}

class PercentRing extends StatelessWidget {
  final double percent;
  final double size;

  const PercentRing({super.key, required this.percent, required this.size});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF31115E);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: RingPainter(percent: 100, color: Colors.white),
          ),
          CustomPaint(
            size: Size(size, size),
            painter: RingPainter(percent: percent, color: purple),
          ),
          Text(
            "${percent.round()}%",
            style: TextStyle(
              color: purple,
              fontSize: size * .25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double percent;
  final Color color;

  RingPainter({required this.percent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 12.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke
      ..color = color;

    canvas.drawArc(
      Rect.fromLTWH(
        stroke,
        stroke,
        size.width - stroke * 2,
        size.height - stroke * 2,
      ),
      -math.pi / 2,
      (percent / 100) * (2 * math.pi),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}