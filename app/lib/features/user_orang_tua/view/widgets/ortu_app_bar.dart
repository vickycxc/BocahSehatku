import 'package:app/core/providers/pengguna_aktif_notifier.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/features/user_orang_tua/view/widgets/anak_app_bar_card.dart';
import 'package:app/features/user_orang_tua/view/widgets/tambah_profil_anak_card.dart';
import 'package:app/features/user_orang_tua/view/widgets/tambah_profil_anak_card2.dart';
import 'package:app/features/user_orang_tua/viewmodel/ortu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OrtuAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const OrtuAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(penggunaAktifNotifierProvider)!;
    final ortuViewModel = ref.watch(ortuViewModelProvider);
    final isLoading = ref.watch(
      ortuViewModelProvider.select((val) => val.isLoading == true),
    );
    String nama;
    switch (userModel.data) {
      case Left(value: final l):
        if (l.nama != null) {
          nama = l.nama!;
        } else {
          throw Exception('Nama pengguna tidak ditemukan');
        }
      case Right():
        throw Exception('Nama pengguna tidak ditemukan');
    }
    final List<String> subNama = nama.split(' ');
    final String namaDuaKata = subNama.length > 1
        ? '${subNama[0]} ${subNama[1]}'
        : subNama[0];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        color: Palette.accentColor,
      ),

      height: isLoading ? kToolbarHeight + 30 : double.infinity,
      child: Stack(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Halo, $namaDuaKata',
                style: TextStyle(
                  color: Palette.backgroundPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            centerTitle: false,
            actions: [
              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    LucideIcons.refreshCwOff600,
                    color: Palette.backgroundPrimaryColor,
                    size: 24,
                  ),
                ),
              ),
            ],
            actionsPadding: EdgeInsets.only(right: 24),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                child: ortuViewModel.when(
                  data: (data) {
                    final listAnak = data.listAnak;
                    if (listAnak.isEmpty) {
                      return TambahProfilAnakCard2();
                    }
                    return ListView.builder(
                      itemCount: data.listAnak.length + 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          index != data.listAnak.length
                          ? AnakAppBarCard(data.listAnak[index])
                          : TambahProfilAnakCard(),
                    );
                  },
                  error: (error, stackTrace) => throw Exception(
                    'Error loading data: $error, stackTrace: $stackTrace',
                  ),
                  loading: () => const SizedBox(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 120);
}
