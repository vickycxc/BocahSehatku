import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class VerifikasiAkunCard extends StatelessWidget {
  const VerifikasiAkunCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.backgroundPrimaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            spacing: 24,
            children: [
              Row(
                spacing: 8,
                children: [
                  Column(
                    children: [
                      Text(
                        'Nama\nAlamat\nNIK\nNo. HP Lama\nNo. HP Baru',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ': Mujiati Winarno Kusumananda SUkmananda',
                          style: TextStyle(fontSize: 12),
                          maxLines: 1,
                        ),
                        Text(
                          ': Budi Santoso',
                          style: TextStyle(fontSize: 12),
                          maxLines: 1,
                        ),
                        Text(
                          ': Budi Santoso',
                          style: TextStyle(fontSize: 12),
                          maxLines: 1,
                        ),
                        Text(
                          ': Budi Santoso',
                          style: TextStyle(fontSize: 12),
                          maxLines: 1,
                        ),
                        Text(
                          ': Budi Santoso',
                          style: TextStyle(fontSize: 12),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 24,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Palette.unhealthyColor,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      minimumSize: WidgetStatePropertyAll(Size(130, 48)),
                    ),

                    onPressed: () {},
                    child: Container(
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        spacing: 4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.circleX,
                            color: Palette.textPrimaryColor,
                            size: 24,
                          ),
                          Text(
                            'Tolak',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Palette.textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Palette.healthyColor,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      minimumSize: WidgetStatePropertyAll(Size(130, 48)),
                    ),

                    onPressed: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        spacing: 4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.circleCheck,
                            color: Palette.textPrimaryColor,
                            size: 24,
                          ),
                          Text(
                            'Verifikasi',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Palette.textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
