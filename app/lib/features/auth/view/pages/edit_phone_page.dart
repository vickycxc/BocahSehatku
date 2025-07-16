import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/widgets/auth_background.dart';
import 'package:app/features/auth/view/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditPhonePage extends StatefulWidget {
  const EditPhonePage({super.key});

  @override
  State<EditPhonePage> createState() => _EditPhonePageState();
}

class _EditPhonePageState extends State<EditPhonePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      withBack: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Ganti No. HP Untuk\nAkun Anda',
                textAlign: TextAlign.center,
                style: TextTheme.of(context).titleLarge,
              ),
              AuthField(
                label: 'NIK',
                hintText: 'Masukkan NIK Anda',
                keyboardType: TextInputType.number,
                controller: _usernameController,
              ),
              AuthField(
                label: 'No. HP Baru',
                hintText: 'Masukkan No. HP Baru Anda',
                keyboardType: TextInputType.visiblePassword,
                controller: _usernameController,
                isObscure: true,
              ),
              SizedBox(height: 4),
              CustomButton(
                onPressed: () {
                  context.push('/otp', extra: 'edit phone');
                },
                text: 'Kirim Kode OTP',
              ),
              SizedBox(height: 2),
              Text(
                'Anda Perlu Ke Posyandu Terdekat Untuk Memverifikasi Identitas Anda.',
                textAlign: TextAlign.center,
                style: TextTheme.of(context).titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
