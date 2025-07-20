// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isObscure;
  final Color borderColor;
  final Color labelColor;
  final Color errorColor;
  const CustomField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.borderColor = Palette.accentColor,
    this.labelColor = Palette.textPrimaryColor,
    this.errorColor = Palette.secondaryColor,
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: labelColor,
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isObscure,
          validator: validator,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            errorStyle: TextStyle(color: errorColor),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            hintText: hintText,
            enabledBorder: border(borderColor),
            focusedBorder: border(borderColor),
            errorBorder: border(borderColor),
            focusedErrorBorder: border(borderColor),
            border: border(borderColor),
            fillColor: Palette.backgroundPrimaryColor,
          ),
        ),
      ],
    );
  }
}
