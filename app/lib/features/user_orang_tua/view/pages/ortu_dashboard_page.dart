import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/loading_widget.dart';
import 'package:app/core/widgets/no_data_widget.dart';
import 'package:app/features/user_orang_tua/view/widgets/ortu_anak_card.dart';
import 'package:app/features/user_orang_tua/viewmodel/ortu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrtuDashboardPage extends ConsumerWidget {
  const OrtuDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ortuViewModel = ref.watch(ortuViewModelProvider);
    return Container(
      padding: const EdgeInsets.only(top: 150),
      color: Palette.backgroundSecondaryColor,
      child: ortuViewModel.when(
        data: (data) {
          final listAnak = data.listAnak;
          if (listAnak.isEmpty) {
            return RefreshIndicator(
              edgeOffset: 50,
              onRefresh: () async =>
                  await ref.read(ortuViewModelProvider.notifier).segarkan(),
              child: ListView(
                children: [
                  const NoDataWidget('Belum ada data anak yang ditambahkan'),
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
                left: 12,
                right: 12,
                top: 60,
              ),
              itemCount: listAnak.length,
              itemBuilder: (context, index) {
                final anak = listAnak[index];
                return OrtuAnakCard(anak);
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
