import 'package:flutter/material.dart';

enum AppFlowState { start, profileSetup1 }

class AppFlowController extends ChangeNotifier {
  AppFlowState _state = AppFlowState.start;

  AppFlowState get state => _state;

  void goToStart() {
    _state = AppFlowState.start;
    notifyListeners();
  }

  void goToProfileSetup1() {
    _state = AppFlowState.profileSetup1;
    notifyListeners();
  }
}
