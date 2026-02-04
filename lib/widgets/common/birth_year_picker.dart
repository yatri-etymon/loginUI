import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BirthYearPicker extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? hintTeaxt;

  const BirthYearPicker({
    super.key,
    required this.controller,
    required this.onTap,
    this.hintTeaxt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            hintText: hintTeaxt,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.white70,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black54,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
