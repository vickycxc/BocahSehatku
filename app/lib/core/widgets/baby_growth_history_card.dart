import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BabyGrowthHistoryCard extends StatelessWidget {
  const BabyGrowthHistoryCard({super.key});

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
          padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
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
                                  textAlign: TextAlign.start, // Teks rata kiri
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.healthyBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 120,
                    width: 60,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Palette.healthyColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 65,
                          width: 60,
                          padding: EdgeInsets.all(14),
                          child: SvgPicture.asset('assets/baby_weight.svg'),
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
                    height: 120,
                    width: 60,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Palette.healthyColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 65,
                          width: 60,
                          padding: EdgeInsets.all(14),
                          child: SvgPicture.asset('assets/baby_height.svg'),
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
        ),
      ),
    );
  }
}
