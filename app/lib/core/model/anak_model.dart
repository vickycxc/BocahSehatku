// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:age_calculator/age_calculator.dart';
import 'package:app/core/model/orang_tua_model.dart';
import 'package:app/core/model/pengukuran_model.dart';
import 'package:app/core/utils/utils.dart';
import 'package:collection/collection.dart';

class AnakModel {
  final int localId;
  final int serverId;
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
  final OrangTuaModel? orangTua;
  final List<PengukuranModel>? pengukuran;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  AnakModel({
    required this.localId,
    required this.serverId,
    required this.nama,
    required this.tanggalLahir,
    required this.jenisKelamin,
    this.nik,
    this.bbLahir,
    this.tbLahir,
    this.mingguLahir,
    this.orangTuaId,
    this.orangTua,
    this.pengukuran,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  }) {
    usia = AgeCalculator.age(tanggalLahir);
    usiaInString = usia.years > 0
        ? '${usia.years} Tahun ${usia.months} Bulan'
        : '${usia.months} Bulan ${usia.days} Hari';
  }

  AnakModel copyWith({
    int? localId,
    int? serverId,
    String? nama,
    DateTime? tanggalLahir,
    JenisKelamin? jenisKelamin,
    String? nik,
    double? bbLahir,
    double? tbLahir,
    int? mingguLahir,
    int? orangTuaId,
    OrangTuaModel? orangTua,
    List<PengukuranModel>? pengukuran,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return AnakModel(
      localId: localId ?? this.localId,
      serverId: serverId ?? this.serverId,
      nama: nama ?? this.nama,
      tanggalLahir: tanggalLahir ?? this.tanggalLahir,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      nik: nik ?? this.nik,
      bbLahir: bbLahir ?? this.bbLahir,
      tbLahir: tbLahir ?? this.tbLahir,
      mingguLahir: mingguLahir ?? this.mingguLahir,
      orangTuaId: orangTuaId ?? this.orangTuaId,
      orangTua: orangTua ?? this.orangTua,
      pengukuran: pengukuran ?? this.pengukuran,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final jenisKelaminString = switch (jenisKelamin) {
      JenisKelamin.lakiLaki => 'LAKI_LAKI',
      JenisKelamin.perempuan => 'PEREMPUAN',
    };
    return <String, dynamic>{
      'localId': localId,
      'serverId': serverId,
      'nama': nama,
      'tanggalLahir': tanggalLahir.toIso8601String(),
      'jenisKelamin': jenisKelaminString,
      'nik': nik,
      'bbLahir': bbLahir,
      'tbLahir': tbLahir,
      'mingguLahir': mingguLahir,
      'orangTuaId': orangTuaId,
      'orangTua': orangTua?.toMap(),
      'pengukuran': pengukuran?.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  factory AnakModel.fromMap(Map<String, dynamic> map) {
    final jenisKelamin = switch (map['jenisKelamin']) {
      'LAKI_LAKI' => JenisKelamin.lakiLaki,
      'PEREMPUAN' => JenisKelamin.perempuan,
      _ => throw Exception('Jenis Kelamin tidak valid'),
    };
    return AnakModel(
      localId: map['localId'] as int,
      serverId: map['serverId'] as int,
      nama: map['nama'] as String,
      tanggalLahir: DateTime.tryParse(map['tanggalLahir'] as String)!,
      jenisKelamin: jenisKelamin,
      nik: map['nik'] != null ? map['nik'] as String : null,
      bbLahir: map['bbLahir'] != null ? map['bbLahir'] as double : null,
      tbLahir: map['tbLahir'] != null ? map['tbLahir'] as double : null,
      mingguLahir: map['mingguLahir'] != null
          ? map['mingguLahir'] as int
          : null,
      orangTuaId: map['orangTuaId'] != null ? map['orangTuaId'] as int : null,
      orangTua: map['orangTua'] != null
          ? OrangTuaModel.fromMap(map['orangTua'] as Map<String, dynamic>)
          : null,
      pengukuran: map['pengukuran'] != null
          ? List<PengukuranModel>.from(
              (map['pengukuran'] as List<int>).map<PengukuranModel?>(
                (x) => PengukuranModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      createdAt: DateTime.tryParse(map['createdAt'] as String)!,
      updatedAt: DateTime.tryParse(map['updatedAt'] as String)!,
      deletedAt: map['deletedAt'] != null
          ? DateTime.tryParse(map['deletedAt'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnakModel.fromJson(String source) =>
      AnakModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnakModel(localId: $localId, serverId: $serverId, nama: $nama, tanggalLahir: $tanggalLahir, jenisKelamin: $jenisKelamin, usia: $usia, usiaInString: $usiaInString, nik: $nik, bbLahir: $bbLahir, tbLahir: $tbLahir, mingguLahir: $mingguLahir, orangTuaId: $orangTuaId, orangTua: $orangTua, pengukuran: $pengukuran, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(covariant AnakModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.localId == localId &&
        other.serverId == serverId &&
        other.nama == nama &&
        other.tanggalLahir == tanggalLahir &&
        other.jenisKelamin == jenisKelamin &&
        other.usia == usia &&
        other.usiaInString == usiaInString &&
        other.nik == nik &&
        other.bbLahir == bbLahir &&
        other.tbLahir == tbLahir &&
        other.mingguLahir == mingguLahir &&
        other.orangTuaId == orangTuaId &&
        other.orangTua == orangTua &&
        listEquals(other.pengukuran, pengukuran) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return localId.hashCode ^
        serverId.hashCode ^
        nama.hashCode ^
        tanggalLahir.hashCode ^
        jenisKelamin.hashCode ^
        usia.hashCode ^
        usiaInString.hashCode ^
        nik.hashCode ^
        bbLahir.hashCode ^
        tbLahir.hashCode ^
        mingguLahir.hashCode ^
        orangTuaId.hashCode ^
        orangTua.hashCode ^
        pengukuran.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode;
  }
}
