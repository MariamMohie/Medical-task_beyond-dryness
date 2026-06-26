import 'dart:math' as math;

import 'package:desktop_game_skincare/screens/brain.dart';
import 'package:desktop_game_skincare/screens/eye_mouth.dart';
import 'package:desktop_game_skincare/screens/joints.dart';
import 'package:desktop_game_skincare/screens/kidneys.dart';
import 'package:desktop_game_skincare/screens/lemph_nodes.dart';
import 'package:desktop_game_skincare/screens/lungs.dart';
import 'package:desktop_game_skincare/screens/skin.dart';
import 'package:desktop_game_skincare/widgets/novartis_logo.dart';
import 'package:flutter/material.dart';

class OrganDiscoveryPage extends StatelessWidget {
  const OrganDiscoveryPage({super.key});

  static const _canvasSize = Size(1400, 786);
  static const _organs = <OrganHotspot>[
    OrganHotspot(
      title: 'EYES & MOUTH',
      iconPath: 'assets/icons/mouth_icon.png',
      side: CalloutSide.left,
      circleCenter: Offset(375, 266),
      anchor: Offset(674, 118),
    ),

    OrganHotspot(
      title: 'LUNGS',
      iconPath: 'assets/icons/lungs_icon.png',
      side: CalloutSide.left,
      circleCenter: Offset(322, 438),
      anchor: Offset(615, 438),
    ),

    OrganHotspot(
      title: 'JOINTS',
      iconPath: 'assets/icons/joints_icon.png',
      side: CalloutSide.left,
      circleCenter: Offset(359, 633),
      anchor: Offset(506, 618),
    ),

    OrganHotspot(
      title: 'BRAIN & NERVES',
      iconPath: 'assets/icons/brain_icon.png',
      side: CalloutSide.right,
      circleCenter: Offset(1042, 134),
      anchor: Offset(732, 73),
    ),

    OrganHotspot(
      title: 'SKIN',
      iconPath: 'assets/icons/skin_icon.png',
      side: CalloutSide.right,
      circleCenter: Offset(1077, 310),
      anchor: Offset(754, 155),
    ),

    OrganHotspot(
      title: 'LYMPH NODES',
      iconPath: 'assets/icons/lymph_icon.png',
      side: CalloutSide.right,
      circleCenter: Offset(1078, 486),
      anchor: Offset(730, 250),
    ),

    OrganHotspot(
      title: 'KIDNEYS',
      iconPath: 'assets/icons/kidney_icon.png',
      side: CalloutSide.right,
      circleCenter: Offset(1040, 664),
      anchor: Offset(768, 615),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          final compact = size.width < 760 || size.aspectRatio < 1.15;

          if (compact) {
            return _CompactOrganDiscovery(organs: _organs);
          }

          return _WideOrganDiscovery(canvasSize: _canvasSize, organs: _organs);
        },
      ),
    );
  }
}

@immutable
class OrganHotspot {
  const OrganHotspot({
    required this.title,
    required this.iconPath,
    required this.side,
    required this.circleCenter,
    required this.anchor,
  });

  final String title;
  final String iconPath;
  final CalloutSide side;
  final Offset circleCenter;
  final Offset anchor;
}

enum CalloutSide { left, right }

class _WideOrganDiscovery extends StatelessWidget {
  const _WideOrganDiscovery({required this.canvasSize, required this.organs});

