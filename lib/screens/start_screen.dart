import 'package:flutter/material.dart';
import 'package:login_demo/widgeta/background_image.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [BackgroundImage(), Scaffold(backgroundColor: Colors.transparent,)]);
  }
}
