import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PosyanduHistoryCard extends StatelessWidget {
  const PosyanduHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 4),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: Palette.accentColor, width: 3),
        ),
        color: Palette.backgroundPrimaryColor,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          onTap: () {},
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/posyandu_logo.svg',
                  width: 60,
                  height: 60,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Posyandu Melati',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rabu, 20 Juni 2025',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // child: ListTile(
        //   contentPadding: EdgeInsets.all(16),
        //   leading: SvgPicture.asset(
        //     'assets/posyandu_logo.svg',
        //     width: 60,
        //     height: 60,
        //   ),
        //   onTap: () {},
        //   title: Text(
        //     'Posyandu Melati Janatira Kusmananda',
        //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //   ),
        //   subtitle: Text('Rabu, 20 Juni 2025'),
        // ),
      ),
    );
  }
}
