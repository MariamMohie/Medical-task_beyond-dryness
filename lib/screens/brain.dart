import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BrainPage extends StatefulWidget {
  const BrainPage({super.key});

  @override
  State<BrainPage> createState() => _BrainPageState();
}

class _BrainPageState extends State<BrainPage>
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

    // Height-based scale factor so content shrinks proportionally on
    // short screens instead of overflowing. Tune referenceHeight if needed.
    const referenceHeight = 800.0;
    final heightScale = (size.height / referenceHeight).clamp(0.5, 1.0);

    return Scaffold(
      body: Stack(
        children: [
          /// Background image
          Positioned.fill(
            child: Image.asset("assets/images/brain.png", fit: BoxFit.cover),
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
          "BRAIN AND NERVES",
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
                "Neurologic involvement  \noccurs in 20% of patients.¹",
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
              'assets/images/brain1.png',
              width: 120 * scale,
              height: 160 * scale,
            ),
            Gap(10 * scale),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: purple,
                    fontSize: 22 * scale,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          "Immune-mediated inflammation can affect\n"
                          "the peripheral and central nervous system,\n"
                          "most commonly leading to peripheral\n"
                          "neuropathy, as well as brain fog and other\n"
                          "cognitive symptoms.",
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: Transform.translate(
                        offset: const Offset(0, -4),
                        child: Text(
                          "2-4",
                          style: TextStyle(
                            color: purple,
                            fontSize: (22 * scale) * 0.65,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/brain2.png',
              width: 120 * scale,
              height: 150 * scale,
            ),
            Gap(10 * scale),
            Expanded(
              child: Text(
                "Patients with Sjögren's disease have a 46%\n"
                "increased risk of cerebrovascular morbidity.⁵",
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
            "1. Delalande S, de Seze J, Fauchais AL, et al. Neurologic manifestations in primary Sjögren syndrome: a study of 82 patients. Medicine. 2004;83(5):280-91.\n"
            "2. Fahad S, Khan A, Thapa P, Khan MS, Jogiyat S, Moustafa W, Ririe AK, Zahid R, Rajput J. Spectrum of neurological complications in Sjögren’s syndrome: a comprehensive review. Cureus. 2025;17(3):e80092.\n"
            "3. Liampas A, Parperis K, Erotocritou MF, et al. Primary Sjögren syndrome-related peripheral neuropathy: A systematic review and meta-analysis. European journal of neurology. 2023;30(1):255-65\n."
            "4. Manzo C, Martinez-Suarez E, Kechida M, Isetta M, Serra-Mestres J. Cognitive function in primary Sjögren’s syndrome: a systematic review. Brain sciences. 2019;9(4):85.\n"
            "5. Beltai A, Barnetche T, Daien C, Lukas C, GaujouxViala C, Combe B, Morel J. Cardiovascular morbidity and mortality in primary Sjögren's syndrome: a systematic review and metaanalysis. Arthritis care & research. 2020;72(1):131-9.",
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
