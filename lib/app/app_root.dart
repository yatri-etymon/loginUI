import 'package:flutter/material.dart';
import 'package:login_blue/app/app_flow_controller.dart';
import 'package:login_blue/screens/profile_screen.dart';
import 'package:login_blue/screens/start_screen.dart';
import 'package:login_blue/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => AppFlowController()),
      ],
      child: Consumer2<ThemeController, AppFlowController>(
        builder: (context, theme, flow, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: theme.primaryColor),
              useMaterial3: true,
            ),
            home: _buildHome(flow),
          );
        },
      ),
    );
  }

  Widget _buildHome(AppFlowController flow) {
    switch (flow.state) {
      case AppFlowState.profile:
        return const ProfileScreen();
      case AppFlowState.start:
        return const StartScreen();
    }
  }
}
