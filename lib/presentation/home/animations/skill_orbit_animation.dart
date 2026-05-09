import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SkillOrbitAnimation extends StatefulWidget {
  const SkillOrbitAnimation({super.key});

  @override
  State<SkillOrbitAnimation> createState() => _SkillOrbitAnimationState();
}

class _SkillOrbitAnimationState extends State<SkillOrbitAnimation>
    with SingleTickerProviderStateMixin {

  late final Ticker _ticker;

  double _rotationAngle = 0.0;
  final double _rotationSpeed = 0.02;

  final double _baseSize = 10;  // x
  final double _maxSize = 100;   // 2x

  @override
  void initState() {
    super.initState();

    _ticker = createTicker((_) {
      setState(() {
        _rotationAngle += _rotationSpeed;
        if (_rotationAngle > 2 * pi) {
          _rotationAngle -= 2 * pi;
        }
      });
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double orbitRadius = 130;
    const double containerSize = orbitRadius * 2;

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [

          // Center rotating gear
          Transform.rotate(
            angle: _rotationAngle,
            child: const Icon(
              Icons.settings_outlined,
              size: 90,
              color: Color(0xFFfbd214),
            ),
          ),

          ..._buildFullOrbitIcons(orbitRadius),
        ],
      ),
    );
  }

  List<Widget> _buildFullOrbitIcons(double orbitRadius) {

    final skills = [
      Icons.flutter_dash,
      Icons.local_fire_department,
      Icons.storage,
      Icons.web,
      Icons.code,
      Icons.brush,
    ];

    final int count = skills.length;

    return List.generate(count, (index) {

      // Evenly distribute across full 360°
      double baseAngle = (2 * pi / count) * index;

      // Add rotation
      double currentAngle = baseAngle + _rotationAngle;

      double x = orbitRadius * cos(currentAngle);
      double y = orbitRadius * sin(currentAngle);

      // Convert to degrees (0–360)
      double degrees = (currentAngle * 180 / pi) % 360;
      if (degrees < 0) degrees += 360;

      // Target scaling center = 225°
      double midpoint = 135;

      double distance = (degrees - midpoint).abs();

      // Normalize across full circle
      double normalized = (distance / 180).clamp(0.0, 1.0);

      // Invert so midpoint = 1
      double scaleFactor = 1 - normalized;

      // Smooth curve
      scaleFactor = pow(scaleFactor, 2).toDouble();

      double iconSize =
          _baseSize + (_maxSize - _baseSize) * scaleFactor;

      return Transform.translate(
        offset: Offset(x, y),
        child: Container(
          width: iconSize,
          height: iconSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
              ),
            ],
          ),
          child: Icon(
            skills[index],
            size: iconSize * 0.5,
            color: Colors.red,
          ),
        ),
      );
    });
  }
}
