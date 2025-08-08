import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/baby_details_card.dart';
import 'package:app/core/widgets/baby_graph_card.dart';
import 'package:app/core/widgets/custom_app_bar.dart';
import 'package:app/features/user_orang_tua/view/widgets/ortu_baby_detail_app_bar.dart';
import 'package:app/features/user_orang_tua/view/widgets/ortu_baby_growth_note_card.dart';
import 'package:flutter/material.dart';

class OrtuBabyDetailPage extends StatelessWidget {
  final AnakModel anak;
  const OrtuBabyDetailPage(this.anak, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(content: OrtuBabyDetailAppBar(anak)),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Palette.backgroundSecondaryColor,
        child: ListView(
          padding: const EdgeInsets.only(top: 105, bottom: 16),
          children: [
            OrtuBabyGrowthNoteCard(anak),
            BabyGraphCard(anak),
            BabyDetailsCard(anak),
          ],
        ),
      ),
    );
  }
}
