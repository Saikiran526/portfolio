import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/asset_paths.dart';

class SkillOrbitAnimation extends StatefulWidget {
  const SkillOrbitAnimation({super.key});

  @override
  State<SkillOrbitAnimation> createState() => _SkillOrbitAnimationState();
}

class _SkillOrbitAnimationState extends State<SkillOrbitAnimation>
    with SingleTickerProviderStateMixin {
  // Constants
  static const Duration _cycleDuration = Duration(seconds: 12);
  static const Color _primaryColor = Color(0xFFfbd214);
  static const Color _gearColor = Color(0xFFfbd214);
  static const Color _iconColor = Color(0xFFc9a400);
  static const double _targetAngleDeg = 135.0; // angle where icons are largest

  static const List<String> _skillIcons = [
    AssetPaths.dartIconImage,
    AssetPaths.flutterIconImage,
    AssetPaths.firebaseIconImage,
    AssetPaths.sqfLiteIconImage,
    AssetPaths.reactIconImage,
    AssetPaths.gitHubIconImage,
  ];

  // ── State ──────────────────────────────────────────────────────────────────
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _cycleDuration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Fit inside whatever space is available; cap to a sensible max.
        final double available = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 300.0;
        final double containerSize = available.clamp(160.0, 300.0);
        final double orbitRadius = containerSize * 0.44;
        final double gearSize = containerSize * 0.30;
        final double minIconSize = containerSize * 0.04;
        final double maxIconSize = containerSize * 0.34;

        return SizedBox(
          width: containerSize,
          height: containerSize,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              final double angle = _controller.value * 2 * pi;
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Subtle orbit ring
                  _OrbitRing(radius: orbitRadius),

                  // Central rotating gear
                  Transform.rotate(
                    angle: angle,
                    child: Icon(
                      Icons.settings_outlined,
                      size: gearSize,
                      color: _gearColor,
                    ),
                  ),

                  // Orbiting skill icons
                  ..._buildOrbitIcons(
                    orbitRadius: orbitRadius,
                    rotationAngle: angle,
                    minSize: minIconSize,
                    maxSize: maxIconSize,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  List<Widget> _buildOrbitIcons({
    required double orbitRadius,
    required double rotationAngle,
    required double minSize,
    required double maxSize,
  }) {
    final int count = _skillIcons.length;
    final double step = (2 * pi) / count;

    return List.generate(count, (i) {
      final double baseAngle = step * i;
      final double currentAngle = baseAngle + rotationAngle;

      final double x = orbitRadius * cos(currentAngle);
      final double y = orbitRadius * sin(currentAngle);

      final double scaleFactor = _computeScaleFactor(currentAngle);
      final double iconSize = minSize + (maxSize - minSize) * scaleFactor;

      return Transform.translate(
        offset: Offset(x, y),
        child: _OrbitIcon(
          skill: _skillIcons[i],
          size: iconSize,
          iconColor: _iconColor,
          primaryColor: _primaryColor,
        ),
      );
    });
  }

  /// Returns a value in [0, 1] based on how close [angle] is to
  /// [_targetAngleDeg]. Uses a squared curve for a smooth "pop".
  double _computeScaleFactor(double angle) {
    double degrees = (angle * 180 / pi) % 360;
    if (degrees < 0) degrees += 360;

    double distance = (degrees - _targetAngleDeg).abs();
    // Wrap-around distance (e.g. 350° → 10° = 20°, not 340°)
    if (distance > 180) distance = 360 - distance;

    final double normalised = (distance / 180).clamp(0.0, 1.0);
    final double scale = 1 - normalised;
    return (scale * scale); // squared → smooth
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _OrbitRing extends StatelessWidget {
  const _OrbitRing({required this.radius});
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.06),
            width: 1.2,
          ),
        ),
      ),
    );
  }
}

class _OrbitIcon extends StatelessWidget {
  const _OrbitIcon({
    required this.skill,
    required this.size,
    required this.iconColor,
    required this.primaryColor,
  });

  final String skill;
  final double size;
  final Color iconColor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.25),
              blurRadius: 12,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Image.asset(skill),
          ),
        ),
      ),
    );
  }
}