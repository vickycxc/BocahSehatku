// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/core/model/anak_model.dart';
import 'package:app/features/user_orang_tua/model/riwayat_kunjungan_model.dart';
import 'package:collection/collection.dart';

class UserOrtuModel {
  final List<AnakModel> listAnak;
  final List<RiwayatKunjunganModel> listRiwayatKunjungan;
  UserOrtuModel({required this.listAnak, required this.listRiwayatKunjungan});

  UserOrtuModel copyWith({
    List<AnakModel>? listAnak,
    List<RiwayatKunjunganModel>? listRiwayatKunjungan,
  }) {
    return UserOrtuModel(
      listAnak: listAnak ?? this.listAnak,
      listRiwayatKunjungan: listRiwayatKunjungan ?? this.listRiwayatKunjungan,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listAnak': listAnak.map((x) => x.toMap()).toList(),
      'listRiwayatKunjungan': listRiwayatKunjungan
          .map((x) => x.toMap())
          .toList(),
    };
  }

  factory UserOrtuModel.fromMap(Map<String, dynamic> map) {
    return UserOrtuModel(
      listAnak: List<AnakModel>.from(
        (map['listAnak'] as List<int>).map<AnakModel>(
          (x) => AnakModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      listRiwayatKunjungan: List<RiwayatKunjunganModel>.from(
        (map['listRiwayatKunjungan'] as List<int>).map<RiwayatKunjunganModel>(
          (x) => RiwayatKunjunganModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserOrtuModel.fromJson(String source) =>
      UserOrtuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserOrtuModel(listAnak: $listAnak, listRiwayatKunjungan: $listRiwayatKunjungan)';

  @override
  bool operator ==(covariant UserOrtuModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.listAnak, listAnak) &&
        listEquals(other.listRiwayatKunjungan, listRiwayatKunjungan);
  }

  @override
  int get hashCode => listAnak.hashCode ^ listRiwayatKunjungan.hashCode;
}
