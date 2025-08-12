import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class EnigmaVoiceApp extends StatelessWidget {
  const EnigmaVoiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.createRouter();
    return MaterialApp.router(
      title: 'Enigma Voice',
      themeMode: ThemeMode.dark,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}