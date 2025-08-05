// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RiwayatKunjunganModel {
  final String namaPosyandu;
  final DateTime tanggalKunjungan;

  RiwayatKunjunganModel({
    required this.namaPosyandu,
    required this.tanggalKunjungan,
  });

  RiwayatKunjunganModel copyWith({
    String? namaPosyandu,
    DateTime? tanggalKunjungan,
  }) {
    return RiwayatKunjunganModel(
      namaPosyandu: namaPosyandu ?? this.namaPosyandu,
      tanggalKunjungan: tanggalKunjungan ?? this.tanggalKunjungan,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'namaPosyandu': namaPosyandu,
      'tanggalKunjungan': tanggalKunjungan.millisecondsSinceEpoch,
    };
  }

  factory RiwayatKunjunganModel.fromMap(Map<String, dynamic> map) {
    return RiwayatKunjunganModel(
      namaPosyandu: map['namaPosyandu'] as String,
      tanggalKunjungan: DateTime.fromMillisecondsSinceEpoch(
        map['tanggalKunjungan'] as int,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RiwayatKunjunganModel.fromJson(String source) =>
      RiwayatKunjunganModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'RiwayatKunjunganModel(namaPosyandu: $namaPosyandu, tanggalKunjungan: $tanggalKunjungan)';

  @override
  bool operator ==(covariant RiwayatKunjunganModel other) {
    if (identical(this, other)) return true;

    return other.namaPosyandu == namaPosyandu &&
        other.tanggalKunjungan == tanggalKunjungan;
  }

  @override
  int get hashCode => namaPosyandu.hashCode ^ tanggalKunjungan.hashCode;
}
