import 'package:app/core/theme/palette.dart';
import 'package:app/features/user_orang_tua/view/widgets/posyandu_history_card.dart';
import 'package:app/features/user_orang_tua/viewmodel/ortu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrtuHistoryPage extends ConsumerWidget {
  const OrtuHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ortuViewModel = ref.watch(ortuViewModelProvider);
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
