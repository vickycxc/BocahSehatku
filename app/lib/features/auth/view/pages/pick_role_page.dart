import 'package:app/core/widgets/custom_button.dart';
import 'package:app/core/widgets/custom_dropdown.dart';
import 'package:app/features/auth/view/pages/login_page.dart';
import 'package:app/features/auth/view/pages/posyandu_login_page.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:flutter/material.dart';
import 'package:app/core/utils.dart';

class PickRolePage extends StatelessWidget {
  const PickRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedRole;
    return WaveBackground(
      withBack: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
        child: Column(
          spacing: 40,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Masuk Sebagai', style: TextTheme.of(context).titleLarge),
            CustomDropdown(
              label: 'Pilih Peran',
              onChanged: (value) {
                // Handle role selection
                selectedRole = value;
              },
              items: const [
                DropdownMenuItem(value: 'ORANG_TUA', child: Text('Orang Tua')),
                DropdownMenuItem(
                  value: 'PETUGAS_POSYANDU',
                  child: Text('Petugas Posyandu'),
                ),
              ],
            ),
            CustomButton(
              onPressed: () {
                if (selectedRole != null) {
                  if (selectedRole == 'ORANG_TUA') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } else if (selectedRole == 'PETUGAS_POSYANDU') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PosyanduLoginPage(),
                      ),
                    );
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
