import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

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
  bool showOtp = false;
  bool otpSent = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  void _closeLogin() {
    setState(() {
      isExpanded = false;
      showOtp = false;
      otpSent = false;
      emailController.clear();
      otpController.clear();
    });
    FocusScope.of(context).unfocus();
  }

  void _sendOtp() {
    setState(() {
      showOtp = true;
      otpSent = true;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      otpFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return PopScope(
      canPop: !isExpanded,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && isExpanded) {
          _closeLogin();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // BACKGROUND
            const BackgroundImage(),

            // BLUR BACKGROUND
            if (isExpanded)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),

            // DARK OVERLAY + OUTSIDE TAP
            if (isExpanded)
              ModalBarrier(dismissible: true, onDismiss: _closeLogin),

            // MAIN CONTENT
            SafeArea(
              child: GestureDetector(
                behavior: HitTestBehavior.deferToChild,
                onTap: () => FocusScope.of(context).unfocus(),
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
                    const SizedBox(height: 95),
                    const Spacer(),

                    // GLASS LOGIN CARD (keyboard-aware)
                    DelayedAnimation(
                      delay: 900,
                      child: AnimatedPadding(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        padding: EdgeInsets.only(
                          bottom: keyboardInset > 0 ? keyboardInset * 0.6 : 0,
                        ),
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
                                      color: Colors.white.withValues(
                                        alpha: 0.18,
                                      ),
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

                                          /// EMAIL / PHONE
                                          TextField(
                                            controller: emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onChanged: (_) => setState(() {}),
                                            onTap: () {
                                              if (!showOtp) {
                                                setState(() => showOtp = true);
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Email / Phone number',
                                              filled: true,
                                              fillColor: Colors.white70,
                                              suffixIcon:
                                                  emailController.text
                                                      .trim()
                                                      .isNotEmpty
                                                  ? TextButton(
                                                      onPressed: otpSent
                                                          ? null
                                                          : _sendOtp,
                                                      child: Text(
                                                        otpSent
                                                            ? 'Sent'
                                                            : 'Send OTP',
                                                        style:
                                                            GoogleFonts.poppins(),
                                                      ),
                                                    )
                                                  : null,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 16),

                                          /// SOCIAL ↔ OTP SWITCH
                                          AnimatedSize(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            curve: Curves.easeInOut,
                                            child: AnimatedSwitcher(
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              transitionBuilder:
                                                  (child, animation) {
                                                    return FadeTransition(
                                                      opacity: animation,
                                                      child: SlideTransition(
                                                        position: Tween<Offset>(
                                                          begin: const Offset(
                                                            0,
                                                            0.15,
                                                          ),
                                                          end: Offset.zero,
                                                        ).animate(animation),
                                                        child: child,
                                                      ),
                                                    );
                                                  },
                                              child: showOtp
                                                  ? _OtpSection(
                                                      key: const ValueKey(
                                                        'otp',
                                                      ),
                                                      controller: otpController,
                                                      focusNode: otpFocusNode,
                                                      enabled: otpSent,
                                                    )
                                                  : const _SocialLoginSection(
                                                      key: ValueKey('social'),
                                                    ),
                                            ),
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

//SOCIAL LOGIN

class _SocialLoginSection extends StatelessWidget {
  const _SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Divider(color: Colors.white)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('OR', style: TextStyle(color: Colors.white)),
            ),
            Expanded(child: Divider(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SquareTile(imagePath: 'assets/icons/google.png', onTap: () {}),
            const SizedBox(width: 16),
            SquareTile(imagePath: 'assets/icons/apple.png', onTap: () {}),
          ],
        ),
      ],
    );
  }
}

//OTP SECTION

class _OtpSection extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;

  const _OtpSection({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Enter the 6-digit OTP',
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
        ),
        const SizedBox(height: 14),
        Pinput(
          length: 6,
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          keyboardType: TextInputType.number,
          defaultPinTheme: PinTheme(
            width: 46,
            height: 52,
            textStyle: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onCompleted: (otp) {},
        ),
      ],
    );
  }
}
