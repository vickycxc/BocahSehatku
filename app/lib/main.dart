import 'package:app/core/theme/theme.dart';
import 'package:app/features/auth/view/pages/onboarding_screen_page.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bocah Sehatku',
      theme: AppTheme.theme,
      routerConfig: authRouter,
    );
  }
}
