import 'package:app/core/size_config.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/core/routes.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  final userModel = await container
      .read(authViewModelProvider.notifier)
      .ambilDataPengguna();
  print(userModel);
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bocah Sehatku',
      theme: AppTheme.theme,
      routerConfig: authRouter,
    );
  }
}
