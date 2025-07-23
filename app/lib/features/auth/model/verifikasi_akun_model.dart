// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VerifikasiPenggunaModel {
  final String? nik;
  final String? noHp;
  final String? kodeOtp;

  VerifikasiPenggunaModel({this.nik, this.noHp, this.kodeOtp});

  VerifikasiPenggunaModel copyWith({
    String? nik,
    String? noHp,
    String? kodeOtp,
  }) {
    return VerifikasiPenggunaModel(
      nik: nik ?? this.nik,
      noHp: noHp ?? this.noHp,
      kodeOtp: kodeOtp ?? this.kodeOtp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'nik': nik, 'noHp': noHp, 'kodeOtp': kodeOtp};
  }

  factory VerifikasiPenggunaModel.fromMap(Map<String, dynamic> map) {
    return VerifikasiPenggunaModel(
      nik: map['nik'] != null ? map['nik'] as String : null,
      noHp: map['noHp'] != null ? map['noHp'] as String : null,
      kodeOtp: map['kodeOtp'] != null ? map['kodeOtp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifikasiPenggunaModel.fromJson(String source) =>
      VerifikasiPenggunaModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'VerifikasiPenggunaModel(nik: $nik, noHp: $noHp, kodeOtp: $kodeOtp)';

  @override
  bool operator ==(covariant VerifikasiPenggunaModel other) {
    if (identical(this, other)) return true;

    return other.nik == nik && other.noHp == noHp && other.kodeOtp == kodeOtp;
  }

  @override
  int get hashCode => nik.hashCode ^ noHp.hashCode ^ kodeOtp.hashCode;
}