  final Size canvasSize;
  final List<OrganHotspot> organs;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFE5A76A),
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox.fromSize(
            size: canvasSize,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const _AnatomyBackground(),
                const _BottomWash(),
                CustomPaint(
                  painter: _ConnectorPainter(organs: organs, iconRadius: 62),
                  size: canvasSize,
                ),
                const Positioned(left: 82, top: 55, child: _DiscoveryTitle()),
                const Positioned(
                  right: 40,
                  top: 22,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 180,
                    height: 70,
                  ),
                ),
                _OrganCallout(
                  organ: organs[0], // EYES & MOUTH
                  radius: 62,
                  labelGap: 24,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const EyesAndMouthPage(),
                    ),
                  ),
                ),
                _OrganCallout(
                  organ: organs[1], // LUNGS
                  radius: 62,
                  labelGap: 24,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const LungsPage(),
                      ),
                    );
                  },
                ),
                _OrganCallout(
                  organ: organs[2], // JOINTS
                  radius: 62,
                  labelGap: 24,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const JointsPage(),
                      ),
                    );
                  },
                ),
                _OrganCallout(
                  organ: organs[3], // BRAIN & NERVES
                  radius: 62,
                  labelGap: 24,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const BrainPage(),
                      ),
                    );
                  },
                ),
                _OrganCallout(
                  organ: organs[4], // SKIN
                  radius: 62,
                  labelGap: 24,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (_) => const SkinPage()),
                    );
                  },
                ),
                _OrganCallout(
                  organ: organs[5], // LYMPH NODES
                  radius: 62,
                  labelGap: 24,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const LymphNodesPage(),
                      ),
                    );
                  },
                ),
                _OrganCallout(
                  organ: organs[6], // KIDNEYS
                  radius: 62,
                  labelGap: 24,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const KidneysPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactOrganDiscovery extends StatelessWidget {
  const _CompactOrganDiscovery({required this.organs});

  final List<OrganHotspot> organs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const _AnatomyBackground(),
        const _BottomWash(stronger: true),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [NovartisLogo(compact: true)],
                ),
                const SizedBox(height: 22),
                const _DiscoveryTitle(compact: true),
                const SizedBox(height: 270),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    _CompactOrganButton(
                      organ: organs[0], // EYES & MOUTH
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const EyesAndMouthPage(),
                        ),
                      ),
                    ),
                    _CompactOrganButton(
                      organ: organs[1], // LUNGS
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const LungsPage(),
                        ),
                      ),
                    ),
                    _CompactOrganButton(
                      organ: organs[2], // JOINTS
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const JointsPage(),
                        ),
                      ),
                    ),
                    _CompactOrganButton(
                      organ: organs[3], // BRAIN & NERVES
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const BrainPage(),
                        ),
                      ),
                    ),
                    _CompactOrganButton(
                      organ: organs[4], // SKIN
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SkinPage(),
                        ),
                      ),
                    ),
                    _CompactOrganButton(
                      organ: organs[5], // LYMPH NODES
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const LymphNodesPage(),
                        ),
                      ),
                    ),
                    _CompactOrganButton(
                      organ: organs[6], // KIDNEYS
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const KidneysPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DiscoveryTitle extends StatelessWidget {
  const _DiscoveryTitle({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: compact ? 420 : 520),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOUCH AN ORGAN TO DISCOVER HOW',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'LeagueGothic',
              fontSize: compact ? 30 : 42,
              fontWeight: FontWeight.w700,
              height: 0.95,
              letterSpacing: 0,
            ),
          ),
          Text(
            'SJ\u00D6GREN\'S GOES BEYOND DRYNESS',
            style: TextStyle(
              color: const Color(0xFF26005D),
              fontFamily: 'LeagueGothic',
              fontSize: compact ? 43 : 56,
              fontWeight: FontWeight.w800,
              height: 1.5,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrganCallout extends StatelessWidget {
  const _OrganCallout({
    required this.organ,
    required this.radius,
    required this.labelGap,
    required this.onTap,
  });

  final OrganHotspot organ;
  final double radius;
  final double labelGap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labelWidth = organ.side == CalloutSide.left ? 128.0 : 230.0;
    final labelLeft = organ.side == CalloutSide.left
        ? organ.circleCenter.dx - radius - labelGap - labelWidth
        : organ.circleCenter.dx + radius + labelGap;
    final labelAlignment = organ.side == CalloutSide.left
        ? TextAlign.right
        : TextAlign.left;
    final connectorStart = organ.side == CalloutSide.left
        ? organ.circleCenter + const Offset(70, 0)
        : organ.circleCenter - const Offset(70, 0);
    final connectorEnd = organ.anchor;
    final hitboxSize = radius * 2 + 24;
    final hitboxLeft = organ.circleCenter.dx - hitboxSize / 2;
    final hitboxTop = organ.circleCenter.dy - hitboxSize / 2;

    return Stack(
      children: [
        Positioned(
          left: labelLeft,
          top: organ.circleCenter.dy - 20,
          width: labelWidth,
          child: _OrganLabel(text: organ.title, textAlign: labelAlignment),
        ),
        Positioned(
          left: organ.circleCenter.dx - radius,
          top: organ.circleCenter.dy - radius,
          child: _OrganCircleButton(
            organ: organ,
            size: radius * 2,
            onTap: onTap,
          ),
        ),
        Positioned(
          left: hitboxLeft,
          top: hitboxTop,
          width: hitboxSize,
          height: hitboxSize,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }
}

class _CompactOrganButton extends StatelessWidget {
  const _CompactOrganButton({required this.organ, required this.onTap});

  final OrganHotspot organ;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF2A0068).withValues(alpha: 0.78),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 154,
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _OrganCircleButton(
                organ: organ,
                size: 72,
                onTap: onTap,
                compact: true,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _OrganLabel(
                  text: organ.title,
                  textAlign: TextAlign.center,
                  compact: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrganCircleButton extends StatelessWidget {
  const _OrganCircleButton({
    required this.organ,
    required this.size,
    required this.onTap,
    this.compact = false,
  });

  final OrganHotspot organ;
  final double size;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Open ${organ.title}',
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFc0834b).withValues(alpha: 0.88),
                  blurRadius: compact ? 11 : 19,
                  spreadRadius: compact ? 0 : 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                organ.iconPath,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrganLabel extends StatelessWidget {
  const _OrganLabel({
    required this.text,
    required this.textAlign,
    this.compact = false,
  });

  final String text;
  final TextAlign textAlign;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: 2,
      style: TextStyle(
        color: compact ? Colors.white : const Color(0xFF26005D),
        fontFamily: 'LeagueGothic',
        fontSize: compact ? 28 : 35,
        fontWeight: FontWeight.w800,
        height: 1,
        letterSpacing: 0,
      ),
    );
  }
}

class _AnatomyBackground extends StatelessWidget {
  const _AnatomyBackground();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/background.png',
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }
}

class _BottomWash extends StatelessWidget {
  const _BottomWash({this.stronger = false});

  final bool stronger;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF2A0068).withValues(alpha: stronger ? 0.72 : 0.5),
          ],
          stops: const [0.7, 1],
        ),
      ),
    );
  }
}

class _ConnectorPainter extends CustomPainter {
  const _ConnectorPainter({required this.organs, required this.iconRadius});

  final List<OrganHotspot> organs;
  final double iconRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00FFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final organ in organs) {
      final circleEdge = organ.side == CalloutSide.left
          ? organ.circleCenter + Offset(iconRadius, 0)
          : organ.circleCenter - Offset(iconRadius, 0);
      final elbowX = organ.side == CalloutSide.left
          ? math.min(organ.anchor.dx - 18, organ.circleCenter.dx + 190)
          : math.max(organ.anchor.dx + 18, organ.circleCenter.dx - 190);
      final elbow = Offset(elbowX, circleEdge.dy);

      final path = Path()
        ..moveTo(circleEdge.dx, circleEdge.dy)
        ..lineTo(elbow.dx, elbow.dy)
        ..lineTo(organ.anchor.dx, organ.anchor.dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConnectorPainter oldDelegate) {
    return oldDelegate.organs != organs;
  }
}

