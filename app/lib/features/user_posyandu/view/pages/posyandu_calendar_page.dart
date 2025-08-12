import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_anak_card.dart';
import 'package:flutter/material.dart';

class PosyanduCalendarPage extends StatelessWidget {
  const PosyanduCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.backgroundSecondaryColor,
      child: ListView(
        padding: const EdgeInsets.only(
          bottom: 12,
          left: 12,
          right: 12,
          top: 100,
        ),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Card(
              color: Palette.backgroundPrimaryColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: SizedBox(height: 350),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Center(
              child: Text(
                '4 Juli',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          PosyanduAnakCard(
            anak: AnakModel(
              localId: 0,
              serverId: 1,
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
            anak: AnakModel(
              localId: 0,
              serverId: 2,
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
            anak: AnakModel(
              localId: 0,
              serverId: 2,
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
