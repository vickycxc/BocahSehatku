import 'dart:convert';

import 'package:app/core/model/user_orang_tua_model.dart';
import 'package:app/core/model/user_posyandu_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthResponse {
  final String message;
  final bool? suksesMengirimOtp;
  final String? token;
  final UserOrangTuaModel? userOrangTua;
  final UserPosyanduModel? userPosyandu;
  AuthResponse({
    required this.message,
    this.suksesMengirimOtp,
    this.token,
    this.userOrangTua,
    this.userPosyandu,
  });

  AuthResponse copyWith({
    String? message,
    bool? suksesMengirimOtp,
    String? token,
    UserOrangTuaModel? userOrangTua,
    UserPosyanduModel? userPosyandu,
  }) {
    return AuthResponse(
      message: message ?? this.message,
      suksesMengirimOtp: suksesMengirimOtp ?? this.suksesMengirimOtp,
      token: token ?? this.token,
      userOrangTua: userOrangTua ?? this.userOrangTua,
      userPosyandu: userPosyandu ?? this.userPosyandu,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'suksesMengirimOtp': suksesMengirimOtp,
      'token': token,
      'userOrangTua': userOrangTua?.toMap(),
      'userPosyandu': userPosyandu?.toMap(),
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      message: map['message'] as String,
      suksesMengirimOtp: map['suksesMengirimOtp'] != null
          ? map['suksesMengirimOtp'] as bool
          : null,
      token: map['token'] != null ? map['token'] as String : null,
      userOrangTua: map['userOrangTua'] != null
          ? UserOrangTuaModel.fromMap(
              map['userOrangTua'] as Map<String, dynamic>,
            )
          : null,
      userPosyandu: map['userPosyandu'] != null
          ? UserPosyanduModel.fromMap(
              map['userPosyandu'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthResponse(message: $message, suksesMengirimOtp: $suksesMengirimOtp, token: $token, userOrangTua: $userOrangTua, userPosyandu: $userPosyandu)';
  }

  @override
  bool operator ==(covariant AuthResponse other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.suksesMengirimOtp == suksesMengirimOtp &&
        other.token == token &&
        other.userOrangTua == userOrangTua &&
        other.userPosyandu == userPosyandu;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        suksesMengirimOtp.hashCode ^
        token.hashCode ^
        userOrangTua.hashCode ^
        userPosyandu.hashCode;
  }
}
