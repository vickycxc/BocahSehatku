import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_anak_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PosyanduSearchPage extends StatefulWidget {
  const PosyanduSearchPage({super.key});

  @override
  State<PosyanduSearchPage> createState() => _PosyanduSearchPageState();
}

class _PosyanduSearchPageState extends State<PosyanduSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.backgroundSecondaryColor,
      child: ListView(
        padding: const EdgeInsets.only(
          bottom: 12,
          left: 12,
          right: 12,
          top: 100,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              height: 48,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 7,
                    child: SearchBar(
                      textStyle: WidgetStatePropertyAll(
                        TextStyle(
                          fontSize: 14,
                          color: Palette.textPrimaryColor,
                        ),
                      ),
                      hintText: 'Cari data anak...',
                      backgroundColor: WidgetStatePropertyAll(
                        Palette.backgroundPrimaryColor,
                      ),
                      leading: Icon(
                        LucideIcons.search,
                        color: Palette.textPrimaryColor,
                      ),
                      elevation: WidgetStatePropertyAll(2),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(2),
                        shadowColor: WidgetStatePropertyAll(
                          Palette.textPrimaryColor,
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          Palette.backgroundPrimaryColor,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.funnel,
                            color: Palette.textPrimaryColor,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Palette.textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          PosyanduAnakCard(
            AnakModel(
              id: 0,
              nama:
                  'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
              tanggalLahir: DateTime(2025, 2, 3),
              jenisKelamin: JenisKelamin.lakiLaki,
              nik: '20000',
              bbSekarang: 4.55,
              tbSekarang: 60.0,
              orangTuaId: 2,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
          PosyanduAnakCard(
            AnakModel(
              id: 0,
              nama:
                  'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
              tanggalLahir: DateTime(2025, 2, 3),
              jenisKelamin: JenisKelamin.lakiLaki,
              nik: '20000',
              bbSekarang: 4.55,
              tbSekarang: 60.0,
              orangTuaId: 2,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
          PosyanduAnakCard(
            AnakModel(
              id: 0,
              nama:
                  'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
              tanggalLahir: DateTime(2025, 2, 3),
              jenisKelamin: JenisKelamin.lakiLaki,
              nik: '20000',
              bbSekarang: 4.55,
              tbSekarang: 60.0,
              orangTuaId: 2,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
        ],
      ),
    );
  }
}
