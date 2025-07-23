import 'dart:convert';

class PengajuanOtpModel {
  final String noHp;
  final String tujuan;

  PengajuanOtpModel({required this.noHp, required this.tujuan});

  PengajuanOtpModel copyWith({String? noHp, String? tujuan}) {
    return PengajuanOtpModel(
      noHp: noHp ?? this.noHp,
      tujuan: tujuan ?? this.tujuan,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'noHp': noHp, 'tujuan': tujuan};
  }

  factory PengajuanOtpModel.fromMap(Map<String, dynamic> map) {
    return PengajuanOtpModel(
      noHp: map['noHp'] as String,
      tujuan: map['tujuan'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PengajuanOtpModel.fromJson(String source) =>
      PengajuanOtpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PengajuanOtpModel(noHp: $noHp, tujuan: $tujuan)';

  @override
  bool operator ==(covariant PengajuanOtpModel other) {
    if (identical(this, other)) return true;

    return other.noHp == noHp && other.tujuan == tujuan;
  }

  @override
  int get hashCode => noHp.hashCode ^ tujuan.hashCode;
}
