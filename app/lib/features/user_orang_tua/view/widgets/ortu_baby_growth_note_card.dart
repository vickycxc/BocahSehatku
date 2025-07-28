import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_baby_growth_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrtuBabyGrowthNoteCard extends StatelessWidget {
  final AnakModel anak;
  const OrtuBabyGrowthNoteCard(this.anak, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 4,
        color: Palette.maleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/baby_male.svg',
                  width: 100,
                  height: 100,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 24),
                    child: Text(
                      'Catatan Pertumbuhan\nSi Kecil',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Palette.textPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Palette.healthyBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 110,
                  width: 75,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.healthyColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 60,
                        width: 75,
                        padding: EdgeInsets.all(14),
                        child: SvgPicture.asset('assets/baby_weight.svg'),
                      ),
                      Expanded(
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'Berat\n',
                              style: TextStyle(
                                fontSize: 13,
                                color: Palette.textPrimaryColor,
                              ),
                              children: [
                                TextSpan(
                                  text: formatAngka(anak.bbSekarang),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.textPrimaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: ' kg',
                                  style: TextStyle(
                                    fontSize: 13,
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
                SizedBox(width: 30),
                Container(
                  decoration: BoxDecoration(
                    color: Palette.healthyBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 110,
                  width: 75,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.healthyColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 60,
                        width: 75,
                        padding: EdgeInsets.all(14),
                        child: SvgPicture.asset('assets/baby_height.svg'),
                      ),
                      Expanded(
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'Tinggi\n',
                              style: TextStyle(
                                fontSize: 13,
                                color: Palette.textPrimaryColor,
                              ),
                              children: [
                                TextSpan(
                                  text: formatAngka(anak.tbSekarang),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.textPrimaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: ' cm',
                                  style: TextStyle(
                                    fontSize: 13,
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
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: Center(
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
                                'Kunjungan Terakhir',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start, // Teks rata kiri
                                overflow: TextOverflow
                                    .ellipsis, // Potong teks jika terlalu panjang
                                maxLines: 1, // Maksimal 1 baris
                              ),
                              Text(
                                'Senin, 3 Oktober 2025',
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
                                'Nama Posyandu',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                'Posyandu Melati',
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
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrtuBabyGrowthHistoryPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.backgroundPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  'Lihat Riwayat Pertumbuhan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Palette.textPrimaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
