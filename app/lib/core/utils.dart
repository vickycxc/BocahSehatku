import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Palette.backgroundPrimaryColor),
        ),
        backgroundColor: Palette.accentColor,
      ),
    );
}
