import 'package:app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(320, 55),
        backgroundColor: Pallete.accentColor,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Pallete.backgroundPrimaryColor,
        ),
      ),
    );
  }
}
