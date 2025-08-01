import 'package:app/core/theme/palette.dart';
import 'package:app/features/user_orang_tua/view/pages/add_profil_anak_page.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TambahProfilAnakCard extends StatelessWidget {
  const TambahProfilAnakCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.backgroundPrimaryColor,
          borderRadius: BorderRadius.circular(24),
        ),
        width: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddProfilAnakPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Palette.accentColor,
                ),
                child: Icon(
                  LucideIcons.plus,
                  size: 24,
                  color: Palette.backgroundPrimaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tambah Profil Anak Baru',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Palette.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
