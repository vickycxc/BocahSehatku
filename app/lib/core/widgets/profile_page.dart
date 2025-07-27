import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/bezier_curve_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  final Widget child;
  const ProfilePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Palette.secondaryColor),
        ClipPath(
          clipper: BezierCurveThree(),
          child: Container(color: Palette.backgroundPrimaryColor),
        ),

        Container(
          padding: const EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: SvgPicture.asset('assets/logo.svg', width: 220, height: 220),
        ),
        child,
      ],
    );
  }
}
