import 'package:app/core/theme/app_pallete.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/widgets/auth_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color, width: 3),
  );
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final String origin = GoRouterState.of(context).extra! as String;
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
                'Masukkan Kode OTP',
                style: TextTheme.of(context).titleLarge,
              ),
              Pinput(
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextTheme.of(context).titleLarge,
                  decoration: BoxDecoration(
                    border: Border.all(color: Pallete.accentColor, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (s) {
                  return s == '2222' ? null : 'Kode OTP Salah!';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => {
                  if (_formKey.currentState!.validate()) context.pop(),
                },
              ),
              SizedBox(height: 4),
              CustomButton(
                onPressed: () {},
                text: switch (origin) {
                  'login' => 'Masuk',
                  'register' => 'Daftar',
                  'edit phone' => 'Konfirmasi',
                  _ => throw Exception('Origin tidak diketahui!: $origin'),
                },
              ),
              SizedBox(height: 4),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Kode OTP Belum Masuk?',
                    style: TextTheme.of(context).titleMedium,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Kirim Ulang Kode OTP',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
