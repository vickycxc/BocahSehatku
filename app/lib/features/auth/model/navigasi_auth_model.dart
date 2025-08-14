// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NavigasiAuthModel {
  final String tujuan;
  final String pesan;
  final String? noHp;
  final String? posyandu;

  NavigasiAuthModel({
    required this.tujuan,
    required this.pesan,
    this.noHp,
    this.posyandu,
  });

  NavigasiAuthModel copyWith({
    String? tujuan,
    String? pesan,
    String? noHp,
    String? posyandu,
  }) {
    return NavigasiAuthModel(
      tujuan: tujuan ?? this.tujuan,
      pesan: pesan ?? this.pesan,
      noHp: noHp ?? this.noHp,
      posyandu: posyandu ?? this.posyandu,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tujuan': tujuan,
      'pesan': pesan,
      'noHp': noHp,
      'posyandu': posyandu,
    };
  }

  factory NavigasiAuthModel.fromMap(Map<String, dynamic> map) {
    return NavigasiAuthModel(
      tujuan: map['tujuan'] as String,
      pesan: map['pesan'] as String,
      noHp: map['noHp'] != null ? map['noHp'] as String : null,
      posyandu: map['posyandu'] != null ? map['posyandu'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NavigasiAuthModel.fromJson(String source) =>
      NavigasiAuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NavigasiAuthModel(tujuan: $tujuan, pesan: $pesan, noHp: $noHp, posyandu: $posyandu)';
  }

  @override
  bool operator ==(covariant NavigasiAuthModel other) {
    if (identical(this, other)) return true;

    return other.tujuan == tujuan &&
        other.pesan == pesan &&
        other.noHp == noHp &&
        other.posyandu == posyandu;
  }

  @override
  int get hashCode {
    return tujuan.hashCode ^ pesan.hashCode ^ noHp.hashCode ^ posyandu.hashCode;
  }
}
