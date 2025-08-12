import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_baby_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrtuAnakCard extends StatelessWidget {
  final AnakModel anak;
  const OrtuAnakCard(this.anak, {super.key});

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
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(32)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrtuBabyDetailPage(anak)),
            );
          },
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            anak.nama,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Palette.textPrimaryColor,
                            ),
                          ),
                          Text(
                            anak.usiaInString,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Palette.textPrimaryColor,
                            ),
                          ),
                        ],
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
                          ? switch (anak.pengukuran!.first.kategoriBBU!) {
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
                                ? switch (anak.pengukuran!.first.kategoriBBU!) {
                                    KategoriBBU.sangatKurang =>
                                      Palette.unhealthyColor,
                                    KategoriBBU.kurang =>
                                      Palette.lessHealthyColor,
                                    KategoriBBU.normal => Palette.healthyColor,
                                    KategoriBBU.lebih =>
                                      Palette.lessHealthyColor,
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
                          ? switch (anak.pengukuran!.first.kategoriTBU!) {
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
                                ? switch (anak.pengukuran!.first.kategoriTBU!) {
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
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status Pertumbuhan',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      // width: double.infinity,
                      height: 72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color:
                            anak.pengukuran != null &&
                                anak.pengukuran!.isNotEmpty
                            ? switch (anak
                                  .pengukuran!
                                  .first
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
                          anak.pengukuran != null && anak.pengukuran!.isNotEmpty
                              ? anak.pengukuran!.first.statusPertumbuhan
                              : 'Belum Ada Data',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Rekomendasi',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
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
                        padding: const EdgeInsetsGeometry.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Center(
                          child: Text(
                            anak.pengukuran != null &&
                                    anak.pengukuran!.isNotEmpty
                                ? anak.pengukuran!.first.rekomendasiOrtu!
                                : 'Belum Ada Data',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Palette.textPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    // Expanded(child: Container(color: Colors.blue)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
