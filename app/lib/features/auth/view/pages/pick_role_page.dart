import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/widgets/auth_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/utils.dart';

class PickRolePage extends StatelessWidget {
  const PickRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedRole;
    return AuthBackground(
      withBack: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
        child: Column(
          spacing: 40,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Masuk Sebagai', style: TextTheme.of(context).titleLarge),
            DropdownButtonFormField<String>(
              dropdownColor: Palette.backgroundPrimaryColor,
              decoration: InputDecoration(
                hintText: 'Pilih Peran',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Palette.accentColor, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Palette.accentColor, width: 3),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Palette.accentColor, width: 3),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'ortu', child: Text('Orang Tua')),
                DropdownMenuItem(
                  value: 'posyandu',
                  child: Text('Petugas Posyandu'),
                ),
              ],
              onChanged: (value) {
                // Handle role selection
                selectedRole = value;
              },
            ),
            CustomButton(
              onPressed: () {
                if (selectedRole != null) {
                  if (selectedRole == 'ortu') {
                    context.push('/login');
                  } else if (selectedRole == 'posyandu') {
                    context.push('/login-posyandu');
                  }
                } else {
                  showSnackBar(context, 'Silakan Pilih Peran Terlebih Dahulu!');
                }
              },
              text: 'Masuk',
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
