import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;

  const NameField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.name,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey.shade600,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
