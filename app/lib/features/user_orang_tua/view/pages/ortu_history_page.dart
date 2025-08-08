import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/loading_widget.dart';
import 'package:app/core/widgets/no_data_widget.dart';
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
      padding: const EdgeInsets.only(top: 150),
      color: Palette.backgroundSecondaryColor,
      child: ortuViewModel.when(
        data: (data) {
          final listRiwayatKunjungan = data.listRiwayatKunjungan;
          if (listRiwayatKunjungan.isEmpty) {
            return RefreshIndicator(
              edgeOffset: 50,
              onRefresh: () async =>
                  await ref.read(ortuViewModelProvider.notifier).segarkan(),
              child: ListView(
                children: [
                  const NoDataWidget('Belum ada riwayat kunjungan ke posyandu'),
                ],
              ),
            );
          }
          return RefreshIndicator(
            edgeOffset: 50,
            onRefresh: () async {
              await ref.read(ortuViewModelProvider.notifier).segarkan();
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 12,
                left: 24,
                right: 24,
                top: 180,
              ),
              itemCount: listRiwayatKunjungan.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Riwayat Kunjungan Ke Posyandu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return PosyanduHistoryCard(listRiwayatKunjungan[index - 1]);
              },
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stack) =>
            throw Exception('Error loading data: $error, stackTrace: $stack'),
      ),
    );
  }
}
