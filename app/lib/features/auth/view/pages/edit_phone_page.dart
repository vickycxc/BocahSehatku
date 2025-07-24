import 'package:app/core/providers/pengajuan_verifikasi_notifier.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/model/verifikasi_akun_model.dart';
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
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String tujuan = "AJUKAN_UBAH_NO_HP";

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );
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
                    ref
                        .read(pengajuanVerifikasiNotifierProvider.notifier)
                        .aturPengajuanVerifikasi(
                          VerifikasiPenggunaModel(
                            noHp: _noHpController.text,
                            nik: _nikController.text,
                            kodeOtp: null,
                          ),
                        );
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
}
