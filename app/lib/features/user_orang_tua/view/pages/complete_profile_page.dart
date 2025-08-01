import 'package:app/core/constants.dart';
import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/core/widgets/custom_dropdown.dart';
import 'package:app/core/widgets/custom_field.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:app/features/user_orang_tua/view/pages/ortu_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (message) {
          if (message.isNotEmpty) {
            showSnackBar(context, message);
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => OrtuDashboardPage()),
            (_) => false,
          );
        },
        error: (error, stackTrace) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });
    return WaveBackground(
      backgroundColor: Palette.secondaryColor,
      withLogo: false,
      withBezierTwo: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/logo.svg', width: 100, height: 100),
              SizedBox(width: 20),
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
                        SizedBox(height: 16),
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
                        SizedBox(height: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
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
                                  Text(
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
                            if (radioError)
                              Text(
                                'Jenis Kelamin Harus Diisi!',
                                style: TextStyle(
                                  color: Palette.backgroundPrimaryColor,
                                ),
                              ),
                            if (radioError) SizedBox(height: 16),
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
                        SizedBox(height: 24),
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
                        SizedBox(height: 6),
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
