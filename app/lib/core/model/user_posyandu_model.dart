// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserPosyanduModel {
  final int id;
  final String kodePosyandu;
  final String namaPosyandu;
  final String kecamatan;
  final String puskesmas;
  final String desaKelurahan;
  final String alamat;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserPosyanduModel({
    required this.id,
    required this.kodePosyandu,
    required this.namaPosyandu,
    required this.kecamatan,
    required this.puskesmas,
    required this.desaKelurahan,
    required this.alamat,
    required this.createdAt,
    required this.updatedAt,
  });

  UserPosyanduModel copyWith({
    int? id,
    String? kodePosyandu,
    String? namaPosyandu,
    String? kecamatan,
    String? puskesmas,
    String? desaKelurahan,
    String? alamat,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
    String? message,
  }) {
    return UserPosyanduModel(
      id: id ?? this.id,
      kodePosyandu: kodePosyandu ?? this.kodePosyandu,
      namaPosyandu: namaPosyandu ?? this.namaPosyandu,
      kecamatan: kecamatan ?? this.kecamatan,
      puskesmas: puskesmas ?? this.puskesmas,
      desaKelurahan: desaKelurahan ?? this.desaKelurahan,
      alamat: alamat ?? this.alamat,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'kodePosyandu': kodePosyandu,
      'namaPosyandu': namaPosyandu,
      'kecamatan': kecamatan,
      'puskesmas': puskesmas,
      'desaKelurahan': desaKelurahan,
      'alamat': alamat,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserPosyanduModel.fromMap(Map<String, dynamic> map) {
    return UserPosyanduModel(
      id: map['id'] as int,
      kodePosyandu: map['kodePosyandu'] as String,
      namaPosyandu: map['namaPosyandu'] as String,
      kecamatan: map['kecamatan'] as String,
      puskesmas: map['puskesmas'] as String,
      desaKelurahan: map['desaKelurahan'] as String,
      alamat: map['alamat'] as String,
      createdAt: DateTime.tryParse(map['createdAt'] as String)!,
      updatedAt: DateTime.tryParse(map['updatedAt'] as String)!,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPosyanduModel.fromJson(String source) =>
      UserPosyanduModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserPosyanduModel(id: $id, kodePosyandu: $kodePosyandu, namaPosyandu: $namaPosyandu, kecamatan: $kecamatan, puskesmas: $puskesmas, desaKelurahan: $desaKelurahan, alamat: $alamat, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserPosyanduModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.kodePosyandu == kodePosyandu &&
        other.namaPosyandu == namaPosyandu &&
        other.kecamatan == kecamatan &&
        other.puskesmas == puskesmas &&
        other.desaKelurahan == desaKelurahan &&
        other.alamat == alamat &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        kodePosyandu.hashCode ^
        namaPosyandu.hashCode ^
        kecamatan.hashCode ^
        puskesmas.hashCode ^
        desaKelurahan.hashCode ^
        alamat.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
