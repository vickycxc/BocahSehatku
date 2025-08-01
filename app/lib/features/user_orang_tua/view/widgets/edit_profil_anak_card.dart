import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditProfilAnakCard extends StatelessWidget {
  const EditProfilAnakCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        elevation: 4,
        color: Palette.maleColor,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SvgPicture.asset('assets/baby_male.svg', height: 75, width: 75),
                Expanded(
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Melon Usk Kurniati Wijaya Kusumawati',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '2 Bulan 10 Hari',
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
