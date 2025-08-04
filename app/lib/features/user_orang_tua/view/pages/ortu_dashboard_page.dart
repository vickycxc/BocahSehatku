import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/features/user_orang_tua/view/widgets/ortu_anak_card.dart';
import 'package:flutter/material.dart';

class OrtuDashboardPage extends StatelessWidget {
  const OrtuDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.backgroundSecondaryColor,
      child: RefreshIndicator(
        edgeOffset: 200,
        backgroundColor: Palette.backgroundPrimaryColor,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          padding: const EdgeInsets.only(
            bottom: 12,
            left: 12,
            right: 12,
            top: 210,
          ),
          children: [
            OrtuAnakCard(
              AnakModel(
                localId: 0,
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
            OrtuAnakCard(
              AnakModel(
                localId: 0,
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
            OrtuAnakCard(
              AnakModel(
                localId: 0,
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
      ),
    );
  }
}
