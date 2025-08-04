import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BabyGrowthHistoryCard extends StatelessWidget {
  final bool withEdit;
  const BabyGrowthHistoryCard({super.key, this.withEdit = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 6),
      child: Card(
        color: Palette.maleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: !withEdit ? 24 : 0,
            bottom: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: !withEdit
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 8,
                        top: !withEdit ? 0 : 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/icons/calendar.png',
                                width: 36,
                                height: 36,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Waktu',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      textAlign:
                                          TextAlign.start, // Teks rata kiri
                                      overflow: TextOverflow
                                          .ellipsis, // Potong teks jika terlalu panjang
                                      maxLines: 1, // Maksimal 1 baris
                                    ),
                                    Text(
                                      'Senin, 3 Oktober 2025',
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/icons/posyandu.png',
                                width: 36,
                                height: 36,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Posyandu',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      'Posyandu Melati',
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines:
                                          2, // Maksimal 2 baris untuk teks panjang
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/icons/age.png',
                                width: 36,
                                height: 36,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Usia',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      '2 Bulan 2 Hari',
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines:
                                          2, // Maksimal 2 baris untuk teks panjang
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (withEdit)
                        SizedBox(
                          height: 56,
                          width: 56,
                          child: FittedBox(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(8),
                                backgroundColor: Palette.backgroundPrimaryColor,
                              ),
                              child: Icon(
                                LucideIcons.squarePen,
                                color: Palette.textPrimaryColor,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Palette.healthyBackgroundColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            height: !withEdit ? 120 : 100,
                            width: 60,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Palette.healthyColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  height: !withEdit ? 65 : 55,
                                  width: 60,
                                  padding: EdgeInsets.all(14),
                                  child: SvgPicture.asset(
                                    'assets/baby_weight.svg',
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Berat\n',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Palette.textPrimaryColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: formatAngka(23),
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.textPrimaryColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' kg',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Palette.textPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Palette.healthyBackgroundColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            height: !withEdit ? 120 : 100,
                            width: 60,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Palette.healthyColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  height: !withEdit ? 65 : 55,
                                  width: 60,
                                  padding: EdgeInsets.all(14),
                                  child: SvgPicture.asset(
                                    'assets/baby_height.svg',
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Tinggi\n',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Palette.textPrimaryColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: formatAngka(61),
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.textPrimaryColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' cm',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Palette.textPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Status Pertumbuhan',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                // width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Palette.healthyBackgroundColor,
                ),
                child: Center(
                  child: Text(
                    'Normal, Gizi Baik',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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
