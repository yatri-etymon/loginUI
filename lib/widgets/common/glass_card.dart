import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:login_blue/widgets/common/delayed_animation.dart';

class GlassCard extends StatelessWidget {
  final Widget child;

  //optional configs
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final bool enableTap;
  final VoidCallback? onTap;
  final double blur;
  final double opacity;
  final bool useDelay;
  final double? width;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(26)),
    this.enableTap = false,
    this.onTap,
    this.blur = 14,
    this.opacity = 0.12,
    this.useDelay = false,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: enableTap ? onTap : null,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              width: width ?? MediaQuery.of(context).size.width * 0.88,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                borderRadius: borderRadius,
                border: Border.all(color: Colors.white24),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );

    //optional delayed animation for login screen only
    if (useDelay) {
      return DelayedAnimation(delay: 900, child: card);
    }

    return card;
  }
}
