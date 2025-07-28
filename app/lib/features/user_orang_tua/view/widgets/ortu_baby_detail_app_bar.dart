import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OrtuBabyDetailAppBar extends StatelessWidget {
  final AnakModel anak;
  const OrtuBabyDetailAppBar(this.anak, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomBackButton(),
        Expanded(
          child: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    anak.nama,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(
                      color: Palette.backgroundPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    anak.usiaInString,
                    maxLines: 2,
                    style: TextStyle(
                      color: Palette.backgroundPrimaryColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              onPressed: () => {},
              child: Icon(
                LucideIcons.qrCode,
                color: Palette.textPrimaryColor,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
