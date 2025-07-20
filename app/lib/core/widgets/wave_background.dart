// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/size_config.dart';
import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/widgets/bezier_curve_two.dart';
import 'package:app/core/widgets/custom_back_button.dart';
import 'package:app/core/widgets/bezier_curve_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaveBackground extends StatelessWidget {
  final Widget? child;
  final List<Widget>? children;
  final bool withBack;
  final double? waveHeight;
  final bool withLogo;
  final Color waveColor;
  final Color? backgroundColor;
  final bool withBezierTwo;
  final double height;
  const WaveBackground({
    super.key,
    this.child,
    this.withBack = false,
    this.waveHeight = 0.7,
    this.withLogo = true,
    this.children,
    this.waveColor = Palette.primaryColor,
    this.backgroundColor,
    this.withBezierTwo = false,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: waveColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.safeScreenHeight * height,
          child: Stack(
            children: [
              if (backgroundColor != null) Container(color: backgroundColor),
              ClipPath(
                clipper: !withBezierTwo
                    ? BezierCurveOne(height: waveHeight)
                    : BezierCurveTwo(height: waveHeight),
                child: Container(color: waveColor),
              ),
              if (withLogo)
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    width: 220,
                    height: 220,
                  ),
                ),
              if (withBack) CustomBackButton(),
              if (child != null) child!,
              if (children != null) ...children!,
            ],
          ),
        ),
      ),
    );
  }
}
