// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/core/model/anak_model.dart';
import 'package:app/core/model/orang_tua_model.dart';
import 'package:app/core/model/pengukuran_model.dart';
import 'package:app/core/model/posyandu_model.dart';
import 'package:app/features/auth/model/pengajuan_verifikasi_model.dart';
import 'package:collection/collection.dart';

class AuthResponseModel {
  final String? pesanError;
  final bool? sukses;
  final int? waktuTungguOtp;
  final String? token;
  final String? noHpBaru;
  final String? posyandu;
  final OrangTuaModel? userOrangTua;
  final PosyanduModel? userPosyandu;
  final List<AnakModel>? listAnak;
  final List<PengukuranModel>? listPengukuran;
  final List<OrangTuaModel>? listOrangTua;
  final List<PosyanduModel>? listPosyandu;
  final List<PengajuanVerifikasiModel>? listPengajuanVerifikasi;
  AuthResponseModel({
    this.pesanError,
    this.sukses,
    this.waktuTungguOtp,
    this.token,
    this.noHpBaru,
    this.posyandu,
    this.userOrangTua,
    this.userPosyandu,
    this.listAnak,
    this.listPengukuran,
    this.listOrangTua,
    this.listPosyandu,
    this.listPengajuanVerifikasi,
  });

  AuthResponseModel copyWith({
    String? pesanError,
    bool? sukses,
    int? waktuTungguOtp,
    String? token,
    String? noHpBaru,
    String? posyandu,
    OrangTuaModel? userOrangTua,
    PosyanduModel? userPosyandu,
    List<AnakModel>? listAnak,
    List<PengukuranModel>? listPengukuran,
    List<OrangTuaModel>? listOrangTua,
    List<PosyanduModel>? listPosyandu,
    List<PengajuanVerifikasiModel>? listPengajuanVerifikasi,
  }) {
    return AuthResponseModel(
      pesanError: pesanError ?? this.pesanError,
      sukses: sukses ?? this.sukses,
      waktuTungguOtp: waktuTungguOtp ?? waktuTungguOtp,
      token: token ?? this.token,
      noHpBaru: noHpBaru ?? this.noHpBaru,
      posyandu: posyandu ?? this.posyandu,
      userOrangTua: userOrangTua ?? this.userOrangTua,
      userPosyandu: userPosyandu ?? this.userPosyandu,
      listAnak: listAnak ?? this.listAnak,
      listPengukuran: listPengukuran ?? this.listPengukuran,
      listOrangTua: listOrangTua ?? this.listOrangTua,
      listPosyandu: listPosyandu ?? this.listPosyandu,
      listPengajuanVerifikasi:
          listPengajuanVerifikasi ?? this.listPengajuanVerifikasi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pesanError': pesanError,
      'sukses': sukses,
      'waktuTungguOtp': waktuTungguOtp,
      'token': token,
      'noHpBaru': noHpBaru,
      'posyandu': posyandu,
      'userOrangTua': userOrangTua?.toMap(),
      'userPosyandu': userPosyandu?.toMap(),
      'listAnak': listAnak?.map((x) => x.toMap()).toList(),
      'listPengukuran': listPengukuran?.map((x) => x.toMap()).toList(),
      'listOrangTua': listOrangTua?.map((x) => x.toMap()).toList(),
      'listPosyandu': listPosyandu?.map((x) => x.toMap()).toList(),
      'listPengajuanVerifikasi': listPengajuanVerifikasi
          ?.map((x) => x.toMap())
          .toList(),
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      pesanError: map['pesanError'] != null
          ? map['pesanError'] as String
          : null,
      sukses: map['sukses'] != null ? map['sukses'] as bool : null,
      waktuTungguOtp: map['waktuTungguOtp'] != null
          ? map['waktuTungguOtp'] as int
          : null,
      token: map['token'] != null ? map['token'] as String : null,
      noHpBaru: map['noHpBaru'] != null ? map['noHpBaru'] as String : null,
      posyandu: map['posyandu'] != null ? map['posyandu'] as String : null,
      userOrangTua: map['userOrangTua'] != null
          ? OrangTuaModel.fromMap(map['userOrangTua'] as Map<String, dynamic>)
          : null,
      userPosyandu: map['userPosyandu'] != null
          ? PosyanduModel.fromMap(map['userPosyandu'] as Map<String, dynamic>)
          : null,
      listAnak: map['listAnak'] != null
          ? List<AnakModel>.from(
              (map['listAnak'] as List<int>).map<AnakModel?>(
                (x) => AnakModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      listPengukuran: map['listPengukuran'] != null
          ? List<PengukuranModel>.from(
              (map['listPengukuran'] as List<int>).map<PengukuranModel?>(
                (x) => PengukuranModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      listOrangTua: map['listOrangTua'] != null
          ? List<OrangTuaModel>.from(
              (map['listOrangTua'] as List<int>).map<OrangTuaModel?>(
                (x) => OrangTuaModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      listPosyandu: map['listPosyandu'] != null
          ? List<PosyanduModel>.from(
              (map['listPosyandu'] as List<int>).map<PosyanduModel?>(
                (x) => PosyanduModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      listPengajuanVerifikasi: map['listPengajuanVerifikasi'] != null
          ? List<PengajuanVerifikasiModel>.from(
              (map['listPengajuanVerifikasi'] as List<int>)
                  .map<PengajuanVerifikasiModel?>(
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
    return 'AuthResponseModel(pesanError: $pesanError, sukses: $sukses, waktuTungguOtp: $waktuTungguOtp, token: $token, noHpBaru: $noHpBaru, posyandu: $posyandu, userOrangTua: $userOrangTua, userPosyandu: $userPosyandu, listAnak: $listAnak, listPengukuran: $listPengukuran, listOrangTua: $listOrangTua, listPosyandu: $listPosyandu, listPengajuanVerifikasi: $listPengajuanVerifikasi)';
  }

  @override
  bool operator ==(covariant AuthResponseModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.pesanError == pesanError &&
        other.sukses == sukses &&
        other.waktuTungguOtp == waktuTungguOtp &&
        other.token == token &&
        other.noHpBaru == noHpBaru &&
        other.posyandu == posyandu &&
        other.userOrangTua == userOrangTua &&
        other.userPosyandu == userPosyandu &&
        listEquals(other.listAnak, listAnak) &&
        listEquals(other.listPengukuran, listPengukuran) &&
        listEquals(other.listOrangTua, listOrangTua) &&
        listEquals(other.listPosyandu, listPosyandu) &&
        listEquals(other.listPengajuanVerifikasi, listPengajuanVerifikasi);
  }

  @override
  int get hashCode {
    return pesanError.hashCode ^
        sukses.hashCode ^
        waktuTungguOtp.hashCode ^
        token.hashCode ^
        noHpBaru.hashCode ^
        posyandu.hashCode ^
        userOrangTua.hashCode ^
        userPosyandu.hashCode ^
        listAnak.hashCode ^
        listPengukuran.hashCode ^
        listOrangTua.hashCode ^
        listPosyandu.hashCode ^
        listPengajuanVerifikasi.hashCode;
  }
}
