// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrangTuaModel {
  final int id;
  final String noHp;
  final String? nama;
  final String? nik;
  final String? jenisKelamin;
  final String? alamat;
  final int? posyanduId;
  final DateTime createdAt;
  final DateTime updatedAt;
  OrangTuaModel({
    required this.id,
    required this.noHp,
    this.nama,
    this.nik,
    this.jenisKelamin,
    this.alamat,
    this.posyanduId,
    required this.createdAt,
    required this.updatedAt,
  });

  OrangTuaModel copyWith({
    int? id,
    String? noHp,
    String? nama,
    String? nik,
    String? jenisKelamin,
    String? alamat,
    int? posyanduId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
    String? message,
  }) {
    return OrangTuaModel(
      id: id ?? this.id,
      noHp: noHp ?? this.noHp,
      nama: nama ?? this.nama,
      nik: nik ?? this.nik,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      alamat: alamat ?? this.alamat,
      posyanduId: posyanduId ?? this.posyanduId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'noHp': noHp,
      'nama': nama,
      'nik': nik,
      'jenisKelamin': jenisKelamin,
      'alamat': alamat,
      'posyanduId': posyanduId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory OrangTuaModel.fromMap(Map<String, dynamic> map) {
    return OrangTuaModel(
      id: map['id'] as int,
      noHp: map['noHp'] as String,
      nama: map['nama'] != null ? map['nama'] as String : null,
      nik: map['nik'] != null ? map['nik'] as String : null,
      jenisKelamin: map['jenisKelamin'] != null
          ? map['jenisKelamin'] as String
          : null,
      alamat: map['alamat'] != null ? map['alamat'] as String : null,
      posyanduId: map['posyanduId'] != null ? map['posyanduId'] as int : null,
      createdAt: DateTime.tryParse(map['createdAt'] as String)!,
      updatedAt: DateTime.tryParse(map['updatedAt'] as String)!,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrangTuaModel.fromJson(String source) =>
      OrangTuaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserOrangTuaModel(id: $id, noHp: $noHp, nama: $nama, nik: $nik, jenisKelamin: $jenisKelamin, alamat: $alamat, posyanduId: $posyanduId, createdAt: $createdAt, updatedAt: $updatedAt)';
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
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
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
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
