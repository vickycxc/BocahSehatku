// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NavigasiAuthModel {
  final String tujuan;
  final String message;
  final String? noHp;
  final String? posyandu;

  NavigasiAuthModel({
    required this.tujuan,
    required this.message,
    this.noHp,
    this.posyandu,
  });

  NavigasiAuthModel copyWith({String? tujuan, String? message, String? noHp}) {
    return NavigasiAuthModel(
      tujuan: tujuan ?? this.tujuan,
      message: message ?? this.message,
      noHp: noHp ?? this.noHp,
      posyandu: posyandu ?? posyandu,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tujuan': tujuan,
      'message': message,
      'noHp': noHp,
      'posyandu': posyandu,
    };
  }

  factory NavigasiAuthModel.fromMap(Map<String, dynamic> map) {
    return NavigasiAuthModel(
      tujuan: map['tujuan'] as String,
      message: map['message'] as String,
      noHp: map['noHp'] != null ? map['noHp'] as String : null,
      posyandu: map['posyandu'] != null ? map['posyandu'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NavigasiAuthModel.fromJson(String source) =>
      NavigasiAuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NavigasiAuthModel(tujuan: $tujuan, message: $message, noHp: $noHp, posyandu: $posyandu)';

  @override
  bool operator ==(covariant NavigasiAuthModel other) {
    if (identical(this, other)) return true;

    return other.tujuan == tujuan &&
        other.message == message &&
        other.noHp == noHp &&
        other.posyandu == posyandu;
  }

  @override
  int get hashCode =>
      tujuan.hashCode ^ message.hashCode ^ noHp.hashCode ^ posyandu.hashCode;
}
