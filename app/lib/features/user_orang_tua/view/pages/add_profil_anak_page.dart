import 'package:app/core/providers/pengguna_aktif_notifier.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
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

class AddProfilAnakPage extends ConsumerStatefulWidget {
  const AddProfilAnakPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteProfilePageState();
}

class _CompleteProfilePageState extends ConsumerState<AddProfilAnakPage> {
  final _formKeyPageOne = GlobalKey<FormState>();
  final _formKeyPageTwo = GlobalKey<FormState>();
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _bbLahirController = TextEditingController();
  final TextEditingController _tbLahirController = TextEditingController();
  final TextEditingController _usiaKehamilanController =
      TextEditingController();
  final List<String> _opsiJenisKelamin = ['LAKI_LAKI', 'PEREMPUAN'];
  int _currentPage = 0;
  String? _selectedGender;
  bool? _isPrematur;
  bool _jenisKelaminRadioError = false;
  final bool _prematurRadioError = false;
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
          print('Data received from complete profile page: ${nav.message}.');
          if (nav.message.isNotEmpty) {
            showSnackBar(context, nav.message);
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
              title: error.message,
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
      withBack: true,
      waveHeight: 0.8,
      waveColor: Palette.accentColor,
      bezierType: 2,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 10),
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
                  'Tambah Profil\nAnak Baru',
                  textAlign: TextAlign.center,
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
                          label: 'Nama Lengkap Anak',
                          hintText: 'Nama Lengkap',
                          keyboardType: TextInputType.name,
                          controller: _namaLengkapController,
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return 'Nama Harus Diisi!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        CustomField(
                          errorColor: Palette.backgroundPrimaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          borderColor: Palette.primaryColor,
                          label: 'Tanggal Lahir',
                          hintText: 'Tanggal Lahir',
                          keyboardType: TextInputType.number,
                          controller: _tanggalLahirController,
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return 'NIK Harus Diisi!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jenis Kelamin Anak',
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
                                    value: _opsiJenisKelamin[0],
                                    activeColor: Palette.backgroundPrimaryColor,
                                    fillColor: WidgetStateProperty.all<Color>(
                                      Palette.accentColor,
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                          Palette.backgroundPrimaryColor,
                                        ),
                                  ),
                                  Text(
                                    'Laki-Laki',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.backgroundPrimaryColor,
                                    ),
                                  ),
                                  Radio(
                                    value: _opsiJenisKelamin[1],
                                    activeColor: Palette.backgroundPrimaryColor,
                                    fillColor: WidgetStateProperty.all<Color>(
                                      Palette.accentColor,
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                          Palette.backgroundPrimaryColor,
                                        ),
                                  ),
                                  Text(
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
                            if (_jenisKelaminRadioError)
                              Text(
                                'Jenis Kelamin Harus Diisi!',
                                style: TextStyle(
                                  color: Palette.backgroundPrimaryColor,
                                ),
                              ),
                            if (_jenisKelaminRadioError) SizedBox(height: 16),
                          ],
                        ),
                        SizedBox(height: 16),
                        CustomField(
                          errorColor: Palette.backgroundPrimaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          borderColor: Palette.primaryColor,
                          label: 'Nomor Induk Kependudukan (NIK)',
                          hintText: 'NIK Anak',
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
                        SizedBox(height: 24),
                        CustomButton(
                          onPressed: () async {
                            if (_selectedGender == null) {
                              setState(() {
                                _jenisKelaminRadioError = true;
                              });
                            } else {
                              setState(() {
                                _jenisKelaminRadioError = false;
                              });
                            }
                            if (_formKeyPageOne.currentState!.validate() &&
                                !_jenisKelaminRadioError) {
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
                        CustomField(
                          errorColor: Palette.backgroundPrimaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          borderColor: Palette.primaryColor,
                          label: 'Berat Badan Lahir (kg) (Opsional)',
                          hintText: 'Berat Badan Lahir',
                          keyboardType: TextInputType.name,
                          controller: _bbLahirController,
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return 'Nama Harus Diisi!';
                            }
                            return null;
                          },
                        ),
                        CustomField(
                          errorColor: Palette.backgroundPrimaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          borderColor: Palette.primaryColor,
                          label: 'Tinggi Badan Lahir (cm) (Opsional)',
                          hintText: 'Tinggi Badan Lahir',
                          keyboardType: TextInputType.number,
                          controller: _tbLahirController,
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return 'NIK Harus Diisi!';
                            }
                            return null;
                          },
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Apakah Anak Lahir Prematur?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Palette.backgroundPrimaryColor,
                              ),
                            ),
                            RadioGroup<bool>(
                              groupValue: _isPrematur,
                              onChanged: (value) {
                                setState(() {
                                  _isPrematur = value;
                                });
                              },
                              child: Row(
                                children: [
                                  Radio(
                                    value: true,
                                    activeColor: Palette.backgroundPrimaryColor,
                                    fillColor: WidgetStateProperty.all<Color>(
                                      Palette.accentColor,
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                          Palette.backgroundPrimaryColor,
                                        ),
                                  ),
                                  Text(
                                    'Ya',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.backgroundPrimaryColor,
                                    ),
                                  ),
                                  Radio(
                                    value: false,
                                    activeColor: Palette.backgroundPrimaryColor,
                                    fillColor: WidgetStateProperty.all<Color>(
                                      Palette.accentColor,
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                          Palette.backgroundPrimaryColor,
                                        ),
                                  ),
                                  Text(
                                    'Tidak',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.backgroundPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_jenisKelaminRadioError)
                              Text(
                                'Opsi Prematur Harus Diisi!',
                                style: TextStyle(
                                  color: Palette.backgroundPrimaryColor,
                                ),
                              ),
                            if (_prematurRadioError) SizedBox(height: 16),
                          ],
                        ),
                        if (_isPrematur == true)
                          CustomField(
                            errorColor: Palette.backgroundPrimaryColor,
                            labelColor: Palette.backgroundPrimaryColor,
                            borderColor: Palette.primaryColor,
                            label: 'Usia Kehamilan (Minggu)',
                            hintText: 'Usia Kehamilan (Minggu)',
                            keyboardType: TextInputType.number,
                            controller: _usiaKehamilanController,
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return 'NIK Harus Diisi!';
                              }
                              return null;
                            },
                          ),
                        if (_isPrematur == true) SizedBox(height: 0),

                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Palette.backgroundPrimaryColor,
                            fixedSize: const Size(320, 55),
                            side: BorderSide(
                              color: Palette.primaryColor,
                              width: 2.0,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _currentPage = 0;
                            });
                          },
                          child: Row(
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
                              // await ref
                              //     .read(authViewModelProvider.notifier)
                              //     .perbaruiProfil(
                              //       nama: _namaController.text,
                              //       nik: _nikController.text,
                              //       jenisKelamin: _selectedGender!,
                              //       alamat: _alamatController.text,
                              //       posyanduId: int.parse(selectedPosyandu!),
                              //     );
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
    _namaLengkapController.dispose();
    _tanggalLahirController.dispose();
    _nikController.dispose();
    _bbLahirController.dispose();
    _tbLahirController.dispose();
    _usiaKehamilanController.dispose();
    super.dispose();
  }
}
