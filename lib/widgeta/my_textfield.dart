import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Theme.of(context).colorScheme.,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.shade900),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.shade700),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}