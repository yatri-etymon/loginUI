import 'package:flutter/material.dart';

class RadialBloomPainter extends CustomPainter {
  final Offset center;
  final Color color;
  final double progress;

  RadialBloomPainter({
    required this.center,
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final minRadius = size.shortestSide * 0.25;
    final maxRadius = size.longestSide * 1.2;
    final radius = minRadius + (maxRadius - minRadius) * progress;

    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment(
          (center.dx / size.width) * 2 - 1,
          (center.dy / size.height) * 2 - 1,
        ),
        radius: 1.0,
        colors: [
          color.withValues(alpha: 0.25),
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.08),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant RadialBloomPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.center != center ||
        oldDelegate.color != color;
  }
}
