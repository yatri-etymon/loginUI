import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkipAction extends StatelessWidget {
  final VoidCallback onTap;

  const SkipAction({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        'Continue without signing in →',
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[200]),
      ),
    );
  }
}
