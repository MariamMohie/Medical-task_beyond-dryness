import 'dart:math' as math;
import 'package:desktop_game_skincare/widgets/explanation_card.dart';
import 'package:desktop_game_skincare/widgets/novartis_logo.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EyesAndMouthPage extends StatefulWidget {
  const EyesAndMouthPage({super.key});

  @override
  State<EyesAndMouthPage> createState() => _EyesAndMouthPageState();
}

class _EyesAndMouthPageState extends State<EyesAndMouthPage>
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
      end: 87,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  double getArrowPosition() {
    switch (hoveredIndex) {
      case 0:
        return 100;
      case 1:
        return 180;
      case 2:
        return 250;
      default:
        return 40;
    }
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
              "assets/images/eye_mouth.png",
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
                      SizedBox(
                        width: 460,
                        child: _buildContent(isDesktop, heightScale),
                      ),

                      SizedBox(width: 30 * heightScale),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/face.png',
                        width: 110 * heightScale,
                        height: 90 * heightScale,
                      ),
                      Gap(8 * heightScale),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: purple,
                            fontSize: 22 * heightScale,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "The immune system attacks the lacrimal and salivary glands, causing\n"
                                  "inflammation and reduced tear and saliva production.",
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.top,
                              child: Transform.translate(
                                offset: const Offset(0, -2.2),
                                child: Text(
                                  "2,3",
                                  style: TextStyle(
                                    color: purple,
                                    fontSize: (22 * heightScale) * 0.65,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
          "EYES AND MOUTH",
          style: TextStyle(
            color: purple,
            fontWeight: FontWeight.w700,
            fontSize: (isDesktop ? 95 : 70) * scale,
            fontFamily: 'LeagueGothic',
            height: 0.95,
          ),
        ),

        SizedBox(height: (isDesktop ? 30 : 18) * scale),

        Text(
          "Dry Eyes & Dry Mouth: \n Hallmark Manifestations\n of Sjögren’s Disease.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 34 * scale,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 6 * scale),

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
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: purple,
                    fontSize: 28 * scale,
                    height: 1.3,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          "of patients report eye\n"
                          "and/or mouth dryness.",
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: Transform.translate(
                        offset: const Offset(0, -7),
                        child: Text(
                          "1",
                          style: TextStyle(
                            color: purple,
                            fontWeight: FontWeight.w600,
                            fontSize: (28 * scale) * 0.60,
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

        SizedBox(height: (isDesktop ? 30 : 20) * scale),
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
            "1. Marvel J, Kenney G, Church J, et al. Spotlight on Sjögren’s: a patient perspective on burden of illness and unmet needs–results from a real-world survey. RMD open. 2026;12(1).\n"
            "2. Meng Q, Ma J, Cui J, Gu Y, Shan Y. Subpopulation dynamics of T and B lymphocytes in Sjögren’s syndrome: implications for disease activity and treatment. Frontiers in Immunology. 2024;15:1468469.\n"
            "3. Ma D, Feng Y, Lin X. Immune and non-immune mediators in the fibrosis pathogenesis of salivary gland in Sjögren’s syndrome. Frontiers in Immunology. 2024;15:1421436.",
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
    const stroke = 8.0;

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
