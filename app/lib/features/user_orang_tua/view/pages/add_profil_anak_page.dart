import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/core/widgets/custom_field.dart';
import 'package:app/core/widgets/date_picker_field.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/features/user_orang_tua/viewmodel/ortu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _bbLahirController = TextEditingController();
  final TextEditingController _tbLahirController = TextEditingController();
  final TextEditingController _usiaKehamilanController =
      TextEditingController();
  final List<String> _opsiJenisKelamin = ['LAKI_LAKI', 'PEREMPUAN'];
  int _currentPage = 0;
  String? _selectedGender;
  DateTime? _tanggalLahir;
  bool? _isPrematur;
  bool _jenisKelaminRadioError = false;
  bool _prematurRadioError = false;
  bool _tanggalLahirError = false;
  @override
  Widget build(BuildContext context) {
    //TODO handle nik sama
    final isLoading = ref.watch(
      ortuViewModelProvider.select((val) => val.isLoading),
    );
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
              const SizedBox(width: 20),
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
                        const SizedBox(height: 16),
                        DatePickerField(
                          isError: _tanggalLahirError,
                          dateValue: _tanggalLahir,
                          errorColor: Palette.backgroundPrimaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          borderColor: Palette.primaryColor,
                          label: 'Tanggal Lahir',
                          hintText: 'Tanggal Lahir',
                          onDateSelected: (selectedDate) => setState(() {
                            _tanggalLahir = selectedDate;
                          }),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
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
                                  const Text(
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
                            if (_jenisKelaminRadioError)
                              const Text(
                                'Jenis Kelamin Harus Diisi!',
                                style: TextStyle(
                                  color: Palette.backgroundPrimaryColor,
                                ),
                              ),
                            if (_jenisKelaminRadioError)
                              const SizedBox(height: 16),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomField(
                          errorColor: Palette.backgroundPrimaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          borderColor: Palette.primaryColor,
                          label: 'NIK Anak (Opsional)',
                          hintText: 'NIK Anak',
                          keyboardType: TextInputType.number,
                          controller: _nikController,
                          validator: (val) {
                            if (val!.trim().isNotEmpty) {
                              if (val.length != 16 ||
                                  !RegExp(r'^\d{16}$').hasMatch(val)) {
                                return 'NIK Harus 16 Digit Angka!';
                              }
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          onPressed: () async {
                            if (_tanggalLahir == null) {
                              setState(() {
                                _tanggalLahirError = true;
                              });
                            } else {
                              setState(() {
                                _tanggalLahirError = false;
                              });
                            }
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
                                !_jenisKelaminRadioError &&
                                !_tanggalLahirError) {
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
                          keyboardType: TextInputType.number,
                          controller: _bbLahirController,
                          // validator: (val) {
                          //   if (val!.trim().isEmpty) {
                          //     return 'Berat Badan Lahir Harus Diisi!';
                          //   }
                          //   return null;
                          // },
                        ),
                        CustomField(
                          errorColor: Palette.backgroundPrimaryColor,
                          labelColor: Palette.backgroundPrimaryColor,
                          borderColor: Palette.primaryColor,
                          label: 'Tinggi Badan Lahir (cm) (Opsional)',
                          hintText: 'Tinggi Badan Lahir',
                          keyboardType: TextInputType.number,
                          controller: _tbLahirController,
                          // validator: (val) {
                          //   if (val!.trim().isEmpty) {
                          //     return 'Tinggi Badan Lahir Harus Diisi!';
                          //   }
                          //   return null;
                          // },
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
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
                                  const Text(
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
                                  const Text(
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
                            if (_prematurRadioError)
                              const Text(
                                'Opsi Prematur Harus Diisi!',
                                style: TextStyle(
                                  color: Palette.backgroundPrimaryColor,
                                ),
                              ),
                            if (_prematurRadioError) const SizedBox(height: 16),
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
                              if (_isPrematur == true) {
                                if (val!.trim().isEmpty) {
                                  return 'Usia Kehamilan Harus Diisi!';
                                }
                                if (int.tryParse(val.trim()) == null) {
                                  return 'Nilai Harus Angka Dan Tidak Berkoma!';
                                }
                                if (int.parse(val.trim()) <= 0) {
                                  return 'Usia Kehamilan Harus Angka Positif!';
                                }
                              }
                              return null;
                            },
                          ),

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
                            if (_isPrematur == null) {
                              setState(() {
                                _prematurRadioError = true;
                              });
                            } else {
                              setState(() {
                                _prematurRadioError = false;
                              });
                            }
                            if (_formKeyPageTwo.currentState!.validate() &&
                                !_prematurRadioError) {
                              await ref
                                  .read(ortuViewModelProvider.notifier)
                                  .tambahDataAnak(
                                    nama: _namaLengkapController.text.trim(),
                                    tanggalLahir: _tanggalLahir!
                                        .toIso8601String(),
                                    jenisKelamin: _selectedGender!,
                                    nik: _nikController.text,
                                    bbLahir: double.tryParse(
                                      _bbLahirController.text.trim(),
                                    ),
                                    tbLahir: double.tryParse(
                                      _tbLahirController.text.trim(),
                                    ),
                                    mingguLahir: _isPrematur == true
                                        ? int.parse(
                                            _usiaKehamilanController.text
                                                .trim(),
                                          )
                                        : null,
                                  );
                            }
                            if (context.mounted) Navigator.of(context).pop();
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
    _nikController.dispose();
    _bbLahirController.dispose();
    _tbLahirController.dispose();
    _usiaKehamilanController.dispose();
    super.dispose();
  }
}
