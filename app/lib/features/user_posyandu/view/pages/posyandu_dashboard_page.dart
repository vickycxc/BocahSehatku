import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/features/user_orang_tua/view/widgets/ortu_anak_card.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_anak_card.dart';
import 'package:flutter/material.dart';

class PosyanduDashboardPage extends StatelessWidget {
  const PosyanduDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.backgroundSecondaryColor,
      child: ListView(
        padding: const EdgeInsets.only(
          bottom: 12,
          left: 12,
          right: 12,
          top: 220,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Center(
              child: Text(
                'Pelayanan Hari Ini',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          PosyanduAnakCard(
            AnakModel(
              id: 0,
              nama:
                  'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
              tanggalLahir: DateTime(2025, 2, 3),
              jenisKelamin: JenisKelamin.lakiLaki,
              nik: '20000',
              bbSekarang: 4.55,
              tbSekarang: 60.0,
              orangTuaId: 2,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
          PosyanduAnakCard(
            AnakModel(
              id: 0,
              nama:
                  'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
              tanggalLahir: DateTime(2025, 2, 3),
              jenisKelamin: JenisKelamin.lakiLaki,
              nik: '20000',
              orangTuaId: 2,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
          PosyanduAnakCard(
            AnakModel(
              id: 0,
              nama:
                  'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
              tanggalLahir: DateTime(2025, 2, 3),
              jenisKelamin: JenisKelamin.lakiLaki,
              nik: '20000',
              orangTuaId: 2,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
        ],
      ),
    );
  }
}
