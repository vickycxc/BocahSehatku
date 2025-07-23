import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final bool withIcon;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.withIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(320, 55),
        backgroundColor: Palette.accentColor,
      ),
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          if (isLoading)
            SizedBox(
              height: 8,
              width: 8,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Palette.backgroundPrimaryColor,
                ),
              ),
            ),
          if (withIcon) SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Palette.backgroundPrimaryColor,
            ),
          ),
          if (isLoading) SizedBox(width: 8),
          if (withIcon)
            Icon(
              LucideIcons.chevronRight,
              color: Palette.backgroundPrimaryColor,
            ),
        ],
      ),
    );
  }
}
