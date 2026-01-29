import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_blue/widgets/background_image.dart';
import 'package:login_blue/widgets/delayed_animation.dart';
import 'package:login_blue/widgets/square_tile.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),

        /// MAIN CONTENT
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),

                  /// Welcome Text
                  DelayedAnimation(
                    delay: 550,
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

                  DelayedAnimation(
                    delay: 750,
                    child: Text(
                      'Your journey starts here',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  const Spacer(),

                  // ANIMATED BOTTOM SHEET
                  DelayedAnimation(
                    delay: 900,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => isExpanded = !isExpanded);
                        },
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 350),
                          scale: isExpanded ? 1.0 : 0.96,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              isExpanded ? 28 : 40,
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 450),
                                curve: Curves.easeInOut,
                                width: MediaQuery.of(context).size.width * 0.85,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(
                                    isExpanded ? 28 : 40,
                                  ),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /// LOGIN TITLE
                                    Text(
                                      'Login',
                                      style: GoogleFonts.kaushanScript(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),

                                    if (isExpanded) ...[
                                      const SizedBox(height: 18),

                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Email/Phone number',
                                          hintStyle: GoogleFonts.poppins(
                                            color: Colors.grey.shade600,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white70,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 14),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              indent: 5,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0,
                                            ),
                                            child: Text(
                                              'OR',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              endIndent: 5,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 14),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SquareTile(
                                            imagePath:
                                                'assets/icons/google.png',
                                            onTap: () {},
                                          ),
                                          const SizedBox(width: 16),
                                          SquareTile(
                                            imagePath: 'assets/icons/apple.png',
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
