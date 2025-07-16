import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/widgets/auth_background.dart';
import 'package:app/features/auth/view/widgets/onboarding_messages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreenPage extends StatelessWidget {
  const OnboardingScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OnboardingMessages(),
          const SizedBox(height: 32),
          CustomButton(
            onPressed: () {
              context.push('/pick-role');
            },
            text: 'Masuk',
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(320, 55),
              side: BorderSide(color: Palette.accentColor, width: 2.0),
            ),
            onPressed: () {
              context.push('/register');
            },
            child: Text(
              'Daftar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
