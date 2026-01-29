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
    final width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: !isExpanded,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && isExpanded) {
          setState(() => isExpanded = false);
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            /// 1️⃣ BACKGROUND
            const BackgroundImage(),

            /// 2️⃣ BLUR BACKGROUND ONLY
            if (isExpanded)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),

            /// 3️⃣ DARK OVERLAY + TAP OUTSIDE CLOSE
            if (isExpanded)
              ModalBarrier(
                dismissible: true,
                color: Colors.black.withOpacity(0.35),
                onDismiss: () {
                  setState(() => isExpanded = false);
                  FocusScope.of(context).unfocus();
                },
              ),

            /// 4️⃣ MAIN CONTENT
            SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                behavior: HitTestBehavior.deferToChild,
                child: Column(
                  children: [
                    const Spacer(),

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
                    const SizedBox(height: 100),
                    const Spacer(),

                    /// 5️⃣ GLASS LOGIN CARD (TOPMOST)
                    DelayedAnimation(
                      delay: 900,
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (!isExpanded) {
                                setState(() => isExpanded = true);
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                isExpanded ? 28 : 40,
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 12,
                                  sigmaY: 12,
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  width: width * 0.85,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.18),
                                    borderRadius: BorderRadius.circular(
                                      isExpanded ? 28 : 40,
                                    ),
                                    border: Border.all(color: Colors.white24),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                            hintText: 'Email / Phone number',
                                            filled: true,
                                            fillColor: Colors.white70,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 16),

                                        Row(
                                          children: const [
                                            Expanded(
                                              child: Divider(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              child: Text(
                                                'OR',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Divider(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 16),

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
                                              imagePath:
                                                  'assets/icons/apple.png',
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

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
