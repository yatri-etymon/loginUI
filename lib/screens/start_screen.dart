import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_blue/widgets/background_image.dart';
import 'package:login_blue/widgets/delayed_animation.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    /// Welcome Text
                    DelayedAnimation(
                      delay: 500,
                      child: Text(
                        'Welcome',
                        style: GoogleFonts.kaushanScript(
                          fontSize: 38,
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                
                    const SizedBox(height: 12),
                
                    /// Subtitle
                    DelayedAnimation(
                      delay: 650,
                      child: Text(
                        'Your journey starts here',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.85),
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
