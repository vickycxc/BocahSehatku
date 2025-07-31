import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomBackButton extends StatelessWidget {
  final bool isElevated;
  const CustomBackButton({super.key, this.isElevated = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: isElevated ? 2 : 0,
            shadowColor: isElevated
                ? Palette.textPrimaryColor
                : Colors.transparent,

            backgroundColor: Palette.backgroundPrimaryColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(8),
          ),
          onPressed: () => {Navigator.pop(context)},
          child: Icon(LucideIcons.chevronLeft, color: Palette.textPrimaryColor),
        ),
      ),
    );
  }
}
