import 'dart:ui';
import 'package:flutter/material.dart';

class ExplanationCard extends StatelessWidget {
  final int? index;
  final double arrowTop;

  const ExplanationCard({
    super.key,
    required this.index,
    required this.arrowTop,
  });

  @override
  Widget build(BuildContext context) {
    if (index == null) {
      return const SizedBox.shrink();
    }

    final items = [
      (
        AssetImage('assets/images/face.png'),
        "The immune system attacks the lacrimal and salivary glands, causing inflammation and reduced production of tears and saliva.",
      ),
      (AssetImage('assets/images/list.png'),
      ""
      ),
      (
        AssetImage('assets/images/face.png'),
        "These symptoms can significantly affect quality of life, oral health, visual comfort and everyday activities.",
      ),
    ];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween(begin: .97, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      child: Stack(
        key: ValueKey(index),
        clipBehavior: Clip.none,
        children: [
          /// Arrow
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            left: -18,
            top: arrowTop,
            child: CustomPaint(
              size: const Size(18, 36),
              painter: BubbleArrowPainter(),
            ),
          ),

          /// Card
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                height: index == 1 ? 360 : 320,
                padding: index==1?const EdgeInsets.all(20):const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.3),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withOpacity(.5),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.15),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: index == 1
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/list.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Image(
                                image: items[index!].$1,
                                width: 180,
                                height: 180,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(width: 24),

                          Expanded(
                            flex: 5,
                            child: Text(
                              items[index!].$2,
                              style: const TextStyle(
                                fontSize: 22,
                                height: 1.6,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF31115E),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BubbleArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(0, size.height / 2);
    path.lineTo(size.width, size.height);
    path.close();

    final paint = Paint()
      ..color = Colors.white.withOpacity(.72)
      ..style = PaintingStyle.fill;

    canvas.drawShadow(path, Colors.black.withOpacity(.15), 4, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
