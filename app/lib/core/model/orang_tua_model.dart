// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/core/constants/database_constants/orang_tua_table.dart';
import 'package:app/core/utils/utils.dart';

class OrangTuaModel {
  final int? id;
  final String noHp;
  final String? nama;
  final String? nik;
  final JenisKelamin? jenisKelamin;
  final String? alamat;
  final int? posyanduId;
  final String? namaPosyandu;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  OrangTuaModel({
    this.id,
    required this.noHp,
    this.nama,
    this.nik,
    this.jenisKelamin,
    this.alamat,
    this.posyanduId,
    this.namaPosyandu,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  OrangTuaModel copyWith({
    int? id,
    String? noHp,
    String? nama,
    String? nik,
    JenisKelamin? jenisKelamin,
    String? alamat,
    int? posyanduId,
    String? namaPosyandu,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return OrangTuaModel(
      id: id ?? this.id,
      noHp: noHp ?? this.noHp,
      nama: nama ?? this.nama,
      nik: nik ?? this.nik,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      alamat: alamat ?? this.alamat,
      posyanduId: posyanduId ?? this.posyanduId,
      namaPosyandu: namaPosyandu ?? this.namaPosyandu,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final jenisKelaminString = jenisKelamin != null
        ? switch (jenisKelamin!) {
            JenisKelamin.lakiLaki => 'LAKI_LAKI',
            JenisKelamin.perempuan => 'PEREMPUAN',
          }
        : null;
    final map = {
      'id': id,
      'noHp': noHp,
      'nama': nama,
      'nik': nik,
      'jenisKelamin': jenisKelaminString,
      'alamat': alamat,
      'posyanduId': posyanduId,
      'namaPosyandu': namaPosyandu,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'deletedAt': deletedAt?.millisecondsSinceEpoch,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory OrangTuaModel.fromMap(Map<String, dynamic> map) {
    final jenisKelamin = map['jenisKelamin'] != null
        ? switch (map['jenisKelamin']) {
            'LAKI_LAKI' => JenisKelamin.lakiLaki,
            'PEREMPUAN' => JenisKelamin.perempuan,
            _ => throw Exception('Jenis Kelamin tidak valid'),
          }
        : null;

    String? nama;
    if (map[OrangTuaTable.namaColumnNameAlias] != null) {
      nama = map[OrangTuaTable.namaColumnNameAlias] as String;
    } else if (map['nama'] != null) {
      nama = map['nama'] as String;
    }

    String? namaPosyandu;

    if (map['posyandu'] != null) {
      namaPosyandu = map['posyandu']['namaPosyandu'] as String;
    }
    if (map['namaPosyandu'] != null) {
      namaPosyandu = map['namaPosyandu'] as String;
    }
    return OrangTuaModel(
      id: map['id'] != null ? map['id'] as int : null,
      noHp: map['noHp'] as String,
      nama: nama,
      nik: map['nik'] != null ? map['nik'] as String : null,
      jenisKelamin: jenisKelamin,
      alamat: map['alamat'] != null ? map['alamat'] as String : null,
      posyanduId: map['posyanduId'] != null ? map['posyanduId'] as int : null,
      namaPosyandu: namaPosyandu,
      createdAt: map['createdAt'] != null
          ? map['createdAt'] is String
                ? DateTime.parse(map['createdAt'] as String)
                : DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? map['updatedAt'] is String
                ? DateTime.parse(map['updatedAt'] as String)
                : DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      deletedAt: map['deletedAt'] != null
          ? map['deletedAt'] is String
                ? DateTime.parse(map['deletedAt'] as String)
                : DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrangTuaModel.fromJson(String source) =>
      OrangTuaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrangTuaModel(id: $id, noHp: $noHp, nama: $nama, nik: $nik, jenisKelamin: $jenisKelamin, alamat: $alamat, posyanduId: $posyanduId, namaPosyandu: $namaPosyandu, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(covariant OrangTuaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.noHp == noHp &&
        other.nama == nama &&
        other.nik == nik &&
        other.jenisKelamin == jenisKelamin &&
        other.alamat == alamat &&
        other.posyanduId == posyanduId &&
        other.namaPosyandu == namaPosyandu &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        noHp.hashCode ^
        nama.hashCode ^
        nik.hashCode ^
        jenisKelamin.hashCode ^
        alamat.hashCode ^
        posyanduId.hashCode ^
        namaPosyandu.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode;
  }
}
