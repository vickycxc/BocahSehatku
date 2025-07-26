import 'package:app/core/providers/pengguna_aktif_notifier.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/pages/onboarding_page.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrtuDashboard2Page extends ConsumerWidget {
  const OrtuDashboard2Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(penggunaAktifNotifierProvider);
    print('user: ${user?.data}');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Halo Nona Nona. Saat Air mataku mengalir, Aku tak bisa menggunakan tissue, Aku butuh 4 Lembar, 4 Lembar, 4 Lembar, Saat aku menangis :\'(',
            ),
            CustomButton(
              onPressed: () {
                ref.read(authViewModelProvider.notifier).keluar();
                showSnackBar(context, 'Berhasil Keluar!');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingPage(),
                  ),
                  (_) => false,
                );
              },
              text: 'Keluar',
            ),
          ],
        ),
      ),
    );
  }
}
