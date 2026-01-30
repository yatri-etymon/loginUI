import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_blue/widgets/background_image.dart';
import 'package:login_blue/widgets/delayed_animation.dart';
import 'package:login_blue/widgets/square_tile.dart';
import 'package:pinput/pinput.dart';

// Assuming these are your local imports
// import 'package:login_blue/widgets/background_image.dart';
// import 'package:login_blue/widgets/delayed_animation.dart';
// import 'package:login_blue/widgets/square_tile.dart';

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
    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardOpen = keyboardHeight > 0;

    return PopScope(
      canPop: !isExpanded,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && isExpanded) {
          _closeLogin();
        }
      },
      child: Scaffold(
        // the background layers when the keyboard pops up.
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // 1. BACKGROUND LAYER
            const BackgroundImage(),

            // 2. BLUR & OVERLAY
            if (isExpanded) ...[
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.black.withValues(alpha: 0.3)),
              ),
              ModalBarrier(dismissible: true, onDismiss: _closeLogin),
            ],

            // 3. STATIC CONTENT (Welcome Text)
            SafeArea(
              child: SizedBox(
                width: double.infinity,
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
            ),
            // Instead of a Column, we position this relative to the bottom.
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              left: 0,
              right: 0,
              // If keyboard is open, move card above it. Otherwise, park it near bottom.
              bottom: isKeyboardOpen ? keyboardHeight + 20 : 60,
              child: Center(child: _buildGlassCard(size.width)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard(double screenWidth) {
    return DelayedAnimation(
      delay: 900,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            if (!isExpanded) setState(() => isExpanded = true);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isExpanded ? 28 : 40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: screenWidth * 0.85,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(isExpanded ? 28 : 40),
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        onChanged: (_) => setState(() {}),
                        onTap: () {
                          if (!showOtp) setState(() => showOtp = true);
                        },
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: 'Email / Phone number',
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey.shade600,
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          suffixIcon: emailController.text.trim().isNotEmpty
                              ? TextButton(
                                  onPressed: otpSent ? null : _sendOtp,
                                  child: Text(
                                    otpSent ? 'Sent' : 'Send OTP',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: otpSent
                                          ? Colors.grey.shade600
                                          : Colors.lightBlue.shade600,
                                    ),
                                  ),
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: showOtp
                              ? _OtpSection(
                                  key: const ValueKey('otp'),
                                  controller: otpController,
                                  focusNode: otpFocusNode,
                                  enabled: otpSent,
                                )
                              : _SocialLoginSection(
                                  key: const ValueKey('social'),
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
    );
  }
}

class _SocialLoginSection extends StatelessWidget {
  const _SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Divider(indent: 5, color: Colors.white)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'OR',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Expanded(child: Divider(endIndent: 5, color: Colors.white)),
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
            width: 42,
            height: 48,
            textStyle: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onCompleted: (otp) {},
        ),
      ],
    );
  }
}
