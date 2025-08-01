import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/pages/pick_role_page.dart';
import 'package:app/features/auth/view/pages/register_page.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/features/auth/view/widgets/onboarding_messages.dart';
import 'package:flutter/material.dart';

class OnboardingScreenPage extends StatelessWidget {
  const OnboardingScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WaveBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OnboardingMessages(),
          const SizedBox(height: 32),
          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PickRolePage()),
              );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
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
