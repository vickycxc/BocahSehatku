import 'package:app/core/model/nav_model.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/pages/onboarding_page.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_dashboard_page.dart';
import 'package:app/features/user_orang_tua/view/widgets/ortu_app_bar.dart';
import 'package:app/features/user_orang_tua/view/widgets/ortu_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OrtuPage extends ConsumerStatefulWidget {
  const OrtuPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrtuPageState();
}

class _OrtuPageState extends ConsumerState<OrtuPage> {
  int _indexHalaman = 0;

  late final List<NavModel> _iconHalaman;

  @override
  void initState() {
    super.initState();
    _iconHalaman = [
      NavModel(
        icon: LucideIcons.house,
        label: 'Beranda',
        onTap: () {
          setState(() {
            _indexHalaman = 0;
          });
        },
      ),
      NavModel(
        icon: LucideIcons.clock,
        label: 'Riwayat',
        onTap: () {
          setState(() {
            _indexHalaman = 1;
          });
        },
      ),
      NavModel(
        icon: LucideIcons.userRound,
        label: 'Profil',
        onTap: () {
          setState(() {
            _indexHalaman = 2;
          });
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _indexHalaman != 2 ? OrtuAppBar() : null,
      body: switch (_indexHalaman) {
        0 => OrtuDashboardPage(),
        1 => Center(child: Text('Riwayat')),
        2 => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: Text(
                  'Halo Nona Nona\nSaat Air mataku mengalir,\nAku tak bisa menggunakan tissue,\nAku butuh 4 Lembar,\n4 Lembar,\n4 Lembar,\nSaat aku menangis :\'(',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
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
        _ => Center(child: Text('Halaman tidak ditemukan')),
      },
      bottomNavigationBar: OrtuNavBar(
        pageIndex: _indexHalaman,
        navItems: _iconHalaman,
      ),
    );
  }
}
