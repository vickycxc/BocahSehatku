import 'package:app/core/model/nav_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/core/widgets/custom_app_bar.dart';
import 'package:app/features/auth/view/pages/onboarding_page.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:app/features/user_posyandu/view/pages/posyandu_calendar_page.dart';
import 'package:app/features/user_posyandu/view/pages/posyandu_dashboard_page.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_nav_bar.dart';
import 'package:app/features/user_posyandu/view/pages/posyandu_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PosyanduPage extends ConsumerStatefulWidget {
  const PosyanduPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrtuPageState();
}

class _OrtuPageState extends ConsumerState<PosyanduPage> {
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
        icon: LucideIcons.calendarClock,
        label: 'Kalender',
        onTap: () {
          setState(() {
            _indexHalaman = 1;
          });
        },
      ),
      NavModel(
        icon: LucideIcons.search,
        label: 'Cari',
        onTap: () {
          setState(() {
            _indexHalaman = 2;
          });
        },
      ),
      NavModel(
        icon: LucideIcons.bell,
        label: 'Pengingat',
        onTap: () {
          setState(() {
            _indexHalaman = 3;
          });
        },
      ),
      NavModel(
        icon: LucideIcons.chartLine,
        label: 'Statistik',
        onTap: () {
          setState(() {
            _indexHalaman = 4;
          });
        },
      ),
      NavModel(
        icon: LucideIcons.userRound,
        label: 'Profil',
        onTap: () {
          setState(() {
            _indexHalaman = 5;
          });
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: switch (_indexHalaman) {
        0 => null,
        1 => CustomAppBar(
          height: 0,
          content: SafeArea(
            child: Center(
              child: Text(
                'Tampilkan Menurut Tanggal',
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(
                  color: Palette.backgroundPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        _ => AppBar(
          toolbarHeight: 0,
          backgroundColor: Palette.backgroundPrimaryColor,
          elevation: 0,
        ),
      },
      extendBodyBehindAppBar: true,
      body: switch (_indexHalaman) {
        0 => PosyanduDashboardPage(),
        1 => PosyanduCalendarPage(),
        2 => Container(
          color: Palette.backgroundSecondaryColor,
          child: Center(
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
                    showSnackBar(context, 'Halo!', isFloating: true);
                  },
                  text: 'Show Snackbar',
                ),
                SizedBox(height: 25),
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
        ),
        5 => PosyanduProfilePage(),
        _ => Center(child: Text('Halaman tidak ditemukan')),
      },
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          backgroundColor: Palette.accentColor,
          onPressed: () {
            // Action for the floating action button
          },
          child: const Icon(
            LucideIcons.scanQrCode,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      bottomNavigationBar: PosyanduNavBar(
        pageIndex: _indexHalaman,
        navItems: _iconHalaman,
      ),
    );
  }
}
