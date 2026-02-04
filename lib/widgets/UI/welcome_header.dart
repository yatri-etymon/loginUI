import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_blue/widgets/common/delayed_animation.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 110),
            DelayedAnimation(
              delay: 500,
              child: Text(
                'Welcome',
                style: GoogleFonts.kaushanScript(
                  fontSize: 38,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            DelayedAnimation(
              delay: 700,
              child: Text(
                'Your journey starts here',
                style: GoogleFonts.poppins(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}