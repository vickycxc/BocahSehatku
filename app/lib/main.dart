import 'package:app/core/providers/pengguna_aktif_notifier.dart';
import 'package:app/core/size_config.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/features/auth/view/pages/onboarding_page.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:app/features/auth/view/pages/complete_profile_page.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_page.dart';
import 'package:app/features/user_posyandu/view/pages/posyandu_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).ambilDataPengguna();
  FlutterNativeSplash.remove();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final currentUser = ref.watch(penggunaAktifNotifierProvider);
    print('currentUser: $currentUser');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bocah Sehatku',
      theme: AppTheme.theme,
      home: currentUser != null
          ? switch (currentUser.data) {
              Left(value: final l) =>
                (l.nama != null &&
                        l.nik != null &&
                        l.jenisKelamin != null &&
                        l.alamat != null &&
                        l.posyanduId != null)
                    ? const OrtuPage()
                    : const CompleteProfilePage(),
              Right() => const PosyanduDashboardPage(),
            }
          : const OnboardingPage(),
    );
  }
}
