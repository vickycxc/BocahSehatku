import 'package:app/core/providers/current_user_notifier.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrtuDashboardPage extends ConsumerWidget {
  const OrtuDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserNotifierProvider);
    print(user);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Halo nona nona'),
            CustomButton(
              onPressed: () {
                ref.read(authViewModelProvider.notifier).keluar();
                showSnackBar(context, 'Berhasil Keluar!');
              },
              text: 'Keluar',
            ),
          ],
        ),
      ),
    );
  }
}
