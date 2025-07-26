import 'package:app/core/model/anak_model.dart';
import 'package:app/core/utils.dart';
import 'package:app/features/user_orang_tua/view/widgets/anak_card.dart';
import 'package:flutter/material.dart';

class OrtuDashboardPage extends StatelessWidget {
  const OrtuDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      children: [
        AnakCard(
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
        AnakCard(
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
        AnakCard(
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
    );
  }
}
