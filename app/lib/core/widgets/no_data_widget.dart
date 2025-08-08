import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  const NoDataWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset('assets/baby_no_bg.svg', width: 10, height: 100),
        const SizedBox(height: 24),
        Text(
          message,
          style: const TextStyle(
            color: Palette.textPrimaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
