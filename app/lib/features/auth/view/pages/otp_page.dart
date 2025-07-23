import 'package:app/core/providers/pengajuan_otp_notifier.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/features/auth/model/pengajuan_otp_model.dart';
import 'package:app/features/auth/view/pages/posyandu_pick_page.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:app/features/auth/view/pages/complete_profile_page.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final ProviderSubscription<AsyncValue<String>?> _listener;
  late final PengajuanOtpModel _pengajuanOtp;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );
    void onSubmitted({String? kodeOtp}) async {
      switch (_pengajuanOtp.tujuan) {
        case 'MASUK':
          await ref
              .read(authViewModelProvider.notifier)
              .masuk(
                noHp: _pengajuanOtp.noHp,
                kodeOtp: kodeOtp ?? _otpController.text,
              );
        case 'DAFTAR':
          await ref
              .read(authViewModelProvider.notifier)
              .daftar(
                noHp: _pengajuanOtp.noHp,
                kodeOtp: kodeOtp ?? _otpController.text,
              );
        case 'AJUKAN_UBAH_NO_HP':
          await ref
              .read(authViewModelProvider.notifier)
              .verifikasiOtp(
                tujuan: _pengajuanOtp.tujuan,
                noHp: _pengajuanOtp.noHp,
                kodeOtp: kodeOtp ?? _otpController.text,
              );
        default:
          throw Exception('Origin tidak diketahui!: ${_pengajuanOtp.tujuan}');
      }
    }

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
                isLoading: isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    onSubmitted();
                  } else {
                    showSnackBar(context, 'Kode OTP Tidak Valid!');
                  }
                },
                text: switch (_pengajuanOtp.tujuan) {
                  'MASUK' => 'Masuk',
                  'DAFTAR' => 'Daftar',
                  'AJUKAN_UBAH_NO_HP' => 'Konfirmasi',
                  _ => throw Exception(
                    'Origin tidak diketahui!: ${_pengajuanOtp.tujuan}',
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
    _listener.close();
    _otpController.dispose();
    super.dispose();
  }
}
