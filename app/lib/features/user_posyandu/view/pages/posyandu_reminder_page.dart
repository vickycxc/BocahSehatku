import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_reminder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PosyanduReminderPage extends ConsumerWidget {
  const PosyanduReminderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Palette.backgroundSecondaryColor,
      child: ListView(
        padding: const EdgeInsets.only(
          bottom: 12,
          left: 12,
          right: 12,
          top: 110,
        ),
        children: [
          PosyanduReminderCard(
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
          PosyanduReminderCard(
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
          PosyanduReminderCard(
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
    );
  }
}
