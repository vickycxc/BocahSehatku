import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/pages/complete_profile_page.dart';
import 'package:app/features/auth/view/pages/otp_page.dart';
import 'package:app/features/auth/view/pages/pick_role_page.dart';
import 'package:app/features/auth/view/pages/posyandu_pick_page.dart';
import 'package:app/features/auth/view/pages/register_page.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/features/auth/view/widgets/onboarding_messages.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_dashboard_page.dart';
import 'package:app/features/user_posyandu/view/pages/posyandu_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (nav) {
          print(
            'Data received from otp page: ${nav.message}. tujuan: ${nav.tujuan}',
          );
          showSnackBar(context, nav.message);
          switch (nav.tujuan) {
            case 'MASUK':
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrtuDashboardPage(),
                ),
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
            case 'AJUKAN_UBAH_NO_HP':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PosyanduPickPage()),
              );
            case 'OTP_PAGE':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OtpPage()),
              );
            case 'POSYANDU_PAGE':
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PosyanduDashboardPage(),
                ),
                (_) => false,
              );
            case 'ONBOARDING_PAGE':
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const OnboardingPage()),
                (_) => false,
              );
            default:
              throw Exception('Origin tidak diketahui!: ${nav.tujuan}');
          }
        },
        error: (error, stackTrace) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });
    return WaveBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OnboardingMessages(),
          const SizedBox(height: 32),
          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PickRolePage()),
              );
            },
            text: 'Masuk',
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(320, 55),
              side: BorderSide(color: Palette.accentColor, width: 2.0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text(
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
