import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_baby_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrtuAnakCard extends StatelessWidget {
  final AnakModel anak;
  const OrtuAnakCard(this.anak, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 4,
        color: Palette.maleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrtuBabyDetailPage(anak)),
            );
          },
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/baby_male.svg',
                    width: 100,
                    height: 100,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            anak.nama,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Palette.textPrimaryColor,
                            ),
                          ),
                          Text(
                            anak.usiaInString,
                            style: TextStyle(
                              fontSize: 16,
                              color: Palette.textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.healthyBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 110,
                    width: 75,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Palette.healthyColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 60,
                          width: 75,
                          padding: EdgeInsets.all(14),
                          child: SvgPicture.asset('assets/baby_weight.svg'),
                        ),
                        Expanded(
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                text: 'Berat\n',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Palette.textPrimaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: formatAngka(42),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.textPrimaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' kg',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Palette.textPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.healthyBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 110,
                    width: 75,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Palette.healthyColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 60,
                          width: 75,
                          padding: EdgeInsets.all(14),
                          child: SvgPicture.asset('assets/baby_height.svg'),
                        ),
                        Expanded(
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                text: 'Tinggi\n',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Palette.textPrimaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: formatAngka(42),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.textPrimaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' cm',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Palette.textPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status Pertumbuhan',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      // width: double.infinity,
                      height: 72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Palette.healthyBackgroundColor,
                      ),
                      child: Center(
                        child: Text(
                          'Normal, Gizi Baik',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Rekomendasi',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Palette.backgroundPrimaryColor.withAlpha(191),
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Center(
                          child: Text(
                            'Hebat sekali, Bunda! Terus tingkatkan pengetahuan seputar gizi dan stimulasi anak sesuai usianya. Jangan ragu untuk bertanya kepada kader Posyandu atau tenaga kesehatan jika ada yang ingin didiskusikan. Peran aktif Bunda sangat penting untuk masa depan si kecil!',
                            style: TextStyle(
                              fontSize: 13,
                              color: Palette.textPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    // Expanded(child: Container(color: Colors.blue)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
