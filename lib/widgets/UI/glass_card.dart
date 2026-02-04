import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:login_blue/widgets/common/delayed_animation.dart';

class GlassCard extends StatelessWidget {
  final double width;
  final bool isExpanded;
  final VoidCallback? onTap;
  final Widget child;

  const GlassCard({
    super.key,
    required this.width,
    required this.isExpanded,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 900,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isExpanded ? 28 : 40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: width * 0.85,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(isExpanded ? 28 : 40),
                  border: Border.all(color: Colors.white24),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
