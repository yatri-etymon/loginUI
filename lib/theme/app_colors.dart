import 'package:flutter/material.dart';

class AppColors {

  /// Each gradient has an ID (for saving per user later)
  static const Map<String, List<Color>> gradients = {

    /// Default app gradient (current)
    "defaultBlue": [
      Color(0xFF7FA6F3),
      Color(0xFF6FA4DA),
      Color(0xFF4FB8B8),
    ],

    /// Mint calm
    "mint": [
      Color(0xFF5ED0A1),
      Color(0xFF51BCA3),
      Color(0xFF3C9FA0),
    ],

    /// Sunset soft
    "sunset": [
      Color(0xFFFF9A9E),
      Color(0xFFFBC2EB),
      Color(0xFFA18CD1),
    ],

    /// Purple night
    "purpleNight": [
      Color(0xFF667EEA),
      Color(0xFF764BA2),
      Color(0xFF6B73FF),
    ],

    /// Deep ocean
    "deepOcean": [
      Color(0xFF0F2027),
      Color(0xFF203A43),
      Color(0xFF2C5364),
    ],

    /// Peach calm
    "peach": [
      Color(0xFFFFC3A0),
      Color(0xFFFFAFBD),
      Color(0xFFFF9A9E),
    ],
  };

  /// Default gradient id
  static const String defaultId = "defaultBlue";
}
