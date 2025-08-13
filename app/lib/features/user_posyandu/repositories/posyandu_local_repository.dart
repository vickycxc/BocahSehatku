import 'package:app/core/constants/database_constants/anak_table.dart';
import 'package:app/core/constants/database_constants/pengukuran_table.dart';
import 'package:app/core/constants/database_constants/orang_tua_table.dart';
import 'package:app/core/model/anak_model.dart';
import 'package:app/core/model/orang_tua_model.dart';
import 'package:app/core/model/pengukuran_model.dart';
import 'package:app/core/providers/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'posyandu_local_repository.g.dart';

@riverpod
Future<PosyanduLocalRepository> posyanduLocalRepository(Ref ref) async {
  final db = await ref.watch(databaseProvider.future);
  return PosyanduLocalRepository(db);
}

class PosyanduLocalRepository {
  final Database database;

  PosyanduLocalRepository(this.database);

  Future<void> tambahDataAnak(AnakModel anak) async {
    final newAnak = anak.copyWith(localId: null);
    await database.insert(AnakTable.tableName, newAnak.toMap());
  }

  Future<void> tambahDataPengukuran(PengukuranModel pengukuran) async {
    final newPengukuran = pengukuran.copyWith(
      localId: null,
      anak: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await database.insert(PengukuranTable.tableName, newPengukuran.toMap());
  }

  Future<List<PengukuranModel>> ambilDataPengukuranHariIni() async {
    DateTime awalHariIni = DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
    DateTime akhirHariIni = awalHariIni.add(const Duration(days: 1));
    // database.insert(PosyanduTable.tableName, {
    //   PosyanduTable.serverIdColumnName: 1,
    //   PosyanduTable.namaPosyanduColumnName: 'Posyandu Test',
    //   PosyanduTable.kecamatanColumnName: 'Kecamatan Test',
    //   PosyanduTable.puskesmasColumnName: 'Puskesmas Test',
    //   PosyanduTable.desaKelurahanColumnName: 'Desa Test',
    //   PosyanduTable.alamatColumnName: 'Alamat Posyandu Test',
    //   PosyanduTable.createdAtColumnName: DateTime.now().millisecondsSinceEpoch,
    //   PosyanduTable.updatedAtColumnName: DateTime.now().millisecondsSinceEpoch,
    // });
    // database.insert(OrangTuaTable.tableName, {
    //   OrangTuaTable.serverIdColumnName: 1,
    //   OrangTuaTable.namaColumnName: 'Orang Tua Test',
    //   OrangTuaTable.noHpColumnName: '081234567890',
    //   OrangTuaTable.nikColumnName: '1234567890123457',
    //   OrangTuaTable.jenisKelaminColumnName: 'LAKI_LAKI',
    //   OrangTuaTable.alamatColumnName: 'Alamat Test',
    //   OrangTuaTable.posyanduIdColumnName: 1,
    //   OrangTuaTable.createdAtColumnName: DateTime.now().millisecondsSinceEpoch,
    //   OrangTuaTable.updatedAtColumnName: DateTime.now().millisecondsSinceEpoch,
    // });
    // database.insert(AnakTable.tableName, {
    //   AnakTable.serverIdColumnName: 1,
    //   AnakTable.namaColumnName: 'Anak Test',
    //   AnakTable.tanggalLahirColumnName: DateTime(
    //     2025,
    //     3,
    //     25,
    //   ).millisecondsSinceEpoch,
    //   AnakTable.jenisKelaminColumnName: 'LAKI_LAKI',
    //   AnakTable.nikColumnName: '1234567890123456',
    //   AnakTable.bbLahirColumnName: 3.5,
    //   AnakTable.tbLahirColumnName: 50.0,
    //   AnakTable.orangTuaIdColumnName: 1,
    //   AnakTable.createdAtColumnName: DateTime.now().millisecondsSinceEpoch,
    //   AnakTable.updatedAtColumnName: DateTime.now().millisecondsSinceEpoch,
    // });
    // database.insert(PengukuranTable.tableName, {
    //   PengukuranTable.serverIdColumnName: 0,
    //   PengukuranTable.anakIdColumnName: 1,
    //   PengukuranTable.posyanduIdColumnName: 1,
    //   PengukuranTable.tanggalPengukuranColumnName:
    //       DateTime.now().millisecondsSinceEpoch,
    //   PengukuranTable.beratBadanColumnName: 0.0,
    //   PengukuranTable.tinggiBadanColumnName: 0.0,
    //   PengukuranTable.imtColumnName: 0.0,
    //   PengukuranTable.kategoriBBUColumnName: 'NORMAL',
    //   PengukuranTable.kategoriTBUColumnName: 'NORMAL',
    //   PengukuranTable.kategoriBBTBColumnName: 'GIZI_BAIK',
    //   PengukuranTable.kategoriIMTUColumnName: 'GIZI_BAIK',
    //   PengukuranTable.statusPertumbuhanColumnName: 'NORMAL',
    //   PengukuranTable.statusPengukuranPertumbuhanColumnName: 'SEHAT',
    //   PengukuranTable.penilaianTrenColumnName: 'NORMAL',
    //   PengukuranTable.statusPengukuranTrenColumnName: 'SEHAT',
    //   PengukuranTable.rekomendasiOrtuColumnName: 'Tidak ada rekomendasi',
    //   PengukuranTable.rekomendasiKaderColumnName: 'Tidak ada rekomendasi',
    //   PengukuranTable.createdAtColumnName:
    //       DateTime.now().millisecondsSinceEpoch,
    //   PengukuranTable.updatedAtColumnName:
    //       DateTime.now().millisecondsSinceEpoch,
    // });

    final data = await database.rawQuery('''
       SELECT
        p.${PengukuranTable.anakIdColumnName},
        p.${PengukuranTable.tanggalPengukuranColumnName},
        p.${PengukuranTable.beratBadanColumnName},
        p.${PengukuranTable.tinggiBadanColumnName},
        p.${PengukuranTable.statusPertumbuhanColumnName},
        p.${PengukuranTable.statusPengukuranPertumbuhanColumnName},
        a.${AnakTable.namaColumnName} AS ${AnakTable.namaColumnNameAlias},
        a.${AnakTable.tanggalLahirColumnName},
        a.${AnakTable.jenisKelaminColumnName},
        o.${OrangTuaTable.noHpColumnName},
        o.${OrangTuaTable.namaColumnName} AS ${OrangTuaTable.namaColumnNameAlias},
        o.${OrangTuaTable.alamatColumnName}
      FROM ${PengukuranTable.tableName} p
      JOIN ${AnakTable.tableName} a
        ON p.${PengukuranTable.anakIdColumnName} = a.${AnakTable.serverIdColumnName}
      LEFT JOIN ${OrangTuaTable.tableName} o
        ON a.${AnakTable.orangTuaIdColumnName} = o.${OrangTuaTable.serverIdColumnName}
      WHERE p.${PengukuranTable.tanggalPengukuranColumnName} >= ${awalHariIni.millisecondsSinceEpoch} 
      AND p.${PengukuranTable.tanggalPengukuranColumnName} < ${akhirHariIni.millisecondsSinceEpoch}
        AND p.${PengukuranTable.deletedAtColumnName} IS NULL
      ORDER BY p.${PengukuranTable.tanggalPengukuranColumnName} DESC
    ''');
    //   final data1 = await database.rawQuery('''
    //    SELECT * FROM ${PengukuranTable.tableName} p
    // ''');
    //   final data2 = await database.rawQuery('''
    //    SELECT * FROM ${OrangTuaTable.tableName} p
    // ''');
    //   final data3 = await database.rawQuery('''
    //    SELECT * FROM ${AnakTable.tableName} p
    // ''');
    //   final data4 = await database.rawQuery('''
    //    SELECT * FROM ${PosyanduTable.tableName} p
    // ''');

    // String data1String = jsonEncode(data1);
    // String data2String = jsonEncode(data2);
    // String data3String = jsonEncode(data3);
    // String data4String = jsonEncode(data4);
    List<PengukuranModel> listPengukuran = data.map((map) {
      PengukuranModel pengukuran = PengukuranModel.fromMap(map);
      AnakModel anak = AnakModel.fromMap(map);
      OrangTuaModel? ortu = map.containsKey(OrangTuaTable.namaColumnNameAlias)
          ? OrangTuaModel.fromMap(map)
          : null;
      return pengukuran.copyWith(anak: anak.copyWith(orangTua: ortu));
    }).toList();
    return listPengukuran;
  }

  Future<void> perbaruiDataPengukuran(PengukuranModel pengukuran) async {
    await database.update(
      PengukuranTable.tableName,
      pengukuran.toMap(),
      where: '${PengukuranTable.localIdColumnName} = ?',
      whereArgs: [pengukuran.localId],
    );
  }

  Future<void> hapusDataPengukuran(int localId) async {
    await database.update(
      PengukuranTable.tableName,
      {
        PengukuranTable.deletedAtColumnName:
            DateTime.now().millisecondsSinceEpoch,
      },
      where: '${PengukuranTable.localIdColumnName} = ?',
      whereArgs: [localId],
    );
  }
}
