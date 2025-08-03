import 'package:app/core/model/anak_model.dart';
import 'package:app/core/size_config.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils.dart';
import 'package:app/core/widgets/custom_app_bar.dart';
import 'package:app/core/widgets/custom_back_button.dart';
import 'package:app/features/user_posyandu/view/widgets/posyandu_anak_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PosyanduAddEntryPage extends StatefulWidget {
  const PosyanduAddEntryPage({super.key});

  @override
  State<PosyanduAddEntryPage> createState() => _PosyanduAddEntryPageState();
}

class _PosyanduAddEntryPageState extends State<PosyanduAddEntryPage> {
  final PanelController _panelController = PanelController();
  late MobileScannerController scannerController;
  bool _panelOpened = false;
  List<PosyanduAnakCard> pos = [
    PosyanduAnakCard(
      AnakModel(
        localId: 0,
        nama:
            'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
        tanggalLahir: DateTime(2025, 2, 3),
        jenisKelamin: JenisKelamin.lakiLaki,
        nik: '20000',
        orangTuaId: 2,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        listPengukuran: [],
      ),
    ),
    PosyanduAnakCard(
      AnakModel(
        localId: 0,
        nama:
            'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
        tanggalLahir: DateTime(2025, 2, 3),
        jenisKelamin: JenisKelamin.lakiLaki,
        nik: '20000',
        orangTuaId: 2,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        listPengukuran: [],
      ),
    ),
    PosyanduAnakCard(
      AnakModel(
        localId: 0,
        nama:
            'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
        tanggalLahir: DateTime(2025, 2, 3),
        jenisKelamin: JenisKelamin.lakiLaki,
        nik: '20000',
        orangTuaId: 2,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        listPengukuran: [],
      ),
    ),
    PosyanduAnakCard(
      AnakModel(
        localId: 0,
        nama:
            'Ngatmono Ranu Danaswara Kinanjati Winarno adi sucipto mangonkusumo',
        tanggalLahir: DateTime(2025, 2, 3),
        jenisKelamin: JenisKelamin.lakiLaki,
        nik: '20000',
        orangTuaId: 2,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        listPengukuran: [],
      ),
    ),
  ];

  @override
  void initState() {
    scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
    scannerController.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.textPrimaryColor,
      appBar: CustomAppBar(
        content: Row(
          children: [
            CustomBackButton(),
            Expanded(
              child: SafeArea(
                child: Text(
                  'Tambah Entri Baru',
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: TextStyle(
                    color: Palette.backgroundPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SlidingUpPanel(
        controller: _panelController,
        onPanelOpened: () {
          setState(() {
            _panelOpened = true;
          });
          scannerController.stop();
        },
        onPanelClosed: () {
          setState(() {
            _panelOpened = false;
          });
          scannerController.start();
        },
        minHeight: 250,
        maxHeight: SizeConfig.screenHeight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
        panelBuilder: (sc) {
          return ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
            child: SingleChildScrollView(
              controller: sc,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    _panelOpened
                        ? SizedBox(height: 100)
                        : Text(
                            'Atau Masukkan Nama Lengkap Anak',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Palette.textPrimaryColor,
                            ),
                          ),
                    if (_panelOpened)
                      Text(
                        'Masukkan Nama Lengkap Anak',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Palette.textPrimaryColor,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 24,
                      ),
                      child: SearchBar(
                        onTap: () {
                          _panelController.open();
                        },
                        textStyle: WidgetStatePropertyAll(
                          TextStyle(
                            fontSize: 14,
                            color: Palette.textPrimaryColor,
                          ),
                        ),
                        hintText: 'Masukkan nama anak...',
                        backgroundColor: WidgetStatePropertyAll(
                          Palette.backgroundPrimaryColor,
                        ),
                        leading: Icon(
                          LucideIcons.search,
                          color: Palette.textPrimaryColor,
                        ),
                        elevation: WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: Palette.accentColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(children: pos),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        bottom: 16,
                        right: 12,
                      ),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          // fixedSize: const Size(320, 55),
                          side: BorderSide(
                            color: Palette.textPrimaryColor,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LucideIcons.userRoundPlus,
                                color: Palette.textPrimaryColor,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Tambah Profil Anak Baru',
                                style: TextStyle(
                                  color: Palette.textPrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        body: Stack(
          fit: StackFit.expand,
          children: [
            MobileScanner(
              controller: scannerController,
              onDetect: (barcodes) {
                final barcodeValue =
                    barcodes.barcodes.firstOrNull?.displayValue;
                if (barcodeValue != null) {
                  showSnackBar(context, barcodeValue);
                }
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/icons/scan.svg',
                  width: SizeConfig.screenWidth * 0.8,
                  height: SizeConfig.screenWidth * 0.8,
                ),
                SizedBox(height: 50),
                Text(
                  'Silakan Memindai Kode QR',
                  style: TextStyle(
                    fontSize: 16,
                    color: Palette.backgroundPrimaryColor,
                  ),
                ),
                SizedBox(height: 265),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    await scannerController.dispose();
    super.dispose();
  }
}
