// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/core/model/anak_model.dart';
import 'package:app/core/utils/utils.dart';

class PengukuranModel {
  final int? localId;
  final int? serverId;
  final int anakId;
  final AnakModel? anak;
  final String? namaPosyandu;
  final int? posyanduId;
  final DateTime tanggalPengukuran;
  final double beratBadan;
  final double tinggiBadan;
  final double? imt;
  final KategoriBBU? kategoriBBU;
  final KategoriTBU? kategoriTBU;
  final KategoriBBTB? kategoriBBTB;
  final KategoriIMTU? kategoriIMTU;
  final String statusPertumbuhan;
  final StatusPengukuran statusPengukuranPertumbuhan;
  final String? penilaianTren;
  final StatusPengukuran? statusPengukuranTren;
  final String? rekomendasiOrtu;
  final String? rekomendasiKader;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  PengukuranModel({
    this.localId,
    this.serverId,
    required this.anakId,
    this.anak,
    this.namaPosyandu,
    this.posyanduId,
    required this.tanggalPengukuran,
    required this.beratBadan,
    required this.tinggiBadan,
    this.imt,
    this.kategoriBBU,
    this.kategoriTBU,
    this.kategoriBBTB,
    this.kategoriIMTU,
    required this.statusPertumbuhan,
    required this.statusPengukuranPertumbuhan,
    this.penilaianTren,
    this.statusPengukuranTren,
    this.rekomendasiOrtu,
    this.rekomendasiKader,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  PengukuranModel copyWith({
    int? localId,
    int? serverId,
    int? anakId,
    AnakModel? anak,
    String? namaPosyandu,
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
    StatusPengukuran? statusPengukuranPertumbuhan,
    String? penilaianTren,
    StatusPengukuran? statusPengukuranTren,
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
      anak: anak ?? this.anak,
      namaPosyandu: namaPosyandu ?? this.namaPosyandu,
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
      statusPengukuranPertumbuhan:
          statusPengukuranPertumbuhan ?? this.statusPengukuranPertumbuhan,
      penilaianTren: penilaianTren ?? this.penilaianTren,
      statusPengukuranTren: statusPengukuranTren ?? this.statusPengukuranTren,
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
      _ => null,
    };
    final kategoriTBUString = switch (kategoriTBU) {
      KategoriTBU.sangatPendek => 'SANGAT_PENDEK',
      KategoriTBU.pendek => 'PENDEK',
      KategoriTBU.normal => 'NORMAL',
      KategoriTBU.tinggi => 'TINGGI',
      _ => null,
    };
    final kategoriBBTBString = switch (kategoriBBTB) {
      KategoriBBTB.giziBuruk => 'GIZI_BURUK',
      KategoriBBTB.giziKurang => 'GIZI_KURANG',
      KategoriBBTB.giziBaik => 'GIZI_BAIK',
      KategoriBBTB.berisikoGiziLebih => 'BERISIKO_GIZI_LEBIH',
      KategoriBBTB.giziLebih => 'GIZI_LEBIH',
      KategoriBBTB.obesitas => 'OBESITAS',
      _ => null,
    };
    final kategoriIMTUString = switch (kategoriIMTU) {
      KategoriIMTU.giziBuruk => 'GIZI_BURUK',
      KategoriIMTU.giziKurang => 'GIZI_KURANG',
      KategoriIMTU.giziBaik => 'GIZI_BAIK',
      KategoriIMTU.berisikoGiziLebih => 'BERISIKO_GIZI_LEBIH',
      KategoriIMTU.giziLebih => 'GIZI_LEBIH',
      KategoriIMTU.obesitas => 'OBESITAS',
      _ => null,
    };
    final statusPengukuranPertumbuhanString =
        switch (statusPengukuranPertumbuhan) {
          StatusPengukuran.sehat => 'SEHAT',
          StatusPengukuran.kurangSehat => 'KURANG_SEHAT',
          StatusPengukuran.tidakSehat => 'TIDAK_SEHAT',
        };
    final statusPengukuranTrenString = switch (statusPengukuranTren) {
      StatusPengukuran.sehat => 'SEHAT',
      StatusPengukuran.kurangSehat => 'KURANG_SEHAT',
      StatusPengukuran.tidakSehat => 'TIDAK_SEHAT',
      _ => null,
    };
    final map = {
      'localId': localId,
      'serverId': serverId,
      'anakId': anakId,
      'anak': anak?.toMap(),
      'namaPosyandu': namaPosyandu,
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
      'statusPengukuranPertumbuhan': statusPengukuranPertumbuhanString,
      'penilaianTren': penilaianTren,
      'statusPengukuranTren': statusPengukuranTrenString,
      'rekomendasiOrtu': rekomendasiOrtu,
      'rekomendasiKader': rekomendasiKader,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'deletedAt': deletedAt?.millisecondsSinceEpoch,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory PengukuranModel.fromMap(Map<String, dynamic> map) {
    final kategoriBBU = switch (map['kategoriBBU']) {
      'SANGAT_KURANG' => KategoriBBU.sangatKurang,
      'KURANG' => KategoriBBU.kurang,
      'NORMAL' => KategoriBBU.normal,
      'LEBIH' => KategoriBBU.lebih,
      _ => null,
    };
    final kategoriTBU = switch (map['kategoriTBU']) {
      'SANGAT_PENDEK' => KategoriTBU.sangatPendek,
      'PENDEK' => KategoriTBU.pendek,
      'NORMAL' => KategoriTBU.normal,
      'TINGGI' => KategoriTBU.tinggi,
      _ => null,
    };
    final kategoriBBTB = switch (map['kategoriBBTB']) {
      'GIZI_BURUK' => KategoriBBTB.giziBuruk,
      'GIZI_KURANG' => KategoriBBTB.giziKurang,
      'GIZI_BAIK' => KategoriBBTB.giziBaik,
      'BERISIKO_GIZI_LEBIH' => KategoriBBTB.berisikoGiziLebih,
      'GIZI_LEBIH' => KategoriBBTB.giziLebih,
      'OBESITAS' => KategoriBBTB.obesitas,
      _ => null,
    };
    final kategoriIMTU = switch (map['kategoriIMTU']) {
      'GIZI_BURUK' => KategoriIMTU.giziBuruk,
      'GIZI_KURANG' => KategoriIMTU.giziKurang,
      'GIZI_BAIK' => KategoriIMTU.giziBaik,
      'BERISIKO_GIZI_LEBIH' => KategoriIMTU.berisikoGiziLebih,
      'GIZI_LEBIH' => KategoriIMTU.giziLebih,
      'OBESITAS' => KategoriIMTU.obesitas,
      _ => null,
    };

    final statusPengukuranPertumbuhan =
        switch (map['statusPengukuranPertumbuhan']) {
          'SEHAT' => StatusPengukuran.sehat,
          'KURANG_SEHAT' => StatusPengukuran.kurangSehat,
          'TIDAK_SEHAT' => StatusPengukuran.tidakSehat,
          _ => throw Exception(
            'Status pengukuran pertumbuhan tidak valid: ${map['statusPengukuranPertumbuhan']}',
          ),
        };

    final statusPengukuranTren = switch (map['statusPengukuranTren']) {
      'SEHAT' => StatusPengukuran.sehat,
      'KURANG_SEHAT' => StatusPengukuran.kurangSehat,
      'TIDAK_SEHAT' => StatusPengukuran.tidakSehat,
      _ => null,
    };

    String? namaPosyandu;

    if (map['posyandu'] != null) {
      namaPosyandu = map['posyandu']['namaPosyandu'] as String;
    } else if (map['namaPosyandu'] != null) {
      namaPosyandu = map['namaPosyandu'] as String;
    }
    return PengukuranModel(
      localId: map['localId'] != null ? map['localId'] as int : null,
      serverId: map['serverId'] != null ? map['serverId'] as int : null,
      anakId: map['anakId'] as int,
      anak: map['anak'] != null
          ? AnakModel.fromMap(map['anak'] as Map<String, dynamic>)
          : null,
      namaPosyandu: namaPosyandu,
      posyanduId: map['posyanduId'] != null ? map['posyanduId'] as int : null,
      tanggalPengukuran: map['tanggalPengukuran'] is String
          ? DateTime.parse(map['tanggalPengukuran'] as String)
          : DateTime.fromMillisecondsSinceEpoch(
              map['tanggalPengukuran'] as int,
            ),
      beratBadan: map['beratBadan'] as double,
      tinggiBadan: map['tinggiBadan'] as double,
      imt: map['imt'] != null ? map['imt'] as double : null,
      kategoriBBU: kategoriBBU,
      kategoriTBU: kategoriTBU,
      kategoriBBTB: kategoriBBTB,
      kategoriIMTU: kategoriIMTU,
      statusPertumbuhan: map['statusPertumbuhan'] as String,
      statusPengukuranPertumbuhan: statusPengukuranPertumbuhan,
      penilaianTren: map['penilaianTren'] != null
          ? map['penilaianTren'] as String
          : null,
      statusPengukuranTren: statusPengukuranTren,
      rekomendasiOrtu: map['rekomendasiOrtu'] != null
          ? map['rekomendasiOrtu'] as String
          : null,
      rekomendasiKader: map['rekomendasiKader'] != null
          ? map['rekomendasiKader'] as String
          : null,
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

  factory PengukuranModel.fromJson(String source) =>
      PengukuranModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PengukuranModel(localId: $localId, serverId: $serverId, anakId: $anakId, anak: $anak, namaPosyandu: $namaPosyandu, posyanduId: $posyanduId, tanggalPengukuran: $tanggalPengukuran, beratBadan: $beratBadan, tinggiBadan: $tinggiBadan, imt: $imt, kategoriBBU: $kategoriBBU, kategoriTBU: $kategoriTBU, kategoriBBTB: $kategoriBBTB, kategoriIMTU: $kategoriIMTU, statusPertumbuhan: $statusPertumbuhan, statusPengukuranPertumbuhan: $statusPengukuranPertumbuhan, penilaianTren: $penilaianTren, statusPengukuranTren: $statusPengukuranTren, rekomendasiOrtu: $rekomendasiOrtu, rekomendasiKader: $rekomendasiKader, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(covariant PengukuranModel other) {
    if (identical(this, other)) return true;

    return other.localId == localId &&
        other.serverId == serverId &&
        other.anakId == anakId &&
        other.anak == anak &&
        other.namaPosyandu == namaPosyandu &&
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
        other.statusPengukuranPertumbuhan == statusPengukuranPertumbuhan &&
        other.penilaianTren == penilaianTren &&
        other.statusPengukuranTren == statusPengukuranTren &&
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
        anak.hashCode ^
        namaPosyandu.hashCode ^
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
        statusPengukuranPertumbuhan.hashCode ^
        penilaianTren.hashCode ^
        statusPengukuranTren.hashCode ^
        rekomendasiOrtu.hashCode ^
        rekomendasiKader.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode;
  }
}
