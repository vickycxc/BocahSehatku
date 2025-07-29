import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/custom_app_bar.dart';
import 'package:app/core/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrtuQrPage extends StatelessWidget {
  const OrtuQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        content: Row(
          children: [
            CustomBackButton(),
            Expanded(
              child: SafeArea(
                child: Text(
                  'Kode QR',
                  style: TextStyle(
                    color: Palette.backgroundPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Palette.backgroundSecondaryColor,
        padding: const EdgeInsets.only(right: 16, left: 16, top: 50),
        child: Center(
          child: Card(
            elevation: 4,
            color: Palette.maleColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 24,
                left: 24,
                top: 12,
                bottom: 32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/baby_male.svg',
                    width: 100,
                    height: 100,
                  ),

                  SizedBox(height: 12),
                  Text(
                    'Melon Usk Kurniati Wijayati',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Palette.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    height: 240,
                    width: 240,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Palette.backgroundPrimaryColor,
                    ),
                    child: QrImageView(data: '352513002211203'),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Tunjukkan Kode QR ini kepada kader posyandu untuk melakukan penimbangan berat badan dan pengukuran tinggi badan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
