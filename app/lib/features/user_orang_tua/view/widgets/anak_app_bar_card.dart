// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_baby_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnakAppBarCard extends StatelessWidget {
  final AnakModel anak;
  const AnakAppBarCard(this.anak, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.backgroundPrimaryColor,
          borderRadius: BorderRadius.circular(24),
        ),
        width: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrtuBabyDetailPage(anak),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: 8),
                    SvgPicture.asset(
                      anak.jenisKelamin == JenisKelamin.lakiLaki
                          ? 'assets/baby_male.svg'
                          : 'assets/baby_female.svg',
                      width: 42,
                      height: 42,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      anak.nama,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Palette.textPrimaryColor,
                      ),
                    ),
                    Text(
                      anak.usiaInString,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Palette.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
