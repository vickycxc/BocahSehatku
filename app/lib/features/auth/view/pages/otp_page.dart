import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/repositories/auth_remote_repository.dart';
import 'package:app/features/auth/view/widgets/auth_background.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Map<String, String> extra =
        GoRouterState.of(context).extra! as Map<String, String>;
    void onSubmitted({String? kodeOtp}) async {
      switch (extra['tujuan']) {
        case 'Masuk':
          final res = await AuthRemoteRepository().masuk(
            noHp: extra['noHp']!,
            kodeOtp: _otpController.text,
          );
          final val = switch (res) {
            Left(value: final l) => l,
            Right(value: final r) => r.toString(),
          };
          print(val);
        case 'Daftar':
          final res = await AuthRemoteRepository().daftar(
            noHp: extra['noHp']!,
            kodeOtp: kodeOtp ?? _otpController.text,
          );
          final val = switch (res) {
            Left(value: final l) => l,
            Right(value: final r) => r.toString(),
          };
          print(val);
        case 'Ubah No. HP':
          await AuthRemoteRepository().ubahNoHp(
            // noHp: extra['noHp']!,
            // kodeOtp: _otpController.text,
          );
        default:
          throw Exception('Origin tidak diketahui!: ${extra['tujuan']}');
      }
    }

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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kode OTP tidak boleh kosong';
                  }
                  if (value.length != 4) {
                    return 'Kode OTP harus 4 digit';
                  }
                  return null;
                },
                // onSubmitted: (kodeOtp) async => onSubmitted(kodeOtp: kodeOtp),
                controller: _otpController,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextTheme.of(context).titleLarge,
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.accentColor, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => {
                  if (_formKey.currentState!.validate())
                    {onSubmitted(kodeOtp: pin)},
                },
              ),
              SizedBox(height: 4),
              CustomButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    onSubmitted();
                  }
                },
                text: switch (extra['tujuan']) {
                  'Masuk' => 'Masuk',
                  'Daftar' => 'Daftar',
                  'Ubah No. HP' => 'Konfirmasi',
                  _ => throw Exception(
                    'Origin tidak diketahui!: ${extra['tujuan']}',
                  ),
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
