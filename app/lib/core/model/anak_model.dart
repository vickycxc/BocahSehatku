import 'dart:convert';

import 'package:age_calculator/age_calculator.dart';
import 'package:app/core/utils.dart';

class AnakModel {
  final int id;
  final String nama;
  final DateTime tanggalLahir;
  final JenisKelamin jenisKelamin;
  late final DateDuration usia;
  late final String usiaInString;
  final String? nik;
  final double? bbLahir;
  final double? tbLahir;
  final int? mingguLahir;
  final int? orangTuaId;
  final DateTime createdAt;
  final DateTime updatedAt;

  AnakModel({
    required this.id,
    required this.nama,
    required this.tanggalLahir,
    required this.jenisKelamin,
    this.nik,
    this.bbLahir,
    this.tbLahir,
    this.mingguLahir,
    required this.orangTuaId,
    required this.createdAt,
    required this.updatedAt,
  }) {
    usia = AgeCalculator.age(tanggalLahir);
    usiaInString = usia.years > 0
        ? '${usia.years} Tahun ${usia.months} Bulan'
        : '${usia.months} Bulan ${usia.days} Hari';
  }

  AnakModel copyWith({
    int? id,
    String? nama,
    DateTime? tanggalLahir,
    JenisKelamin? jenisKelamin,
    String? nik,
    double? bbLahir,
    double? tbLahir,
    int? mingguLahir,
    int? orangTuaId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AnakModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      tanggalLahir: tanggalLahir ?? this.tanggalLahir,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      nik: nik ?? this.nik,
      bbLahir: bbLahir ?? this.bbLahir,
      tbLahir: tbLahir ?? this.tbLahir,
      mingguLahir: mingguLahir ?? this.mingguLahir,
      orangTuaId: orangTuaId ?? this.orangTuaId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'tanggalLahir': tanggalLahir.millisecondsSinceEpoch,
      'jenisKelamin': jenisKelamin == JenisKelamin.lakiLaki
          ? 'LAKI_LAKI'
          : 'PEREMPUAN',
      'nik': nik,
      'bbLahir': bbLahir,
      'tbLahir': tbLahir,
      'mingguLahir': mingguLahir,
      'orangTuaId': orangTuaId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory AnakModel.fromMap(Map<String, dynamic> map) {
    return AnakModel(
      id: map['id'] as int,
      nama: map['nama'] as String,
      tanggalLahir: DateTime.fromMillisecondsSinceEpoch(
        map['tanggalLahir'] as int,
      ),
      jenisKelamin: map['jenisKelamin'] == 'LAKI_LAKI'
          ? JenisKelamin.lakiLaki
          : JenisKelamin.perempuan,
      nik: map['nik'] != null ? map['nik'] as String : null,
      bbLahir: map['bbLahir'] != null ? map['bbLahir'] as double : null,
      tbLahir: map['tbLahir'] != null ? map['tbLahir'] as double : null,
      mingguLahir: map['mingguLahir'] != null
          ? map['mingguLahir'] as int
          : null,
      orangTuaId: map['orangTuaId'] != null ? map['orangTuaId'] as int : null,
      createdAt: DateTime.tryParse(map['createdAt'] as String)!,
      updatedAt: DateTime.tryParse(map['updatedAt'] as String)!,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnakModel.fromJson(String source) =>
      AnakModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BayiModel(id: $id, nama: $nama, tanggalLahir: $tanggalLahir, usia: $usia, $jenisKelamin, nik: $nik, bbLahir: $bbLahir, tbLahir: $tbLahir, mingguLahir: $mingguLahir, orangTuaId: $orangTuaId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant AnakModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nama == nama &&
        other.tanggalLahir == tanggalLahir &&
        other.usia == usia &&
        other.jenisKelamin == jenisKelamin &&
        other.nik == nik &&
        other.bbLahir == bbLahir &&
        other.tbLahir == tbLahir &&
        other.mingguLahir == mingguLahir &&
        other.orangTuaId == orangTuaId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nama.hashCode ^
        tanggalLahir.hashCode ^
        usia.hashCode ^
        jenisKelamin.hashCode ^
        nik.hashCode ^
        bbLahir.hashCode ^
        tbLahir.hashCode ^
        mingguLahir.hashCode ^
        orangTuaId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
