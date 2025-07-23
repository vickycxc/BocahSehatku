import 'dart:convert';

import 'package:app/features/auth/model/orang_tua_model.dart';
import 'package:app/features/auth/model/posyandu_model.dart';
import 'package:app/features/auth/model/pengajuan_verifikasi_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthResponseModel {
  final String message;
  final bool? sukses;
  final String? token;
  final OrangTuaModel? userOrangTua;
  final PosyanduModel? userPosyandu;
  final List<PengajuanVerifikasiModel>? verifikasiAkun;
  AuthResponseModel({
    required this.message,
    this.sukses,
    this.token,
    this.userOrangTua,
    this.userPosyandu,
    this.verifikasiAkun,
  });

  AuthResponseModel copyWith({
    String? message,
    bool? sukses,
    String? token,
    OrangTuaModel? userOrangTua,
    PosyanduModel? userPosyandu,
    List<PengajuanVerifikasiModel>? verifikasiAkun,
  }) {
    return AuthResponseModel(
      message: message ?? this.message,
      sukses: sukses ?? this.sukses,
      token: token ?? this.token,
      userOrangTua: userOrangTua ?? this.userOrangTua,
      userPosyandu: userPosyandu ?? this.userPosyandu,
      verifikasiAkun: verifikasiAkun ?? this.verifikasiAkun,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'sukses': sukses,
      'token': token,
      'userOrangTua': userOrangTua?.toMap(),
      'userPosyandu': userPosyandu?.toMap(),
      'verifikasiAkun': verifikasiAkun?.map((x) => x.toMap()).toList(),
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      message: map['message'] as String,
      sukses: map['sukses'] != null ? map['sukses'] as bool : null,
      token: map['token'] != null ? map['token'] as String : null,
      userOrangTua: map['userOrangTua'] != null
          ? OrangTuaModel.fromMap(map['userOrangTua'] as Map<String, dynamic>)
          : null,
      userPosyandu: map['userPosyandu'] != null
          ? PosyanduModel.fromMap(map['userPosyandu'] as Map<String, dynamic>)
          : null,
      verifikasiAkun: map['verifikasiAkun'] != null
          ? List<PengajuanVerifikasiModel>.from(
              (map['verifikasiAkun'] as List<int>)
                  .map<PengajuanVerifikasiModel>(
                    (x) => PengajuanVerifikasiModel.fromMap(
                      x as Map<String, dynamic>,
                    ),
                  ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromJson(String source) =>
      AuthResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthResponse(message: $message, sukses: $sukses, token: $token, userOrangTua: $userOrangTua, userPosyandu: $userPosyandu, verifikasiAkun: $verifikasiAkun)';
  }

  @override
  bool operator ==(covariant AuthResponseModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.sukses == sukses &&
        other.token == token &&
        other.userOrangTua == userOrangTua &&
        other.userPosyandu == userPosyandu &&
        other.verifikasiAkun == verifikasiAkun;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        sukses.hashCode ^
        token.hashCode ^
        userOrangTua.hashCode ^
        userPosyandu.hashCode ^
        verifikasiAkun.hashCode;
  }
}
