// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/core/model/orang_tua_model.dart';
import 'package:app/core/model/posyandu_model.dart';

class PengajuanVerifikasiModel {
  final int id;
  final OrangTuaModel orangTua;
  final PosyanduModel posyandu;
  final String noHpBaru;
  final DateTime createdAt;
  PengajuanVerifikasiModel({
    required this.id,
    required this.orangTua,
    required this.posyandu,
    required this.noHpBaru,
    required this.createdAt,
  });

  PengajuanVerifikasiModel copyWith({
    int? id,
    OrangTuaModel? orangTua,
    PosyanduModel? posyandu,
    String? noHpBaru,
    DateTime? createdAt,
  }) {
    return PengajuanVerifikasiModel(
      id: id ?? this.id,
      orangTua: orangTua ?? this.orangTua,
      posyandu: posyandu ?? this.posyandu,
      noHpBaru: noHpBaru ?? this.noHpBaru,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orangTua': orangTua.toMap(),
      'posyandu': posyandu.toMap(),
      'noHpBaru': noHpBaru,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PengajuanVerifikasiModel.fromMap(Map<String, dynamic> map) {
    return PengajuanVerifikasiModel(
      id: map['id'] as int,
      orangTua: OrangTuaModel.fromMap(map['orangTua'] as Map<String, dynamic>),
      posyandu: PosyanduModel.fromMap(map['posyandu'] as Map<String, dynamic>),
      noHpBaru: map['noHpBaru'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PengajuanVerifikasiModel.fromJson(String source) =>
      PengajuanVerifikasiModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'VerifikasiAkunModel(id: $id, orangTua: $orangTua, posyandu: $posyandu, noHpBaru: $noHpBaru, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant PengajuanVerifikasiModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orangTua == orangTua &&
        other.posyandu == posyandu &&
        other.noHpBaru == noHpBaru &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orangTua.hashCode ^
        posyandu.hashCode ^
        noHpBaru.hashCode ^
        createdAt.hashCode;
  }
}
