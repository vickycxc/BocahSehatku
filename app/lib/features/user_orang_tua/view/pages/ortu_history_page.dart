import 'package:app/core/theme/palette.dart';
import 'package:app/features/user_orang_tua/view/widgets/posyandu_history_card.dart';
import 'package:flutter/material.dart';

class OrtuHistoryPage extends StatelessWidget {
  const OrtuHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.backgroundSecondaryColor,
      child: ListView(
        padding: const EdgeInsets.only(
          bottom: 12,
          left: 24,
          right: 24,
          top: 230,
        ),
        children: [
          // Placeholder for history items
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              'Riwayat Kunjungan Ke Posyandu',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          PosyanduHistoryCard(),
          PosyanduHistoryCard(),
          PosyanduHistoryCard(),
        ],
      ),
    );
  }
}
