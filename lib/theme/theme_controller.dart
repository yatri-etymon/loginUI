import 'package:flutter/material.dart';
import 'app_colors.dart';

class ThemeController extends ChangeNotifier {
  /// store selected gradient ID
  String _selectedThemeId = AppColors.defaultId;

  /// get gradient colors
  List<Color> get gradient => AppColors.gradients[_selectedThemeId]!;

  /// primary color for Material theme
  Color get primaryColor => gradient.first;

  /// change theme
  void setTheme(String themeId) {
    _selectedThemeId = themeId;
    notifyListeners();
  }

  /// current id getter (useful later for saving user)
  String get currentThemeId => _selectedThemeId;
}
