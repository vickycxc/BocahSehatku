// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/core/utils/utils.dart';

class PengukuranModel {
  final int localId;
  final int? serverId;
  final int anakId;
  final int posyanduId;
  final DateTime tanggalPengukuran;
  final double beratBadan;
  final double tinggiBadan;
  final double imt;
  final KategoriBBU kategoriBBU;
  final KategoriTBU kategoriTBU;
  final KategoriBBTB kategoriBBTB;
  final KategoriIMTU kategoriIMTU;
  final String statusPertumbuhan;
  final String rekomendasiOrtu;
  final String rekomendasiKader;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  PengukuranModel({
    required this.localId,
    this.serverId,
    required this.anakId,
    required this.posyanduId,
    required this.tanggalPengukuran,
    required this.beratBadan,
    required this.tinggiBadan,
    required this.imt,
    required this.kategoriBBU,
    required this.kategoriTBU,
    required this.kategoriBBTB,
    required this.kategoriIMTU,
    required this.statusPertumbuhan,
    required this.rekomendasiOrtu,
    required this.rekomendasiKader,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  PengukuranModel copyWith({
    int? localId,
    int? serverId,
    int? anakId,
    int? posyanduId,
    DateTime? tanggalPengukuran,
    double? beratBadan,
    double? tinggiBadan,
    double? imt,
    KategoriBBU? kategoriBBU,
    KategoriTBU? kategoriTBU,
    KategoriBBTB? kategoriBBTB,
    KategoriIMTU? kategoriIMTU,
    String? statusPertumbuhan,
    String? rekomendasiOrtu,
    String? rekomendasiKader,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return PengukuranModel(
      localId: localId ?? this.localId,
      serverId: serverId ?? this.serverId,
      anakId: anakId ?? this.anakId,
      posyanduId: posyanduId ?? this.posyanduId,
      tanggalPengukuran: tanggalPengukuran ?? this.tanggalPengukuran,
      beratBadan: beratBadan ?? this.beratBadan,
      tinggiBadan: tinggiBadan ?? this.tinggiBadan,
      imt: imt ?? this.imt,
      kategoriBBU: kategoriBBU ?? this.kategoriBBU,
      kategoriTBU: kategoriTBU ?? this.kategoriTBU,
      kategoriBBTB: kategoriBBTB ?? this.kategoriBBTB,
      kategoriIMTU: kategoriIMTU ?? this.kategoriIMTU,
      statusPertumbuhan: statusPertumbuhan ?? this.statusPertumbuhan,
      rekomendasiOrtu: rekomendasiOrtu ?? this.rekomendasiOrtu,
      rekomendasiKader: rekomendasiKader ?? this.rekomendasiKader,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final kategoriBBUString = switch (kategoriBBU) {
      KategoriBBU.sangatKurang => 'SANGAT_KURANG',
      KategoriBBU.kurang => 'KURANG',
      KategoriBBU.normal => 'NORMAL',
      KategoriBBU.lebih => 'LEBIH',
    };
    final kategoriTBUString = switch (kategoriTBU) {
      KategoriTBU.sangatPendek => 'SANGAT_PENDEK',
      KategoriTBU.pendek => 'PENDEK',
      KategoriTBU.normal => 'NORMAL',
      KategoriTBU.tinggi => 'TINGGI',
    };
    final kategoriBBTBString = switch (kategoriBBTB) {
      KategoriBBTB.giziBuruk => 'GIZI_BURUK',
      KategoriBBTB.giziKurang => 'GIZI_KURANG',
      KategoriBBTB.giziBaik => 'GIZI_BAIK',
      KategoriBBTB.berisikoGiziLebih => 'BERISIKO_GIZI_LEBIH',
      KategoriBBTB.giziLebih => 'GIZI_LEBIH',
      KategoriBBTB.obesitas => 'OBESITAS',
    };
    final kategoriIMTUString = switch (kategoriIMTU) {
      KategoriIMTU.giziBuruk => 'GIZI_BURUK',
      KategoriIMTU.giziKurang => 'GIZI_KURANG',
      KategoriIMTU.giziBaik => 'GIZI_BAIK',
      KategoriIMTU.berisikoGiziLebih => 'BERISIKO_GIZI_LEBIH',
      KategoriIMTU.giziLebih => 'GIZI_LEBIH',
      KategoriIMTU.obesitas => 'OBESITAS',
    };
    return <String, dynamic>{
      'localId': localId,
      'serverId': serverId,
      'anakId': anakId,
      'posyanduId': posyanduId,
      'tanggalPengukuran': tanggalPengukuran.millisecondsSinceEpoch,
      'beratBadan': beratBadan,
      'tinggiBadan': tinggiBadan,
      'imt': imt,
      'kategoriBBU': kategoriBBUString,
      'kategoriTBU': kategoriTBUString,
      'kategoriBBTB': kategoriBBTBString,
      'kategoriIMTU': kategoriIMTUString,
      'statusPertumbuhan': statusPertumbuhan,
      'rekomendasiOrtu': rekomendasiOrtu,
      'rekomendasiKader': rekomendasiKader,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  factory PengukuranModel.fromMap(Map<String, dynamic> map) {
    final kategoriBBU = switch (map['kategoriBBU']) {
      'SANGAT_KURANG' => KategoriBBU.sangatKurang,
      'KURANG' => KategoriBBU.kurang,
      'NORMAL' => KategoriBBU.normal,
      'LEBIH' => KategoriBBU.lebih,
      _ => throw Exception('Invalid kategoriBBU value'),
    };
    final kategoriTBU = switch (map['kategoriTBU']) {
      'SANGAT_PENDEK' => KategoriTBU.sangatPendek,
      'PENDEK' => KategoriTBU.pendek,
      'NORMAL' => KategoriTBU.normal,
      'TINGGI' => KategoriTBU.tinggi,
      _ => throw Exception('Invalid kategoriTBU value'),
    };
    final kategoriBBTB = switch (map['kategoriBBTB']) {
      'GIZI_BURUK' => KategoriBBTB.giziBuruk,
      'GIZI_KURANG' => KategoriBBTB.giziKurang,
      'GIZI_BAIK' => KategoriBBTB.giziBaik,
      'BERISIKO_GIZI_LEBIH' => KategoriBBTB.berisikoGiziLebih,
      'GIZI_LEBIH' => KategoriBBTB.giziLebih,
      'OBESITAS' => KategoriBBTB.obesitas,
      _ => throw Exception('Invalid kategoriBBTB value'),
    };
    final kategoriIMTU = switch (map['kategoriIMTU']) {
      'GIZI_BURUK' => KategoriIMTU.giziBuruk,
      'GIZI_KURANG' => KategoriIMTU.giziKurang,
      'GIZI_BAIK' => KategoriIMTU.giziBaik,
      'BERISIKO_GIZI_LEBIH' => KategoriIMTU.berisikoGiziLebih,
      'GIZI_LEBIH' => KategoriIMTU.giziLebih,
      'OBESITAS' => KategoriIMTU.obesitas,
      _ => throw Exception('Invalid kategoriIMTU value'),
    };
    return PengukuranModel(
      localId: map['localId'] as int,
      serverId: map['serverId'] != null ? map['serverId'] as int : null,
      anakId: map['anakId'] as int,
      posyanduId: map['posyanduId'] as int,
      tanggalPengukuran: DateTime.tryParse(map['tanggalPengukuran'] as String)!,
      beratBadan: map['beratBadan'] as double,
      tinggiBadan: map['tinggiBadan'] as double,
      imt: map['imt'] as double,
      kategoriBBU: kategoriBBU,
      kategoriTBU: kategoriTBU,
      kategoriBBTB: kategoriBBTB,
      kategoriIMTU: kategoriIMTU,
      statusPertumbuhan: map['statusPertumbuhan'] as String,
      rekomendasiOrtu: map['rekomendasiOrtu'] as String,
      rekomendasiKader: map['rekomendasiKader'] as String,
      createdAt: DateTime.tryParse(map['createdAt'] as String)!,
      updatedAt: DateTime.tryParse(map['updatedAt'] as String)!,
      deletedAt: map['deletedAt'] != null
          ? DateTime.tryParse(map['deletedAt'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PengukuranModel.fromJson(String source) =>
      PengukuranModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PengukuranModel(localId: $localId, serverId: $serverId, anakId: $anakId, posyanduId: $posyanduId, tanggalPengukuran: $tanggalPengukuran, beratBadan: $beratBadan, tinggiBadan: $tinggiBadan, imt: $imt, kategoriBBU: $kategoriBBU, kategoriTBU: $kategoriTBU, kategoriBBTB: $kategoriBBTB, kategoriIMTU: $kategoriIMTU, statusPertumbuhan: $statusPertumbuhan, rekomendasiOrtu: $rekomendasiOrtu, rekomendasiKader: $rekomendasiKader, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(covariant PengukuranModel other) {
    if (identical(this, other)) return true;

    return other.localId == localId &&
        other.serverId == serverId &&
        other.anakId == anakId &&
        other.posyanduId == posyanduId &&
        other.tanggalPengukuran == tanggalPengukuran &&
        other.beratBadan == beratBadan &&
        other.tinggiBadan == tinggiBadan &&
        other.imt == imt &&
        other.kategoriBBU == kategoriBBU &&
        other.kategoriTBU == kategoriTBU &&
        other.kategoriBBTB == kategoriBBTB &&
        other.kategoriIMTU == kategoriIMTU &&
        other.statusPertumbuhan == statusPertumbuhan &&
        other.rekomendasiOrtu == rekomendasiOrtu &&
        other.rekomendasiKader == rekomendasiKader &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return localId.hashCode ^
        serverId.hashCode ^
        anakId.hashCode ^
        posyanduId.hashCode ^
        tanggalPengukuran.hashCode ^
        beratBadan.hashCode ^
        tinggiBadan.hashCode ^
        imt.hashCode ^
        kategoriBBU.hashCode ^
        kategoriTBU.hashCode ^
        kategoriBBTB.hashCode ^
        kategoriIMTU.hashCode ^
        statusPertumbuhan.hashCode ^
        rekomendasiOrtu.hashCode ^
        rekomendasiKader.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode;
  }
}
