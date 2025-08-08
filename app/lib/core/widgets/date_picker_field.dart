// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/theme/palette.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/core/utils/utils.dart';
import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final bool isError;
  final String label;
  final DateTime? dateValue;
  final void Function(DateTime? selectedDate) onDateSelected;
  final String hintText;
  final Color borderColor;
  final Color labelColor;
  final Color errorColor;
  const DatePickerField({
    super.key,
    this.isError = false,
    required this.dateValue,
    required this.onDateSelected,
    required this.label,
    required this.hintText,
    this.borderColor = Palette.accentColor,
    this.labelColor = Palette.textPrimaryColor,
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

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: Palette.backgroundPrimaryColor,
            border: BoxBorder.all(color: borderColor, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              final selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                initialDate: dateValue ?? DateTime.now(),
                locale: const Locale('id', 'ID'),
                builder: (context, child) =>
                    Theme(data: AppTheme.theme, child: child!),
              );
              onDateSelected(selectedDate);
            },
            child: Text(
              dateValue != null ? formatTanggal(dateValue!) : hintText,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        if (isError)
          Text('$label Harus Diisi!', style: TextStyle(color: errorColor)),
      ],
    );
  }
}
