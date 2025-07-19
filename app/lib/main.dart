import 'package:app/core/providers/current_user_notifier.dart';
import 'package:app/core/size_config.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/core/routes.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).ambilDataPengguna();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bocah Sehatku',
      theme: AppTheme.theme,
      routerConfig: switch (currentUser) {
        Left() => userOrangTuaRouter,
        _ => authRouter,
      },
    );
  }
}
