import 'package:app/core/model/anak_model.dart';
import 'package:app/core/providers/pengguna_aktif_notifier.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class BabyDetailsCard extends ConsumerWidget {
  final AnakModel anak;
  const BabyDetailsCard(this.anak, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(penggunaAktifNotifierProvider);
    bool isOrangTua;
    switch (currentUser!.data) {
      case Left():
        isOrangTua = true;
      case Right():
        isOrangTua = false;
    }
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 8),
      child: Card(
        color: anak.jenisKelamin == JenisKelamin.lakiLaki
            ? Palette.maleColor
            : Palette.femaleColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: 24,
          ),
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
              const SizedBox(height: 16),
              const Text(
                'Status Pertumbuhan:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                height: 72,
                decoration: BoxDecoration(
                  color: anak.pengukuran != null && anak.pengukuran!.isNotEmpty
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
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    anak.pengukuran != null && anak.pengukuran!.isNotEmpty
                        ? anak.pengukuran!.first.statusPertumbuhan
                        : 'Belum Ada Data',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Penilaian Tren Pertumbuhan Anak:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                height: 72,
                decoration: BoxDecoration(
                  color: anak.pengukuran != null && anak.pengukuran!.isNotEmpty
                      ? switch (anak.pengukuran!.first.statusPengukuranTren!) {
                          StatusPengukuran.sehat =>
                            Palette.healthyBackgroundColor,
                          StatusPengukuran.kurangSehat =>
                            Palette.lessHealthyBackgroundColor,
                          StatusPengukuran.tidakSehat =>
                            Palette.unhealthyBackgroundColor,
                        }
                      : Palette.backgroundPrimaryColor.withAlpha(191),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    anak.pengukuran != null && anak.pengukuran!.isNotEmpty
                        ? anak.pengukuran!.first.penilaianTren!
                        : 'Belum Ada Tren',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Rekomendasi:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                      anak.pengukuran != null && anak.pengukuran!.isNotEmpty
                          ? isOrangTua
                                ? anak.pengukuran!.first.rekomendasiOrtu!
                                : anak.pengukuran!.first.rekomendasiKader!
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
            ],
          ),
        ),
      ),
    );
  }
}
