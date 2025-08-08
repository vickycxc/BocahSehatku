import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_baby_growth_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrtuBabyGrowthNoteCard extends StatelessWidget {
  final AnakModel anak;
  const OrtuBabyGrowthNoteCard(this.anak, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 4,
        color: anak.jenisKelamin == JenisKelamin.lakiLaki
            ? Palette.maleColor
            : Palette.femaleColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  anak.jenisKelamin == JenisKelamin.lakiLaki
                      ? 'assets/baby_male.svg'
                      : 'assets/baby_female.svg',
                  width: 100,
                  height: 100,
                ),
                const Expanded(
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
                    color:
                        anak.pengukuran != null && anak.pengukuran!.isNotEmpty
                        ? switch (anak.pengukuran!.first.kategoriBBU) {
                            KategoriBBU.sangatKurang =>
                              Palette.unhealthyBackgroundColor,
                            KategoriBBU.kurang =>
                              Palette.lessHealthyBackgroundColor,
                            KategoriBBU.normal =>
                              Palette.healthyBackgroundColor,
                            KategoriBBU.lebih =>
                              Palette.lessHealthyBackgroundColor,
                          }
                        : Palette.noDataBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 110,
                  width: 75,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:
                              anak.pengukuran != null &&
                                  anak.pengukuran!.isNotEmpty
                              ? switch (anak.pengukuran!.first.kategoriBBU) {
                                  KategoriBBU.sangatKurang =>
                                    Palette.unhealthyColor,
                                  KategoriBBU.kurang =>
                                    Palette.lessHealthyColor,
                                  KategoriBBU.normal => Palette.healthyColor,
                                  KategoriBBU.lebih => Palette.lessHealthyColor,
                                }
                              : Palette.noDataColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 60,
                        width: 75,
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset('assets/baby_weight.svg'),
                      ),
                      Expanded(
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'Berat\n',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Palette.textPrimaryColor,
                              ),
                              children: [
                                TextSpan(
                                  text: formatAngka(
                                    anak.pengukuran?.first.beratBadan,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.textPrimaryColor,
                                  ),
                                ),
                                const TextSpan(
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
                const SizedBox(width: 30),
                Container(
                  decoration: BoxDecoration(
                    color:
                        anak.pengukuran != null && anak.pengukuran!.isNotEmpty
                        ? switch (anak.pengukuran!.first.kategoriTBU) {
                            KategoriTBU.sangatPendek =>
                              Palette.unhealthyBackgroundColor,
                            KategoriTBU.pendek =>
                              Palette.lessHealthyBackgroundColor,
                            KategoriTBU.normal =>
                              Palette.healthyBackgroundColor,
                            KategoriTBU.tinggi =>
                              Palette.lessHealthyBackgroundColor,
                          }
                        : Palette.noDataBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 110,
                  width: 75,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:
                              anak.pengukuran != null &&
                                  anak.pengukuran!.isNotEmpty
                              ? switch (anak.pengukuran!.first.kategoriTBU) {
                                  KategoriTBU.sangatPendek =>
                                    Palette.unhealthyColor,
                                  KategoriTBU.pendek =>
                                    Palette.lessHealthyColor,
                                  KategoriTBU.normal => Palette.healthyColor,
                                  KategoriTBU.tinggi =>
                                    Palette.lessHealthyColor,
                                }
                              : Palette.noDataColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 60,
                        width: 75,
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset('assets/baby_height.svg'),
                      ),
                      Expanded(
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'Tinggi\n',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Palette.textPrimaryColor,
                              ),
                              children: [
                                TextSpan(
                                  text: formatAngka(
                                    anak.pengukuran?.first.tinggiBadan,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.textPrimaryColor,
                                  ),
                                ),
                                const TextSpan(
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
            const SizedBox(height: 16),
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
                              const Text(
                                'Kunjungan Terakhir',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start, // Teks rata kiri
                                overflow: TextOverflow
                                    .ellipsis, // Potong teks jika terlalu panjang
                                maxLines: 1, // Maksimal 1 baris
                              ),
                              Text(
                                anak.pengukuran != null &&
                                        anak.pengukuran!.isNotEmpty
                                    ? formatHari(
                                        anak
                                            .pengukuran!
                                            .first
                                            .tanggalPengukuran,
                                      )
                                    : '-',
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
                              const Text(
                                'Nama Posyandu',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                anak.pengukuran != null &&
                                        anak.pengukuran!.isNotEmpty
                                    ? anak.pengukuran!.first.namaPosyandu
                                    : '-',
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
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrtuBabyGrowthHistoryPage(anak),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.backgroundPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
