import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/core/widgets/profile_button.dart';
import 'package:app/core/widgets/profile_page.dart';
import 'package:app/features/auth/view/pages/onboarding_page.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:app/features/user_posyandu/view/pages/posyandu_verifikasi_akun_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PosyanduProfilePage extends ConsumerWidget {
  const PosyanduProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProfilePage(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PosyanduVerifikasiAkunPage(),
                  ),
                );
              },
              icon: LucideIcons.shieldCheck,
              text: 'Verifikasi Akun',
            ),
            const SizedBox(height: 24),
            ProfileButton(
              onPressed: () {},
              icon: LucideIcons.keyRound,
              text: 'Ganti Kata Sandi',
            ),
            const SizedBox(height: 24),
            ProfileButton(
              onPressed: () {},
              icon: LucideIcons.info,
              text: 'Tentang Aplikasi',
            ),
            const SizedBox(height: 24),
            ProfileButton(
              onPressed: () {
                ref.read(authViewModelProvider.notifier).keluar();
                showSnackBar(context, 'Berhasil Keluar!');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingPage(),
                  ),
                  (_) => false,
                );
              },
              icon: LucideIcons.logOut,
              text: 'Keluar',
            ),
            const SizedBox(height: 42),
            const Text(
              '© 2025 - Zulfikar Satria Allam Syahputra',
              style: TextStyle(
                fontSize: 14,
                color: Palette.backgroundPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
