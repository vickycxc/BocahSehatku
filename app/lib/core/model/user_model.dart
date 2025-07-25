// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/core/model/orang_tua_model.dart';
import 'package:app/core/model/posyandu_model.dart';
import 'package:fpdart/fpdart.dart';

class UserModel {
  final String token;
  final Either<OrangTuaModel, PosyanduModel> data;

  UserModel({required this.token, required this.data});

  UserModel copyWith({
    String? token,
    Either<OrangTuaModel, PosyanduModel>? user,
  }) {
    return UserModel(token: token ?? this.token, data: user ?? data);
  }

  Map<String, dynamic> toMap() {
    OrangTuaModel? orangTua;
    PosyanduModel? posyandu;
    switch (data) {
      case Left(value: final l):
        orangTua = l;
      case Right(value: final r):
        posyandu = r;
    }
    return <String, dynamic>{
      'token': token,
      'orangTua': orangTua?.toMap(),
      'posyandu': posyandu?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    OrangTuaModel? orangTua;
    PosyanduModel? posyandu;
    if (map['orangTua'] != null) {
      orangTua = OrangTuaModel.fromMap(map['orangTua'] as Map<String, dynamic>);
    } else if (map['posyandu'] != null) {
      posyandu = PosyanduModel.fromMap(map['posyandu'] as Map<String, dynamic>);
    } else {
      throw Exception('Data Pengguna Tidak Valid!');
    }
    return UserModel(
      token: map['token'] as String,
      data: orangTua != null
          ? Left(orangTua)
          : posyandu != null
          ? Right(posyandu)
          : throw Exception('Data Pengguna Tidak Valid!'),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(token: $token, user: $data)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.token == token && other.data == data;
  }

  @override
  int get hashCode => token.hashCode ^ data.hashCode;
}
