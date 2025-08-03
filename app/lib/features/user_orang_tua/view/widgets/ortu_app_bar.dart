import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/features/user_orang_tua/view/widgets/anak_app_bar_card.dart';
import 'package:app/features/user_orang_tua/view/widgets/tambah_profil_anak_card.dart';
import 'package:flutter/material.dart';

class OrtuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String nama = 'Mujiati Winarno Kusumandari';
  const OrtuAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  scrollDirection: Axis.horizontal,
                  children: [
                    AnakAppBarCard(
                      AnakModel(
                        localId: 0,
                        nama:
                            'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
                        tanggalLahir: DateTime(2025, 2, 3),
                        jenisKelamin: JenisKelamin.lakiLaki,
                        nik: '20000',
                        orangTuaId: 2,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        listPengukuran: [],
                      ),
                    ),
                    AnakAppBarCard(
                      AnakModel(
                        localId: 0,
                        nama:
                            'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
                        tanggalLahir: DateTime(2025, 2, 3),
                        jenisKelamin: JenisKelamin.lakiLaki,
                        nik: '20000',
                        orangTuaId: 2,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        listPengukuran: [],
                      ),
                    ),
                    TambahProfilAnakCard(),
                  ],
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
