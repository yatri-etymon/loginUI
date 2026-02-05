import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_blue/app/app_flow_controller.dart';
import 'package:login_blue/widgets/ui/google_continue_field.dart';
import 'package:login_blue/widgets/ui/skip_action.dart';
import 'package:provider/provider.dart';

import '../widgets/ui/gradient_background.dart';
import '../widgets/ui/welcome_header.dart';
import '../widgets/common/glass_card.dart';
import '../widgets/ui/otp_section.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isExpanded = false;
  bool showOtp = false;
  bool otpSent = false;

  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();

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
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardOpen = keyboardHeight > 0;

    return PopScope(
      canPop: !isExpanded,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && isExpanded) _closeLogin();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            const GradientBackground(),

            if (isExpanded) ...[
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.black.withValues(alpha: 0.3)),
              ),
              ModalBarrier(dismissible: true, onDismiss: _closeLogin),
            ],

            const WelcomeHeader(),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              left: 0,
              right: 0,
              bottom: isKeyboardOpen ? keyboardHeight + 20 : 60,
              child: Center(
                child: GlassCard(
                  width: MediaQuery.of(context).size.width * 0.90,
                  useDelay: true,
                  enableTap: true,
                  onTap: () {
                    if (!isExpanded) setState(() => isExpanded = true);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isExpanded)
                        Text(
                          'Get Started',
                          style: GoogleFonts.firaSans(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      else
                        Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),

                      if (isExpanded) ...[
                        const SizedBox(height: 22),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (_) => setState(() {}),
                          onTap: () {
                            if (!showOtp) setState(() => showOtp = true);
                          },
                          style: const TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Image.asset(
                                'assets/icons/otp.png',
                                height: 27,
                                width: 27,
                                color: Colors.lightBlue.shade700,
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            hintText: 'Email / Phone number',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey.shade600,
                              fontSize: 14,
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

                        const SizedBox(height: 10),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 250),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: showOtp
                                ? OtpSection(
                                    controller: otpController,
                                    focusNode: otpFocusNode,
                                    enabled: otpSent,
                                    onCompleted: (otp) {
                                      context
                                          .read<AppFlowController>()
                                          .goToProfile();
                                    },
                                  )
                                : Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Divider(
                                              indent: 7,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              'OR',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: Divider(
                                              endIndent: 7,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      GoogleLoginSection(onTap: () {}),
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SkipAction(
                          onTap: () =>
                              context.read<AppFlowController>().goToProfile(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
