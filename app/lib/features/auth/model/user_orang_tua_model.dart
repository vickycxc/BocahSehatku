import 'dart:convert';

class UserOrangTuaModel {
  final int id;
  final String noHp;
  final String? nama;
  final String? nik;
  final String? jenisKelamin;
  final String? alamat;
  final String? posyanduId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? token;
  UserOrangTuaModel({
    required this.id,
    required this.noHp,
    this.nama,
    this.nik,
    this.jenisKelamin,
    this.alamat,
    this.posyanduId,
    required this.createdAt,
    required this.updatedAt,
    this.token,
  });

  UserOrangTuaModel copyWith({
    int? id,
    String? noHp,
    String? nama,
    String? nik,
    String? jenisKelamin,
    String? alamat,
    String? posyanduId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
  }) {
    return UserOrangTuaModel(
      id: id ?? this.id,
      noHp: noHp ?? this.noHp,
      nama: nama ?? this.nama,
      nik: nik ?? this.nik,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      alamat: alamat ?? this.alamat,
      posyanduId: posyanduId ?? this.posyanduId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'noHp': noHp,
      'nama': nama,
      'nik': nik,
      'jenisKelamin': jenisKelamin,
      'alamat': alamat,
      'posyanduId': posyanduId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'token': token,
    };
  }

  factory UserOrangTuaModel.fromMap(Map<String, dynamic> map) {
    return UserOrangTuaModel(
      id: map['id'] as int,
      noHp: map['noHp'] as String,
      nama: map['nama'] != null ? map['nama'] as String : null,
      nik: map['nik'] != null ? map['nik'] as String : null,
      jenisKelamin: map['jenisKelamin'] != null
          ? map['jenisKelamin'] as String
          : null,
      alamat: map['alamat'] != null ? map['alamat'] as String : null,
      posyanduId: map['posyanduId'] != null
          ? map['posyanduId'] as String
          : null,
      createdAt: DateTime.tryParse(map['createdAt'] as String)!,
      updatedAt: DateTime.tryParse(map['updatedAt'] as String)!,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserOrangTuaModel.fromJson(String source) =>
      UserOrangTuaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserOrangTuaModel(id: $id, noHp: $noHp, nama: $nama, nik: $nik, jenisKelamin: $jenisKelamin, alamat: $alamat, posyanduId: $posyanduId, createdAt: $createdAt, updatedAt: $updatedAt, token: $token)';
  }

  @override
  bool operator ==(covariant UserOrangTuaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.noHp == noHp &&
        other.nama == nama &&
        other.nik == nik &&
        other.jenisKelamin == jenisKelamin &&
        other.alamat == alamat &&
        other.posyanduId == posyanduId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        noHp.hashCode ^
        nama.hashCode ^
        nik.hashCode ^
        jenisKelamin.hashCode ^
        alamat.hashCode ^
        posyanduId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        token.hashCode;
  }
}
