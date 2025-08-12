import 'package:app/core/model/anak_model.dart';
import 'package:app/core/model/pengukuran_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/features/user_posyandu/view/pages/posyandu_add_entry2_page.dart';
import 'package:app/features/user_posyandu/view/pages/posyandu_baby_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PosyanduAnakCard extends StatelessWidget {
  final PengukuranModel? pengukuran;
  final AnakModel? anak;
  final bool addEntry;
  const PosyanduAnakCard({
    super.key,
    this.pengukuran,
    this.anak,
    this.addEntry = false,
  });

  @override
  Widget build(BuildContext context) {
    final dataAnak = pengukuran != null ? pengukuran!.anak! : anak!;
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 6),
      child: Card(
        elevation: 4,
        color: dataAnak.jenisKelamin == JenisKelamin.lakiLaki
            ? Palette.maleColor
            : Palette.femaleColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(32)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => !addEntry
                    ? PosyanduBabyDetailPage(dataAnak)
                    : const PosyanduAddEntry2Page(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 4,
              top: 4,
              right: 16,
              bottom: 24,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      dataAnak.jenisKelamin == JenisKelamin.lakiLaki
                          ? 'assets/baby_male.svg'
                          : 'assets/baby_female.svg',
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
                              dataAnak.nama,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Palette.textPrimaryColor,
                              ),
                            ),
                            Text(
                              dataAnak.usiaInString,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Palette.textPrimaryColor,
                              ),
                            ),
                            if (pengukuran != null)
                              Text(
                                formatTanggalWaktu(
                                  pengukuran!.tanggalPengukuran,
                                ),
                                style: const TextStyle(
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
                                        const Text(
                                          'Orang Tua',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          dataAnak.orangTua?.nama ?? '-',
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
                                        const Text(
                                          'Alamat',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          dataAnak.orangTua?.alamat ?? '-',
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
                            height: 100,
                            width: 60,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Palette.healthyColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  height: 55,
                                  width: 60,
                                  padding: const EdgeInsets.all(14),
                                  child: SvgPicture.asset(
                                    'assets/baby_weight.svg',
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Berat\n',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Palette.textPrimaryColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: formatAngka(
                                              pengukuran?.beratBadan,
                                            ),
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.textPrimaryColor,
                                            ),
                                          ),
                                          const TextSpan(
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
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Palette.healthyBackgroundColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            height: 100,
                            width: 60,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Palette.healthyColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  height: 55,
                                  width: 60,
                                  padding: const EdgeInsets.all(14),
                                  child: SvgPicture.asset(
                                    'assets/baby_height.svg',
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Tinggi\n',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Palette.textPrimaryColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: formatAngka(
                                              pengukuran?.tinggiBadan,
                                            ),
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.textPrimaryColor,
                                            ),
                                          ),
                                          const TextSpan(
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
                  padding: const EdgeInsets.only(top: 8, left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Status Pertumbuhan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: pengukuran != null
                              ? switch (pengukuran!
                                    .statusPengukuranPertumbuhan) {
                                  StatusPengukuran.sehat =>
                                    Palette.healthyBackgroundColor,
                                  StatusPengukuran.kurangSehat =>
                                    Palette.lessHealthyBackgroundColor,
                                  StatusPengukuran.tidakSehat =>
                                    Palette.unhealthyBackgroundColor,
                                }
                              : Palette.backgroundPrimaryColor.withAlpha(191),
                        ),
                        child: Center(
                          child: Text(
                            pengukuran?.statusPertumbuhan ?? 'Belum Ada Data',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
