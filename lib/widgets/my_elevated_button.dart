import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
    this.prefixIcon,
  });

  final String text;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: color,
      ),
      onPressed: onTap,
      child: Row(
        children: [
          if (prefixIcon != null) ...[prefixIcon!],

          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.italiana(
                letterSpacing: 2,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
