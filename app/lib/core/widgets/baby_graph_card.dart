import 'package:app/core/antropometri/antropometri.dart';
import 'package:app/core/model/anak_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BabyGraphCard extends StatefulWidget {
  final AnakModel anak;
  const BabyGraphCard(this.anak, {super.key});

  @override
  State<BabyGraphCard> createState() => _BabyGraphCardState();
}

class _BabyGraphCardState extends State<BabyGraphCard> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: widget.anak.jenisKelamin == JenisKelamin.lakiLaki
            ? Palette.maleColor
            : Palette.femaleColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Grafik',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    SizedBox(
                      height: 56,
                      width: 56,
                      child: FittedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                          onPressed: () => {
                            setState(() {
                              _currentTab = (_currentTab - 1) % 4;
                            }),
                          },
                          child: const Icon(
                            LucideIcons.chevronLeft,
                            color: Palette.textPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: switch (_currentTab) {
                            0 => 'Berat Badan Menurut\nUmur (BB/U)',
                            1 => 'Tinggi Badan Menurut\nUmur (TB/U)',
                            2 => 'Berat Badan Menurut\nTinggi Badan (BB/TB)',
                            3 => 'Indeks Massa Tubuh\nMenurut Umur (IMT/U)',
                            _ => 'Error',
                          },
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            const TextSpan(
                              text: '\n9 kg / 2 Bulan 2 Hari',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 56,
                      width: 56,
                      child: FittedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                          onPressed: () => {
                            setState(() {
                              _currentTab = (_currentTab + 1) % 4;
                            }),
                          },
                          child: const Icon(
                            LucideIcons.chevronRight,
                            color: Palette.textPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 240,
                decoration: BoxDecoration(
                  color: Palette.backgroundPrimaryColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.only(
                  bottom: 2,
                  left: 2,
                  right: 16,
                  top: 16,
                ),
                child: LineChart(
                  transformationConfig: const FlTransformationConfig(
                    scaleAxis: FlScaleAxis.horizontal,
                  ),
                  LineChartData(
                    lineBarsData: [
                      ...Antropometri.generateGrafik(
                        jenisKelamin: JenisKelamin.lakiLaki,
                        usiaAwal: 12,
                        usiaAkhir: 18,
                      ),
                      LineChartBarData(
                        spots: [
                          const FlSpot(12, 8.6),
                          const FlSpot(13, 8.7),
                          const FlSpot(14, 9),
                          const FlSpot(15, 10),
                          const FlSpot(16, 10),
                          const FlSpot(17, 10),
                          const FlSpot(18, 10),
                        ],
                        isCurved: true,
                        color: Palette.textPrimaryColor,
                        dotData: const FlDotData(show: true),
                      ),
                    ],
                    lineTouchData: const LineTouchData(
                      handleBuiltInTouches: false,
                    ),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        axisNameWidget: const Text(
                          'Usia (Bulan)',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        sideTitles: SideTitles(
                          reservedSize: 15,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.round().toInt().toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Palette.textPrimaryColor,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        axisNameWidget: const Text(
                          'Berat Badan (kg)',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        sideTitles: SideTitles(
                          reservedSize: 15,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.round().toInt().toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Palette.textPrimaryColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Interpretasi:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                height: 72,
                decoration: BoxDecoration(
                  color: Palette.healthyBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Berat Badan Normal',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Penjelasan:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Palette.backgroundPrimaryColor.withAlpha(191),
                ),
                child: const Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Center(
                    child: Text(
                      'Bunda, berdasarkan pengukuran terakhir, berat badan si kecil sedikit di bawah rata-rata normal untuk usianya. Ini yang kita sebut dengan Gizi Kurang. Jangan khawatir berlebihan ya, Bunda, ini adalah tanda yang bisa segera kita tindak lanjuti agar si kecil bisa mencapai potensi optimalnya.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Palette.textPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
