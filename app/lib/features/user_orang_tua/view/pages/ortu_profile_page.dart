import 'package:app/core/widgets/profile_button.dart';
import 'package:app/core/widgets/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OrtuProfilePage extends StatelessWidget {
  const OrtuProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePage(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileButton(
              onPressed: () {},
              icon: LucideIcons.userRoundPen,
              text: 'Edit Profil',
            ),
            SizedBox(height: 24),
            ProfileButton(
              onPressed: () {},
              icon: LucideIcons.baby,
              text: 'Edit Profil Anak',
            ),
            SizedBox(height: 24),
            ProfileButton(
              onPressed: () {},
              icon: LucideIcons.info,
              text: 'Tentang Aplikasi',
            ),
            SizedBox(height: 24),
            ProfileButton(
              onPressed: () {},
              icon: LucideIcons.logOut,
              text: 'Keluar',
            ),
            SizedBox(height: 72),
          ],
        ),
      ),
    );
  }
}
