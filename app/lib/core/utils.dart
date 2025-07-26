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

String formatAngka(double? angka) {
  return angka != null
      ? (angka % 1 == 0
            ? angka
                  .toInt()
                  .toString() // Tampilkan tanpa koma jika bilangan bulat
            : angka.toStringAsFixed(
                1,
              )) // Tampilkan dengan koma jika ada desimal
      : '-';
}

enum JenisKelamin { lakiLaki, perempuan }
