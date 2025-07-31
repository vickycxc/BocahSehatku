import 'package:app/core/theme/palette.dart';
import 'package:app/core/widgets/custom_button.dart';
import 'package:app/core/widgets/custom_field.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PosyanduAddEntry2 extends ConsumerStatefulWidget {
  const PosyanduAddEntry2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteProfilePageState();
}

class _CompleteProfilePageState extends ConsumerState<PosyanduAddEntry2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bbSekarangController = TextEditingController();
  final TextEditingController _tbSekarangController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final isLoading = ref.watch(
    //   authViewModelProvider.select((val) => val?.isLoading == true),
    // );
    return WaveBackground(
      withBack: true,
      backgroundColor: Palette.secondaryColor,
      waveColor: Palette.accentColor,
      waveHeight: 0.8,
      withLogo: false,
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
                  'Tambah Entri\nBaru',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text(
                  'Identitas Anak',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Palette.backgroundPrimaryColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Palette.backgroundSecondaryColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Palette.primaryColor, width: 3),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/baby_no_bg.svg',
                                    width: 36,
                                    height: 36,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nama Anak',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          textAlign:
                                              TextAlign.start, // Teks rata kiri
                                          overflow: TextOverflow
                                              .ellipsis, // Potong teks jika terlalu panjang
                                          maxLines: 1, // Maksimal 1 baris
                                        ),
                                        Text(
                                          'Melon Usk Kurniadi',
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/icons/parents.png',
                                    width: 36,
                                    height: 36,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Orang Tua',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          textAlign:
                                              TextAlign.start, // Teks rata kiri
                                          overflow: TextOverflow
                                              .ellipsis, // Potong teks jika terlalu panjang
                                          maxLines: 1, // Maksimal 1 baris
                                        ),
                                        Text(
                                          'Mujiati',
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/icons/age.png',
                                    width: 36,
                                    height: 36,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Usia',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          '2 Bulan 3 Hari',
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines:
                                              2, // Maksimal 2 baris untuk teks panjang
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/icons/house.png',
                                    width: 36,
                                    height: 36,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alamat',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          'Jl. Melati No. 123 Gresik',
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines:
                                              2, // Maksimal 2 baris untuk teks panjang
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 16,
                    children: [
                      CustomField(
                        label: 'Berat Badan Sekarang (kg)',
                        hintText: 'Berat Badan Sekarang (kg)',
                        keyboardType: TextInputType.text,
                        controller: _bbSekarangController,
                        labelColor: Palette.backgroundPrimaryColor,
                        borderColor: Palette.primaryColor,
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return 'Kode Posyandu Harus Diisi!';
                          }
                          return null;
                        },
                      ),
                      CustomField(
                        label: 'Tinggi Badan Sekarang (cm)',
                        hintText: 'Tinggi Badan Sekarang (cm)',
                        keyboardType: TextInputType.visiblePassword,
                        controller: _tbSekarangController,
                        labelColor: Palette.backgroundPrimaryColor,
                        borderColor: Palette.primaryColor,
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return 'Kode Posyandu Harus Diisi!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 6),
                      CustomButton(
                        // isLoading: isLoading,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // await ref
                            //     .read(authViewModelProvider.notifier)
                            //     .ajukanUbahNoHp(
                            //       posyanduId: int.parse(selectedPosyandu!),
                            //     );
                          }
                        },
                        text: 'Simpan',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
