import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/repositories/auth_remote_repository.dart';
import 'package:app/features/auth/view/widgets/auth_background.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          final message = switch (data) {
            Left(value: final l) => l.message,
            Right(value: final r) => r.message,
          };
          if (message != null && message.isNotEmpty) {
            showSnackBar(context, message);
          }
          context.go('/');
        },
        error: (error, stackTrace) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    final Map<String, String> extra =
        GoRouterState.of(context).extra! as Map<String, String>;
    void onSubmitted({String? kodeOtp}) async {
      switch (extra['tujuan']) {
        case 'Masuk':
          await ref
              .read(authViewModelProvider.notifier)
              .masuk(
                noHp: extra['noHp']!,
                kodeOtp: kodeOtp ?? _otpController.text,
              );
        case 'Daftar':
          await ref
              .read(authViewModelProvider.notifier)
              .daftar(
                noHp: extra['noHp']!,
                kodeOtp: kodeOtp ?? _otpController.text,
              );
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
                isLoading: isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    onSubmitted();
                  } else {
                    showSnackBar(context, 'Kode OTP Tidak Valid!');
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
