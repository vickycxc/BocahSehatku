import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/core/widgets/profile_button.dart';
import 'package:app/core/widgets/profile_page.dart';
import 'package:app/features/auth/view/pages/edit_profile_page.dart';
import 'package:app/features/auth/view/pages/onboarding_page.dart';
import 'package:app/features/user_orang_tua/view/pages/edit_profil_anak_page.dart';
import 'package:app/features/user_orang_tua/viewmodel/ortu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OrtuProfilePage extends ConsumerWidget {
  const OrtuProfilePage({super.key});

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
                    builder: (context) => const EditProfilePage(),
                  ),
                );
              },
              icon: LucideIcons.userRoundPen,
              text: 'Edit Profil',
            ),
            const SizedBox(height: 24),
            ProfileButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilAnakPage(),
                  ),
                );
              },
              icon: LucideIcons.baby,
              text: 'Edit Profil Anak',
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
                // ref.read(authViewModelProvider.notifier).keluar();
                showSnackBar(context, 'Berhasil Keluar!');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingPage(),
                  ),
                  (_) => false,
                );
                ref.invalidate(ortuViewModelProvider);
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
