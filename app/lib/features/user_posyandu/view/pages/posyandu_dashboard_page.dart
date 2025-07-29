import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_anak_card.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_dashboard_app_bar.dart';
import 'package:flutter/material.dart';

class PosyanduDashboardPage extends StatelessWidget {
  const PosyanduDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.backgroundSecondaryColor,
      child: CustomScrollView(
        slivers: [
          PosyanduDashboardAppBar(),
          SliverPadding(
            padding: const EdgeInsets.only(top: 24, bottom: 4),

            sliver: SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'Pelayanan Hari Ini',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4,
                ),
                child: PosyanduAnakCard(
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
              );
            },
          ),
        ],
      ),
    );
  }
}
