import 'package:app/core/theme/app_pallete.dart';
import 'package:app/features/auth/view/widgets/bezier_curve_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: BezierCurveOne(),
            child: Container(color: Pallete.primaryColor),
          ),
          Container(
            padding: const EdgeInsets.only(top: 60),
            alignment: Alignment.topCenter,
            child: SvgPicture.asset('assets/logo.svg', width: 220, height: 220),
          ),
          child,
        ],
      ),
    );
  }
}
