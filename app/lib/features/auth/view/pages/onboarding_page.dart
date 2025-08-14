import 'package:app/core/providers/pengajuan_verifikasi_notifier.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/model/navigasi_auth_model.dart';
import 'package:app/features/auth/view/pages/complete_profile_page.dart';
import 'package:app/features/auth/view/pages/otp_page.dart';
import 'package:app/features/auth/view/pages/pick_role_page.dart';
import 'package:app/features/auth/view/pages/posyandu_pick_page.dart';
import 'package:app/features/auth/view/pages/register_page.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/features/auth/view/widgets/onboarding_messages.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_page.dart';
import 'package:app/features/user_posyandu/view/pages/posyandu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickalert/quickalert.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (nav) {
          print(
            'Data received from onboarding page: ${nav.pesan}. tujuan: ${nav.tujuan}',
          );
          if (nav.tujuan != 'ONBOARDING_PAGE') {
            showSnackBar(
              context,
              nav.pesan,
              isFloating: nav.tujuan == 'POSYANDU_PAGE',
            );
            switch (nav.tujuan) {
              case 'MASUK':
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const OrtuPage()),
                  (_) => false,
                );
              case 'DAFTAR':
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CompleteProfilePage(),
                  ),
                  (_) => false,
                );
              case 'PILIH_POSYANDU':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PosyanduPickPage(),
                  ),
                );
              case 'OTP_PAGE':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OtpPage()),
                );
              case 'COMPLETE_PROFILE_PAGE':
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CompleteProfilePage(),
                  ),
                  (_) => false,
                );
              case 'ORTU_PAGE':
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const OrtuPage()),
                  (_) => false,
                );
              case 'POSYANDU_PAGE':
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const PosyanduPage()),
                  (_) => false,
                );
              default:
                showSnackBar(context, 'Origin tidak diketahui!: ${nav.tujuan}');
            }
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingPage()),
              (_) => false,
            );
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: 'Sukses!',
              text: nav.pesan,
              confirmBtnText: 'Oke',
              confirmBtnColor: Palette.accentColor,
            );
          }
        },
        error: (error, stackTrace) {
          if (error is NavigasiAuthModel) {
            if (error.tujuan == 'SUDAH_MENGAJUKAN') {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                title: error.pesan,
                text:
                    'No. HP: ${error.noHp}\nPosyandu: ${error.posyandu}\nApakah Anda ingin membatalkan pengajuan sebelumnya?',
                confirmBtnText: 'Ya',
                cancelBtnText: 'Tidak',
                onConfirmBtnTap: () => ref
                    .read(authViewModelProvider.notifier)
                    .batalkanPengajuanUbahNoHp(),
                onCancelBtnTap: () {
                  ref
                      .read(pengajuanVerifikasiNotifierProvider.notifier)
                      .hapusPengajuanVerifikasi();
                  Navigator.pop(context);
                },
                confirmBtnColor: Palette.accentColor,
                barrierDismissible: false,
                customAsset: 'assets/info.gif',
              );
            } else {
              showSnackBar(context, error.pesan);
            }
          } else {
            showSnackBar(context, error.toString());
          }
        },
        loading: () {},
      );
    });
    return WaveBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const OnboardingMessages(),
          const SizedBox(height: 32),
          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PickRolePage()),
              );
            },
            text: 'Masuk',
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(320, 55),
              side: const BorderSide(color: Palette.accentColor, width: 2.0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },
            child: const Text(
              'Daftar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
