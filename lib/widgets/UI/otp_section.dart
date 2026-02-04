import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpSection extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final ValueChanged<String> onCompleted;

  const OtpSection({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.enabled,
    required this.onCompleted, 
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
          onCompleted: onCompleted,
        ),
      ],
    );
  }
}
