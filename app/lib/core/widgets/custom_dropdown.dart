// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final ValueChanged<String?>? onChanged;
  final Color borderColor;
  final String? hintText;
  final List<DropdownMenuItem<String>>? items;
  final String label;
  final Color labelColor;
  final String? value; // Tambahkan parameter value
  final Color errorColor;

  const CustomDropdown({
    super.key,
    required this.onChanged,
    this.borderColor = Palette.accentColor,
    this.hintText,
    required this.items,
    required this.label,
    this.labelColor = Palette.textPrimaryColor,
    this.value, // Tambahkan ke constructor
    this.errorColor = Palette.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
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
        DropdownButtonFormField<String>(
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Silakan Pilih $label';
            }
            return null;
          },
          initialValue: value, // Gunakan parameter value
          dropdownColor: Palette.backgroundPrimaryColor,
          decoration: InputDecoration(
            errorStyle: TextStyle(color: errorColor),
            filled: true,
            fillColor: Palette.backgroundPrimaryColor,
            hintText: label,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor, width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor, width: 3),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor, width: 3),
            ),
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
