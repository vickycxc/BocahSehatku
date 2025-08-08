import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/baby_growth_history_card.dart';
import 'package:app/core/widgets/custom_app_bar.dart';
import 'package:app/core/widgets/custom_back_button.dart';
import 'package:app/core/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';

class OrtuBabyGrowthHistoryPage extends StatelessWidget {
  final AnakModel anak;
  const OrtuBabyGrowthHistoryPage(this.anak, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        content: Row(
          children: [
            const CustomBackButton(),
            Expanded(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
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
                        anak.nama,
                        maxLines: 1,
                        style: const TextStyle(
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
        color: Palette.backgroundSecondaryColor,
        child: anak.pengukuran != null && anak.pengukuran!.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(
                  top: 110,
                  bottom: 16,
                  left: 12,
                  right: 12,
                ),
                itemCount: anak.pengukuran!.length,
                itemBuilder: (context, index) {
                  return BabyGrowthHistoryCard(
                    anak.pengukuran![index],
                    anak.jenisKelamin,
                  );
                },
              )
            : const Center(
                child: NoDataWidget('Belum Ada Riwayat Pertumbuhan'),
              ),
      ),
    );
  }
}
