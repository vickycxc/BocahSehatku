// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/core/model/anak_model.dart';
import 'package:app/core/model/pengukuran_model.dart';
import 'package:collection/collection.dart';

class OrtuResponseModel {
  final bool sukses;
  final List<AnakModel>? listAnak;
  final List<PengukuranModel>? listPengukuran;
  final String? message;
  OrtuResponseModel({
    required this.sukses,
    this.listAnak,
    this.listPengukuran,
    this.message,
  });

  OrtuResponseModel copyWith({
    bool? sukses,
    List<AnakModel>? listAnak,
    List<PengukuranModel>? listPengukuran,
    String? message,
  }) {
    return OrtuResponseModel(
      sukses: sukses ?? this.sukses,
      listAnak: listAnak ?? this.listAnak,
      listPengukuran: listPengukuran ?? this.listPengukuran,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sukses': sukses,
      'listAnak': listAnak?.map((x) => x.toMap()).toList(),
      'listPengukuran': listPengukuran?.map((x) => x.toMap()).toList(),
      'message': message,
    };
  }

  factory OrtuResponseModel.fromMap(Map<String, dynamic> map) {
    return OrtuResponseModel(
      sukses: map['sukses'] as bool,
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
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrtuResponseModel.fromJson(String source) =>
      OrtuResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrtuResponseModel(sukses: $sukses, listAnak: $listAnak, listPengukuran: $listPengukuran, message: $message)';
  }

  @override
  bool operator ==(covariant OrtuResponseModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.sukses == sukses &&
        listEquals(other.listAnak, listAnak) &&
        listEquals(other.listPengukuran, listPengukuran) &&
        other.message == message;
  }

  @override
  int get hashCode {
    return sukses.hashCode ^
        listAnak.hashCode ^
        listPengukuran.hashCode ^
        message.hashCode;
  }
}
