import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
  });
  final String text;
  final Function()? onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: color,
      ),

      onPressed: onTap,
      child: Text(
        text,
        style: GoogleFonts.italiana(
          letterSpacing: 2,
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: textColor,
        ),
      ),
    );
  }
}
