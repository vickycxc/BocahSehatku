import 'package:app/core/antropometri/data_antropometri_laki_laki.dart';
import 'package:app/core/antropometri/data_antropometri_perempuan.dart';
import 'package:app/core/theme/palette.dart';
import 'package:app/core/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';

class Antropometri {
  static List<FlSpot> generateGrafikBeratBadanPerUmur({
    required ZScore zScore,
    required JenisKelamin jenisKelamin,
    required int usiaAwal,
    required int usiaAkhir,
  }) {
    List<FlSpot> spots = [];
    Map<int, Map<ZScore, double>> selectedRange =
        (jenisKelamin == JenisKelamin.lakiLaki)
        ? Map.fromEntries(
            DataAntropometriLakiLaki.beratBadanPerUmur.entries.where(
              (entry) => entry.key >= usiaAwal && entry.key <= usiaAkhir,
            ),
          )
        : Map.fromEntries(
            DataAntropometriPerempuan.beratBadanPerUmur.entries.where(
              (entry) => entry.key >= usiaAwal && entry.key <= usiaAkhir,
            ),
          );

    selectedRange.forEach(
      (key, value) => spots.add(FlSpot(key.toDouble(), value[zScore]!)),
    );
    return spots;
  }

  static List<FlSpot> generateGrafikTinggiBadanPerUmur({
    required ZScore zScore,
    required JenisKelamin jenisKelamin,
    required RentangUsia rentangUsia,
    required int usiaAwal,
    required int usiaAkhir,
  }) {
    List<FlSpot> spots = [];

    Map<int, Map<ZScore, double>> selectedRange;

    if (rentangUsia == RentangUsia.usia0_24Bulan) {
      selectedRange = (jenisKelamin == JenisKelamin.lakiLaki)
          ? Map.fromEntries(
              DataAntropometriLakiLaki.tinggiBadanPerUmur1.entries.where(
                (entry) => entry.key >= usiaAwal && entry.key <= usiaAkhir,
              ),
            )
          : Map.fromEntries(
              DataAntropometriPerempuan.tinggiBadanPerUmur1.entries.where(
                (entry) => entry.key >= usiaAwal && entry.key <= usiaAkhir,
              ),
            );
    } else {
      selectedRange = (jenisKelamin == JenisKelamin.lakiLaki)
          ? Map.fromEntries(
              DataAntropometriLakiLaki.tinggiBadanPerUmur2.entries.where(
                (entry) => entry.key >= usiaAwal && entry.key <= usiaAkhir,
              ),
            )
          : Map.fromEntries(
              DataAntropometriPerempuan.tinggiBadanPerUmur2.entries.where(
                (entry) => entry.key >= usiaAwal && entry.key <= usiaAkhir,
              ),
            );
    }

    selectedRange.forEach(
      (key, value) => spots.add(FlSpot(key.toDouble(), value[zScore]!)),
    );
    return spots;
  }

  static List<FlSpot> generateGrafikBeratBadanPerTinggiBadan({
    required ZScore zScore,
    required JenisKelamin jenisKelamin,
    required RentangUsia rentangUsia,
    required double bbAwal,
    required double bbAkhir,
  }) {
    List<FlSpot> spots = [];

    Map<double, Map<ZScore, double>> selectedRange;

    if (rentangUsia == RentangUsia.usia0_24Bulan) {
      selectedRange = (jenisKelamin == JenisKelamin.lakiLaki)
          ? Map.fromEntries(
              DataAntropometriLakiLaki.beratBadanPerTinggiBadan1.entries.where(
                (entry) => entry.key >= bbAwal && entry.key <= bbAkhir,
              ),
            )
          : Map.fromEntries(
              DataAntropometriPerempuan.beratBadanPerTinggiBadan1.entries.where(
                (entry) => entry.key >= bbAwal && entry.key <= bbAkhir,
              ),
            );
    } else {
      selectedRange = (jenisKelamin == JenisKelamin.lakiLaki)
          ? Map.fromEntries(
              DataAntropometriLakiLaki.beratBadanPerTinggiBadan2.entries.where(
                (entry) => entry.key >= bbAwal && entry.key <= bbAkhir,
              ),
            )
          : Map.fromEntries(
              DataAntropometriPerempuan.beratBadanPerTinggiBadan2.entries.where(
                (entry) => entry.key >= bbAwal && entry.key <= bbAkhir,
              ),
            );
    }

    selectedRange.forEach(
      (key, value) => spots.add(FlSpot(key.toDouble(), value[zScore]!)),
    );
    return spots;
  }

