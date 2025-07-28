import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';

class BabyDetailsCard extends StatelessWidget {
  const BabyDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 8),
      child: Card(
        color: Palette.maleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Info Penting Untuk Bunda',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Status Pertumbuhan:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Container(
                height: 72,
                decoration: BoxDecoration(
                  color: Palette.healthyBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Normal, Gizi Baik',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Penilaian Tren Pertumbuhan Anak:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Container(
                height: 72,
                decoration: BoxDecoration(
                  color: Palette.backgroundPrimaryColor.withAlpha(191),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Belum Ada Tren',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Rekomendasi:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Palette.backgroundPrimaryColor.withAlpha(191),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Center(
                    child: Text(
                      'Hebat sekali, Bunda! Terus tingkatkan pengetahuan seputar gizi dan stimulasi anak sesuai usianya. Jangan ragu untuk bertanya kepada kader Posyandu atau tenaga kesehatan jika ada yang ingin didiskusikan. Peran aktif Bunda sangat penting untuk masa depan si kecil!',
                      style: TextStyle(
                        fontSize: 13,
                        color: Palette.textPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
