import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/widgets/auth_background.dart';
import 'package:app/features/auth/view/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      withBack: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Masuk ke Akun Anda',
                style: TextTheme.of(context).titleLarge,
              ),
              AuthField(
                label: 'No. HP',
                hintText: 'Masukkan No. HP Anda',
                keyboardType: TextInputType.phone,
                controller: _phoneController,
              ),
              SizedBox(height: 4),
              CustomButton(
                onPressed: () {
                  context.push(
                    '/otp',
                    extra: {'tujuan': 'Masuk', 'noHp': _phoneController.text},
                  );
                },
                text: 'Kirim Kode OTP',
              ),
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: TextTheme.of(context).titleMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushReplacement('/register');
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tidak Dapat Mengakses Akun',
                    style: TextTheme.of(context).titleMedium,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Anda? ', style: TextTheme.of(context).titleMedium),
                      GestureDetector(
                        onTap: () {
                          context.push('/edit-phone');
                        },
                        child: Text(
                          'Ganti No. HP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