  static List<FlSpot> generateGrafikIMTPerUmur({
    required ZScore zScore,
    required JenisKelamin jenisKelamin,
    required RentangUsia rentangUsia,
    required int usiaAwal,
    required int usiaAkhir,
  }) {
    List<FlSpot> spots = [];

    Map<int, Map<ZScore, double>> selectedRange;

    if (rentangUsia == RentangUsia.usia0_24Bulan) {
      selectedRange = (jenisKelamin == JenisKelamin.lakiLaki)
          ? Map.fromEntries(
              DataAntropometriLakiLaki.imtPerUmur1.entries.where(
                (entry) => entry.key >= usiaAwal && entry.key <= usiaAkhir,
              ),
            )
          : Map.fromEntries(
              DataAntropometriPerempuan.imtPerUmur1.entries.where(
                (entry) => entry.key >= usiaAwal && entry.key <= usiaAkhir,
              ),
            );
    } else {
      selectedRange = (jenisKelamin == JenisKelamin.lakiLaki)
          ? Map.fromEntries(
              DataAntropometriLakiLaki.imtPerUmur2.entries.where(
                (entry) => entry.key >= usiaAwal && entry.key <= usiaAkhir,
              ),
            )
          : Map.fromEntries(
              DataAntropometriPerempuan.imtPerUmur2.entries.where(
                (entry) => entry.key >= usiaAwal && entry.key <= usiaAkhir,
              ),
            );
    }

    selectedRange.forEach(
      (key, value) => spots.add(FlSpot(key.toDouble(), value[zScore]!)),
    );
    return spots;
  }

  static List<LineChartBarData> generateGrafik({
    required JenisKelamin jenisKelamin,
    required int usiaAwal,
    required int usiaAkhir,
  }) {
    List<LineChartBarData> data = [];
    List<ZScore> zScores = [
      ZScore.plus3,
      ZScore.plus2,
      ZScore.plus1,
      ZScore.minus1,
      ZScore.minus2,
      ZScore.minus3,
    ];

    for (final zScore in zScores) {
      List<FlSpot> spots = generateGrafikBeratBadanPerUmur(
        zScore: zScore,
        jenisKelamin: jenisKelamin,
        usiaAwal: usiaAwal,
        usiaAkhir: usiaAkhir,
      );

      final lineColor = switch (zScore) {
        ZScore.minus3 => Palette.graphZScore3Color,
        ZScore.minus2 => Palette.graphZScore2Color,
        ZScore.minus1 => Palette.graphZScore1Color,
        ZScore.plus1 => Palette.graphZScore1Color,
        ZScore.plus2 => Palette.graphZScore2Color,
        ZScore.plus3 => Palette.graphZScore3Color,
        _ => null,
      };

      final backgroundColor = switch (zScore) {
        ZScore.minus3 => Palette.backgroundPrimaryColor,
        ZScore.minus2 => Palette.graphZScore2BackgroundColor,
        ZScore.minus1 => Palette.graphZScore1BackgroundColor,
        ZScore.plus1 => Palette.graphZScore0BackgroundColor,
        ZScore.plus2 => Palette.graphZScore1BackgroundColor,
        ZScore.plus3 => Palette.graphZScore2BackgroundColor,
        _ => null,
      };

      data.add(
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: lineColor,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: true, color: backgroundColor),
          aboveBarData: (zScore == ZScore.plus3)
              ? BarAreaData(show: true, color: Palette.backgroundPrimaryColor)
              : null,
        ),
      );
    }

    return data;
  }
}
