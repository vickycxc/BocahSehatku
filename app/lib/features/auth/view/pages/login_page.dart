import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/pages/edit_phone_page.dart';
import 'package:app/features/auth/view/pages/otp_page.dart';
import 'package:app/features/auth/view/pages/register_page.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/core/widgets/custom_field.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _noHpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final tujuan = 'MASUK';

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (message) {
          if (message.isNotEmpty) {
            showSnackBar(context, message);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtpPage(noHp: _noHpController.text, tujuan: tujuan),
            ),
          );
        },
        error: (error, stackTrace) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return WaveBackground(
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
              CustomField(
                label: 'No. HP',
                hintText: 'Masukkan No. HP Anda',
                keyboardType: TextInputType.phone,
                controller: _noHpController,
                validator: (val) {
                  if (val!.trim().isEmpty) {
                    return 'No. HP Harus Diisi!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 4),
              CustomButton(
                isLoading: isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ref
                        .read(authViewModelProvider.notifier)
                        .kirimOtp(noHp: _noHpController.text, tujuan: tujuan);
                  }
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
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        color: Palette.accentColor,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPhonePage(),
                            ),
                          );
                        },
                        child: Text(
                          'Ganti No. HP',
                          style: TextStyle(
                            color: Palette.accentColor,
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
    _noHpController.dispose();
    super.dispose();
  }
}
