import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/features/user_orang_tua/model/riwayat_kunjungan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PosyanduHistoryCard extends StatelessWidget {
  final RiwayatKunjunganModel riwayatKunjungan;
  const PosyanduHistoryCard(this.riwayatKunjungan, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 4),
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: Palette.accentColor, width: 3),
        ),
        color: Palette.backgroundPrimaryColor,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/posyandu_logo.svg',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        riwayatKunjungan.namaPosyandu,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatHari(riwayatKunjungan.tanggalKunjungan),
                        style: const TextStyle(fontSize: 12),
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
