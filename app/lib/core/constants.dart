import 'package:app/core/model/posyandu_model.dart';

class Constants {
  static const List<Map<String, String>> splashMessages = [
    {
      "title": "Kartu Menuju Sehat Digital Ada di Genggaman Bunda",
      "subtitle":
          "Melalui Aplikasi Smartphone, Pantau Tumbuh Kembang Si Kecil Lebih Mudah dan Cerdas!",
    },
    {
      "title": "Semua Data Pertumbuhan Anak Tercatat Rapi Secara Digital!",
      "subtitle":
          "Kini, Bunda tidak perlu lagi khawatir kehilangan Kartu Menuju Sehat (KMS) fisik atau bingung mencatat setiap perkembangan si kecil. ",
    },
    {
      "title": "Terintegrasi Posyandu: Catat Data Langsung, Pantau Akurat!",
      "subtitle":
          "Sekarang, setiap kunjungan ke Posyandu jadi lebih praktis! Data pertumbuhan dan imunisasi si kecil bisa langsung tercatat dan terhubung dengan Posyandu, memastikan informasi yang akurat dan terbarui.",
    },
  ];

  static const String serverUrl =
      'https://bocahsehatku-1182e8ee94fa.herokuapp.com/api';
  // 'http://192.168.6.36:3000/api';

  static const List<String> daftarKecamatan = ['Gresik', 'Kebomas'];
  static const Map<String, List<String>> daftarPuskesmas = {
    'Gresik': ['Puskesmas Gresik 1', 'Puskesmas Gresik 2'],
    'Kebomas': ['Puskesmas Kebomas 1', 'Puskesmas Kebomas 2'],
  };

  //TODO dynamic posyandu
  static Map<String, List<PosyanduModel>> daftarPosyandu = {
    'Puskesmas Gresik 1': [
      PosyanduModel(
        id: 1,
        kodePosyandu: 'POS001',
        namaPosyandu: 'Posyandu Melati 1',
        kecamatan: 'Gresik',
        puskesmas: 'Puskesmas Gresik 1',
        desaKelurahan: 'Gresik Kota',
        alamat: 'Jl. Ahmad Yani No. 10, Gresik',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      ),
      PosyanduModel(
        id: 2,
        kodePosyandu: 'POS002',
        namaPosyandu: 'Posyandu Mawar 1',
        kecamatan: 'Gresik',
        puskesmas: 'Puskesmas Gresik 1',
        desaKelurahan: 'Karangpoh',
        alamat: 'Jl. Sunan Giri No. 25, Gresik',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      ),
    ],
    'Puskesmas Gresik 2': [
      PosyanduModel(
        id: 3,
        kodePosyandu: 'POS003',
        namaPosyandu: 'Posyandu Dahlia 2',
        kecamatan: 'Gresik',
        puskesmas: 'Puskesmas Gresik 2',
        desaKelurahan: 'Sidokumpul',
        alamat: 'Jl. Veteran No. 15, Gresik',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      ),
      PosyanduModel(
        id: 4,
        kodePosyandu: 'POS004',
        namaPosyandu: 'Posyandu Anggrek 2',
        kecamatan: 'Gresik',
        puskesmas: 'Puskesmas Gresik 2',
        desaKelurahan: 'Tlogopojok',
        alamat: 'Jl. Dr. Wahidin No. 8, Gresik',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      ),
    ],
    'Puskesmas Kebomas 1': [
      PosyanduModel(
        id: 5,
        kodePosyandu: 'POS005',
        namaPosyandu: 'Posyandu Tulip 1',
        kecamatan: 'Kebomas',
        puskesmas: 'Puskesmas Kebomas 1',
        desaKelurahan: 'Kebomas',
        alamat: 'Jl. Raya Kebomas No. 20, Kebomas',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      ),
      PosyanduModel(
        id: 6,
        kodePosyandu: 'POS006',
        namaPosyandu: 'Posyandu Kenanga 1',
        kecamatan: 'Kebomas',
        puskesmas: 'Puskesmas Kebomas 1',
        desaKelurahan: 'Randuagung',
        alamat: 'Jl. Randuagung Raya No. 12, Kebomas',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      ),
    ],
    'Puskesmas Kebomas 2': [
      PosyanduModel(
        id: 7,
        kodePosyandu: 'POS007',
        namaPosyandu: 'Posyandu Cempaka 2',
        kecamatan: 'Kebomas',
        puskesmas: 'Puskesmas Kebomas 2',
        desaKelurahan: 'Kembangan',
        alamat: 'Jl. Kembangan Indah No. 30, Kebomas',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      ),
      PosyanduModel(
        id: 8,
        kodePosyandu: 'POS008',
        namaPosyandu: 'Posyandu Seroja 2',
        kecamatan: 'Kebomas',
        puskesmas: 'Puskesmas Kebomas 2',
        desaKelurahan: 'Bungah',
        alamat: 'Jl. Bungah Permai No. 18, Kebomas',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      ),
    ],
  };
}
