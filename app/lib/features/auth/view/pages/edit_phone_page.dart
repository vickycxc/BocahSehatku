import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/pages/otp_page.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/core/widgets/custom_field.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditPhonePage extends ConsumerStatefulWidget {
  const EditPhonePage({super.key});

  @override
  ConsumerState<EditPhonePage> createState() => _EditPhonePageState();
}

class _EditPhonePageState extends ConsumerState<EditPhonePage> {
  final String tujuan = "UBAH_NO_HP";
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              CustomField(
                label: 'NIK',
                hintText: 'Masukkan NIK Anda',
                keyboardType: TextInputType.number,
                controller: _nikController,
                validator: (val) {
                  if (val!.trim().isEmpty) {
                    return 'NIK Harus Diisi!';
                  }
                  if (val.length != 16) {
                    return 'Masukkan 16 Digit NIK!';
                  }
                  if (!RegExp(r'^\d{16}$').hasMatch(val)) {
                    return 'NIK Harus 16 Digit Angka!';
                  }
                  return null;
                },
              ),
              CustomField(
                label: 'No. HP Baru',
                hintText: 'Masukkan No. HP Baru Anda',
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
                        .kirimOtp(
                          noHp: _noHpController.text,
                          tujuan: tujuan,
                          nik: _nikController.text,
                        );
                  }
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
    _nikController.dispose();
    _noHpController.dispose();
    super.dispose();
  }
}
