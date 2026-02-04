import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleLoginSection extends StatelessWidget {
  final VoidCallback? onTap;

  const GoogleLoginSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Image.asset('assets/icons/google.png', height: 22),
            const SizedBox(width: 12),
            Text(
              'Continue with Google',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
