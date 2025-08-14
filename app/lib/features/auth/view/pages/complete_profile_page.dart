import 'package:app/core/constants/constants.dart';
import 'package:app/core/providers/pengguna_aktif_notifier.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/core/widgets/custom_dropdown.dart';
import 'package:app/core/widgets/custom_field.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/features/auth/model/navigasi_auth_model.dart';
import 'package:app/features/auth/view/pages/onboarding_page.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:quickalert/quickalert.dart';

class CompleteProfilePage extends ConsumerStatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteProfilePageState();
}

class _CompleteProfilePageState extends ConsumerState<CompleteProfilePage> {
  final _formKeyPageOne = GlobalKey<FormState>();
  final _formKeyPageTwo = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  String? selectedKecamatan;
  String? selectedPuskesmas;
  String? selectedPosyandu;
  int _currentPage = 0;
  List<String> opsi = ['LAKI_LAKI', 'PEREMPUAN'];
  String? _selectedGender;
  bool radioError = false;
  @override
  Widget build(BuildContext context) {
    //TODO handle nik sama
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );
    final currentUser = ref.watch(penggunaAktifNotifierProvider);
    final noHp = switch (currentUser?.data) {
      Left(value: final l) => l.noHp,
      Right() => null,
      _ => null,
    };
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (nav) {
          if (nav.pesan.isNotEmpty) {
            showSnackBar(context, nav.pesan);
          }
          switch (nav.tujuan) {
            case 'ORTU_PAGE':
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const OrtuPage()),
                (_) => false,
              );
            case 'ONBOARDING_PAGE':
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const OnboardingPage()),
                (_) => false,
              );
          }
        },
        error: (error, stackTrace) {
          print("🚀 ~ _CompleteProfilePageState ~ ref.listen ~ error:$error");
          if (error is NavigasiAuthModel) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.confirm,
              title: error.pesan,
              text:
                  'No. HP Yang Tersambung Ke NIK: ${error.noHp}\nApakah Anda ingin keluar dan menghapus akun sekarang dengan No HP: $noHp?',
              confirmBtnText: 'Ya',
              cancelBtnText: 'Tidak',
              onConfirmBtnTap: () {
                ref.read(authViewModelProvider.notifier).hapusAkun();
              },
              confirmBtnColor: Palette.accentColor,
              barrierDismissible: false,
              customAsset: 'assets/info.gif',
            );
          } else {
            showSnackBar(context, error.toString());
          }
        },
        loading: () {},
      );
    });
    return WaveBackground(
      backgroundColor: Palette.secondaryColor,
      withLogo: false,
      bezierType: 2,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/logo.svg', width: 100, height: 100),
              const SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: Text(
                  textAlign: TextAlign.center,
                  'Lengkapi Profil Anda',
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
            child: (_currentPage == 0)
                ? Form(
                    key: _formKeyPageOne,
                    child: Column(
                      children: [
                        CustomField(
                          errorColor: Palette.backgroundPrimaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          borderColor: Palette.primaryColor,
                          label: 'Nama Lengkap Orang Tua',
                          hintText: 'Nama Lengkap',
                          keyboardType: TextInputType.name,
                          controller: _namaController,
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return 'Nama Harus Diisi!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomField(
                          errorColor: Palette.backgroundPrimaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          borderColor: Palette.primaryColor,
                          label: 'Nomor Induk Kependudukan (NIK)',
                          hintText: 'NIK Orang Tua',
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
                        const SizedBox(height: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Jenis Kelamin Orang Tua',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Palette.backgroundPrimaryColor,
                              ),
                            ),
                            RadioGroup<String>(
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                              child: Row(
                                children: [
                                  Radio(
                                    value: opsi[0],
                                    activeColor: Palette.backgroundPrimaryColor,
                                    fillColor: WidgetStateProperty.all<Color>(
                                      Palette.accentColor,
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                          Palette.backgroundPrimaryColor,
                                        ),
                                  ),
                                  const Text(
                                    'Laki-Laki',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.backgroundPrimaryColor,
                                    ),
                                  ),
                                  Radio(
                                    value: opsi[1],
                                    activeColor: Palette.backgroundPrimaryColor,
                                    fillColor: WidgetStateProperty.all<Color>(
                                      Palette.accentColor,
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                          Palette.backgroundPrimaryColor,
                                        ),
                                  ),
                                  const Text(
                                    'Perempuan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.backgroundPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (radioError)
                              const Text(
                                'Jenis Kelamin Harus Diisi!',
                                style: TextStyle(
                                  color: Palette.backgroundPrimaryColor,
                                ),
                              ),
                            if (radioError) const SizedBox(height: 16),
                          ],
                        ),
                        CustomField(
                          errorColor: Palette.backgroundPrimaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          borderColor: Palette.primaryColor,
                          label: 'Alamat',
                          hintText: 'Alamat',
                          keyboardType: TextInputType.text,
                          controller: _alamatController,
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          onPressed: () async {
                            if (_selectedGender == null) {
                              setState(() {
                                radioError = true;
                              });
                            } else {
                              setState(() {
                                radioError = false;
                              });
                            }
                            if (_formKeyPageOne.currentState!.validate() &&
                                !radioError) {
                              setState(() => _currentPage = 1);
                            }
                          },
                          text: 'Lanjut',
                          withIcon: true,
                        ),
                      ],
                    ),
                  )
                : Form(
                    key: _formKeyPageTwo,
                    child: Column(
                      spacing: 16,
                      children: [
                        // Kecamatan Dropdown
                        CustomDropdown(
                          errorColor: Palette.backgroundPrimaryColor,
                          value:
                              selectedKecamatan, // Kontrol nilai yang dipilih
                          borderColor: Palette.primaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          onChanged: (value) {
                            setState(() {
                              selectedKecamatan = value;
                              selectedPuskesmas = null; // Reset child dropdown
                              selectedPosyandu =
                                  null; // Reset grandchild dropdown
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
                              ? Constants.daftarPuskesmas[selectedKecamatan]
                                    ?.map((puskesmas) {
                                      return DropdownMenuItem<String>(
                                        value: puskesmas,
                                        child: Text(puskesmas),
                                      );
                                    })
                                    .toList()
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
                              ? Constants.daftarPosyandu[selectedPuskesmas]
                                        ?.map((posyandu) {
                                          return DropdownMenuItem<String>(
                                            value: posyandu.id.toString(),
                                            child: Text(posyandu.namaPosyandu),
                                          );
                                        })
                                        .toList() ??
                                    []
                              : [], // Return empty list jika selectedPuskesmas null
                          label: 'Posyandu',
                        ),
                        const SizedBox(height: 6),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Palette.backgroundPrimaryColor,
                            fixedSize: const Size(320, 55),
                            side: const BorderSide(
                              color: Palette.primaryColor,
                              width: 2.0,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _currentPage = 0;
                            });
                          },
                          child: const Row(
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LucideIcons.chevronLeft,
                                color: Palette.accentColor,
                              ),
                              Text(
                                'Kembali',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                        CustomButton(
                          isLoading: isLoading,
                          onPressed: () async {
                            if (_formKeyPageTwo.currentState!.validate()) {
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .perbaruiProfil(
                                    nama: _namaController.text,
                                    nik: _nikController.text,
                                    jenisKelamin: _selectedGender!,
                                    alamat: _alamatController.text,
                                    posyanduId: int.parse(selectedPosyandu!),
                                  );
                            }
                          },
                          text: 'Simpan',
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nikController.dispose();
    _alamatController.dispose();
    super.dispose();
  }
}
