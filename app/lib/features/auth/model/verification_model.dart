// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VerificationModel {
  final String? nik;
  final String? noHpBaru;
  final String? kodeOtp;

  VerificationModel({this.nik, this.noHpBaru, this.kodeOtp});

  VerificationModel copyWith({String? nik, String? noHpBaru, String? kodeOtp}) {
    return VerificationModel(
      nik: nik ?? this.nik,
      noHpBaru: noHpBaru ?? this.noHpBaru,
      kodeOtp: kodeOtp ?? this.kodeOtp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nik': nik,
      'noHpBaru': noHpBaru,
      'kodeOtp': kodeOtp,
    };
  }

  factory VerificationModel.fromMap(Map<String, dynamic> map) {
    return VerificationModel(
      nik: map['nik'] != null ? map['nik'] as String : null,
      noHpBaru: map['noHpBaru'] != null ? map['noHpBaru'] as String : null,
      kodeOtp: map['kodeOtp'] != null ? map['kodeOtp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationModel.fromJson(String source) =>
      VerificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'VerificationModel(nik: $nik, noHpBaru: $noHpBaru, kodeOtp: $kodeOtp)';

  @override
  bool operator ==(covariant VerificationModel other) {
    if (identical(this, other)) return true;

    return other.nik == nik &&
        other.noHpBaru == noHpBaru &&
        other.kodeOtp == kodeOtp;
  }

  @override
  int get hashCode => nik.hashCode ^ noHpBaru.hashCode ^ kodeOtp.hashCode;
}
