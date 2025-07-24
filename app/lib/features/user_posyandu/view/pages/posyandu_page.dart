import 'package:app/core/model/nav_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_nav_bar.dart';
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
      body: Container(color: Palette.backgroundSecondaryColor),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
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
