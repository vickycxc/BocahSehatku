import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/baby_growth_history_card.dart';
import 'package:app/core/widgets/custom_app_bar.dart';
import 'package:app/core/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';

class PosyanduBabyGrowthHistoryPage extends StatelessWidget {
  const PosyanduBabyGrowthHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        content: Row(
          children: [
            CustomBackButton(),
            Expanded(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Riwayat Pertumbuhan',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: TextStyle(
                          color: Palette.backgroundPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Melon Usk Kurniati Wijayati Kusumananda Aradana',
                        maxLines: 1,
                        style: TextStyle(
                          color: Palette.backgroundPrimaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Palette.backgroundSecondaryColor,
        child: ListView(
          padding: const EdgeInsets.only(top: 110, bottom: 16),
          children: [
            // BabyGrowthHistoryCard(withEdit: true),
            // BabyGrowthHistoryCard(withEdit: true),
            // BabyGrowthHistoryCard(),
          ],
        ),
      ),
    );
  }
}
