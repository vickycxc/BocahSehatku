import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/custom_app_bar.dart';
import 'package:app/core/widgets/custom_back_button.dart';
import 'package:app/features/user_posyandu/view/widgets/verifikasi_akun_card.dart';
import 'package:flutter/material.dart';

class PosyanduVerifikasiAkunPage extends StatelessWidget {
  const PosyanduVerifikasiAkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Palette.backgroundPrimaryColor,
        content: Row(
          children: [
            CustomBackButton(isElevated: false),
            Expanded(
              child: SafeArea(
                child: Text(
                  'Verifikasi Akun',
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: TextStyle(
                    color: Palette.textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Palette.secondaryColor,
      body: ListView(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 120),
        children: [VerifikasiAkunCard()],
      ),
    );
  }
}
