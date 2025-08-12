import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/loading_widget.dart';
import 'package:app/core/widgets/no_data_widget.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_anak_card.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_dashboard_app_bar.dart';
import 'package:app/features/user_posyandu/viewmodel/posyandu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PosyanduDashboardPage extends ConsumerWidget {
  const PosyanduDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posyanduViewModel = ref.watch(posyanduViewModelProvider);
    return Container(
      color: Palette.backgroundSecondaryColor,
      child: posyanduViewModel.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) =>
            throw Exception('Error loading data: $error, stackTrace: $stack'),
        data: (data) {
          return RefreshIndicator(
            edgeOffset: 200,
            onRefresh: () async {
              await ref.read(posyanduViewModelProvider.notifier).segarkan();
            },
            child: CustomScrollView(
              slivers: [
                const PosyanduDashboardAppBar(),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 24, bottom: 4),

                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'Pelayanan Hari Ini',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                data.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(height: 100),
                            NoDataWidget('Belum ada anak dilayani hari ini'),
                          ],
                        ),
                      )
                    : SliverList.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4,
                            ),
                            child: PosyanduAnakCard(pengukuran: data[index]),
                          );
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
