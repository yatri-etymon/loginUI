import 'package:flutter/material.dart';

enum AppFlowState { start, profile }

class AppFlowController extends ChangeNotifier {
  AppFlowState _state = AppFlowState.start;

  AppFlowState get state => _state;

  void goToStart() {
    _state = AppFlowState.start;
    notifyListeners();
  }

  void goToProfile() {
    _state = AppFlowState.profile;
    notifyListeners();
  }
}
