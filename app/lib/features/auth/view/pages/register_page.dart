import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/pages/login_page.dart';
import 'package:app/features/auth/view/pages/otp_page.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/core/widgets/custom_field.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _noHpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final tujuan = 'DAFTAR';

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (message) {
          showSnackBar(context, message);
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
                'Mendaftar Akun Baru',
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
                    'Sudah punya akun? ',
                    style: TextTheme.of(context).titleMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 16,
                        color: Palette.accentColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
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
