import 'package:app/core/constants.dart';
import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/core/widgets/custom_dropdown.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PosyanduPickPage extends ConsumerStatefulWidget {
  const PosyanduPickPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteProfilePageState();
}

class _CompleteProfilePageState extends ConsumerState<PosyanduPickPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedKecamatan;
  String? selectedPuskesmas;
  String? selectedPosyandu;
  List<String> opsi = ['LAKI_LAKI', 'PEREMPUAN'];
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (message) {
          if (message.isNotEmpty) {
            print('ini dalangnya');
            showSnackBar(context, message);
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrtuDashboardPage()),
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
      backgroundColor: Palette.secondaryColor,
      withLogo: false,
      withBezierTwo: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/logo.svg', width: 100, height: 100),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  // textAlign: TextAlign.center,
                  'Pilih Posyandu',
                  style: TextTheme.of(
                    context,
                  ).titleLarge?.copyWith(color: Palette.backgroundPrimaryColor),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 160),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 16,
                children: [
                  // Kecamatan Dropdown
                  CustomDropdown(
                    errorColor: Palette.backgroundPrimaryColor,
                    value: selectedKecamatan, // Kontrol nilai yang dipilih
                    borderColor: Palette.primaryColor,
                    labelColor: Palette.backgroundPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        selectedKecamatan = value;
                        selectedPuskesmas = null; // Reset child dropdown
                        selectedPosyandu = null; // Reset grandchild dropdown
                      });
                    },
                    items: Constants.daftarKecamatan.map((kecamatan) {
                      return DropdownMenuItem<String>(
                        value: kecamatan,
                        child: Text(kecamatan),
                      );
                    }).toList(),
                    label: 'Kecamatan',
                  ),
                  // Puskesmas Dropdown (bergantung pada Kecamatan)
                  CustomDropdown(
                    errorColor: Palette.backgroundPrimaryColor,
                    value: selectedPuskesmas,
                    borderColor: Palette.primaryColor,
                    labelColor: Palette.backgroundPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        selectedPuskesmas = value;
                        selectedPosyandu = null; // Reset child dropdown
                      });
                    },
                    items: selectedKecamatan != null
                        ? Constants.daftarPuskesmas[selectedKecamatan]?.map((
                            puskesmas,
                          ) {
                            return DropdownMenuItem<String>(
                              value: puskesmas,
                              child: Text(puskesmas),
                            );
                          }).toList()
                        : [],
                    label: 'Puskesmas',
                  ),
                  // Posyandu Dropdown (bergantung pada Puskesmas)
                  CustomDropdown(
                    errorColor: Palette.backgroundPrimaryColor,
                    value: selectedPosyandu,
                    borderColor: Palette.primaryColor,
                    labelColor: Palette.backgroundPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        selectedPosyandu = value;
                      });
                    },
                    items: selectedPuskesmas != null
                        ? Constants.daftarPosyandu[selectedPuskesmas]?.map((
                                posyandu,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: posyandu.id.toString(),
                                  child: Text(posyandu.namaPosyandu),
                                );
                              }).toList() ??
                              []
                        : [], // Return empty list jika selectedPuskesmas null
                    label: 'Posyandu',
                  ),
                  SizedBox(height: 6),
                  CustomButton(
                    isLoading: isLoading,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(authViewModelProvider.notifier)
                            .ajukanUbahNoHp(
                              posyanduId: int.parse(selectedPosyandu!),
                            );
                      }
                    },
                    text: 'Simpan',
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Setelah mengklik verifikasi, Anda perlu datang ke posyandu dengan membawa KTP, lalu petugas akan memverifikasi akun anda.',
                      style: TextStyle(
                        color: Palette.backgroundPrimaryColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
