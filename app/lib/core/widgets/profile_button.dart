import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  const ProfileButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(280, 60),
        backgroundColor: Palette.backgroundPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(icon, color: Palette.textPrimaryColor, size: 24),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Palette.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
