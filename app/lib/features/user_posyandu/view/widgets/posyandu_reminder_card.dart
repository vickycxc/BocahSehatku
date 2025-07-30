import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PosyanduReminderCard extends StatelessWidget {
  final AnakModel anak;
  const PosyanduReminderCard(this.anak, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 6),
      child: Card(
        elevation: 4,
        color: Palette.femaleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          onTap: () {
            // Navigate to detail page or perform an action
          },
          child: Padding(
            padding: EdgeInsets.only(left: 4, top: 4, right: 16, bottom: 24),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/baby_male.svg',
                      width: 80,
                      height: 80,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 24,
                          top: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              anak.nama,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Palette.textPrimaryColor,
                              ),
                            ),
                            Text(
                              anak.usiaInString,
                              style: TextStyle(
                                fontSize: 12,
                                color: Palette.textPrimaryColor,
                              ),
                            ),
                            Text(
                              '12/07/2025 09:30',
                              style: TextStyle(
                                fontSize: 12,
                                color: Palette.textPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 8),
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
                                    'assets/icons/parents.png',
                                    width: 36,
                                    height: 36,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Orang Tua',
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
                                          'Mujiati Winarno',
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
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
                                    'assets/icons/house.png',
                                    width: 36,
                                    height: 36,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alamat',
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
                                    'assets/icons/history.png',
                                    width: 36,
                                    height: 36,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Terakhir Ke Posyandu',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          '1 Bulan 7 Hari',
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(height: 16),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Palette.backgroundPrimaryColor,
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          minimumSize: WidgetStatePropertyAll(
                            Size(double.infinity, 56),
                          ),
                        ),

                        onPressed: () {},
                        child: Container(
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              'Hubungi Orang Tua',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Palette.textPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
