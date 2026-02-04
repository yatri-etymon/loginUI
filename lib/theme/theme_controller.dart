import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  Color _primaryColor = Colors.blueAccent;

  Color get primaryColor => _primaryColor;

  void setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}