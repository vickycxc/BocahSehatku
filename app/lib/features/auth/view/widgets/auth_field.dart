// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isObscure;
  const AuthField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 3),
    );
    return Column(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isObscure,
          validator: (val) {
            if (val!.trim().isEmpty) {
              return '$label Harus Diisi!';
            }
            return null;
          },
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            hintText: hintText,
            enabledBorder: border(Palette.accentColor),
            focusedBorder: border(Palette.accentColor),
            errorBorder: border(Palette.accentColor),
            focusedErrorBorder: border(Palette.accentColor),
            border: border(Palette.accentColor),
          ),
        ),
      ],
    );
  }
}
