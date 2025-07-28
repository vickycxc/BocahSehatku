import 'package:app/core/model/nav_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_history_page.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_dashboard_page.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_profile_page.dart';
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
      extendBodyBehindAppBar: true,
      appBar: _indexHalaman != 2
          ? OrtuAppBar()
          : AppBar(
              toolbarHeight: 0,
              backgroundColor: Palette.backgroundPrimaryColor,
              elevation: 0,
            ),
      body: switch (_indexHalaman) {
        0 => OrtuDashboardPage(),
        1 => OrtuHistoryPage(),
        2 => OrtuProfilePage(),
        _ => Center(child: Text('Halaman tidak ditemukan')),
      },
      bottomNavigationBar: OrtuNavBar(
        pageIndex: _indexHalaman,
        navItems: _iconHalaman,
      ),
    );
  }
}
