import 'package:app/core/theme/palette.dart';
import 'package:app/features/user_orang_tua/view/pages/add_profil_anak_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TambahProfilAnakCard2 extends StatelessWidget {
  const TambahProfilAnakCard2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Palette.backgroundPrimaryColor,
        borderRadius: BorderRadius.circular(24),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: [
          SvgPicture.asset('assets/baby_no_bg.svg', width: 80, height: 80),
          const SizedBox(width: 8),
          const Expanded(
            flex: 3,
            child: Text(
              'Tambah Profil\nAnak Baru',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Palette.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProfilAnakPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Palette.accentColor,
              ),
              child: const Icon(
                LucideIcons.plus,
                size: 24,
                color: Palette.backgroundPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
