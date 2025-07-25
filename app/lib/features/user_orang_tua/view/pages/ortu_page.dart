import 'package:app/core/model/nav_model.dart';
import 'package:app/core/theme/palette.dart';
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
      appBar: OrtuAppBar(),
      body: Container(color: Palette.backgroundSecondaryColor),
      bottomNavigationBar: OrtuNavBar(
        pageIndex: _indexHalaman,
        navItems: _iconHalaman,
      ),
    );
  }
}
