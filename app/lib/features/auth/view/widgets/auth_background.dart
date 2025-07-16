// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/size_config.dart';
import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/widgets/custom_back_button.dart';
import 'package:app/features/auth/view/widgets/bezier_curve_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final bool withBack;
  const AuthBackground({super.key, required this.child, this.withBack = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          child: Stack(
            children: [
              ClipPath(
                clipper: BezierCurveOne(),
                child: Container(color: Palette.primaryColor),
              ),
              Container(
                padding: const EdgeInsets.only(top: 60),
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  width: 220,
                  height: 220,
                ),
              ),
              if (withBack) CustomBackButton(),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
