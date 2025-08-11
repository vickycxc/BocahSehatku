import 'dart:convert';

import 'package:app/core/constants/database_constants/anak_table.dart';
import 'package:app/core/constants/database_constants/pengukuran_table.dart';
import 'package:app/core/constants/database_constants/orang_tua_table.dart';
import 'package:app/core/constants/database_constants/posyandu_table.dart';
import 'package:app/core/model/anak_model.dart';
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

  Future<List<PengukuranModel>> ambilDataPengukuran() async {
    database.insert(PosyanduTable.tableName, {
      PosyanduTable.serverIdColumnName: 1,
      PosyanduTable.namaPosyanduColumnName: 'Posyandu Test',
      PosyanduTable.kecamatanColumnName: 'Kecamatan Test',
      PosyanduTable.puskesmasColumnName: 'Puskesmas Test',
      PosyanduTable.desaKelurahanColumnName: 'Desa Test',
      PosyanduTable.alamatColumnName: 'Alamat Posyandu Test',
      PosyanduTable.createdAtColumnName: DateTime.now().toIso8601String(),
      PosyanduTable.updatedAtColumnName: DateTime.now().toIso8601String(),
    });

    database.insert(OrangTuaTable.tableName, {
      OrangTuaTable.serverIdColumnName: 1,
      OrangTuaTable.namaColumnName: 'Orang Tua Test',
      OrangTuaTable.noHpColumnName: '081234567890',
      OrangTuaTable.nikColumnName: '1234567890123457',
      OrangTuaTable.jenisKelaminColumnName: 'LAKI_LAKI',
      OrangTuaTable.alamatColumnName: 'Alamat Test',
      OrangTuaTable.posyanduIdColumnName: 1,
      OrangTuaTable.createdAtColumnName: DateTime.now().toIso8601String(),
      OrangTuaTable.updatedAtColumnName: DateTime.now().toIso8601String(),
    });

    database.insert(AnakTable.tableName, {
      AnakTable.serverIdColumnName: 1,
      AnakTable.namaColumnName: 'Anak Test',
      AnakTable.tanggalLahirColumnName: DateTime(2025, 3, 25).toIso8601String(),
      AnakTable.jenisKelaminColumnName: 'LAKI_LAKI',
      AnakTable.nikColumnName: '1234567890123456',
      AnakTable.bbLahirColumnName: 3.5,
      AnakTable.tbLahirColumnName: 50.0,
      AnakTable.orangTuaIdColumnName: 1,
      AnakTable.createdAtColumnName: DateTime.now().toIso8601String(),
      AnakTable.updatedAtColumnName: DateTime.now().toIso8601String(),
    });

    database.insert(PengukuranTable.tableName, {
      PengukuranTable.serverIdColumnName: 0,
      PengukuranTable.anakIdColumnName: 1,
      PengukuranTable.posyanduIdColumnName: 1,
      PengukuranTable.tanggalPengukuranColumnName: DateTime.now()
          .toIso8601String(),
      PengukuranTable.beratBadanColumnName: 0.0,
      PengukuranTable.tinggiBadanColumnName: 0.0,
      PengukuranTable.imtColumnName: 0.0,
      PengukuranTable.kategoriBBUColumnName: 'NORMAL',
      PengukuranTable.kategoriTBUColumnName: 'NORMAL',
      PengukuranTable.kategoriBBTBColumnName: 'GIZI_BAIK',
      PengukuranTable.kategoriIMTUColumnName: 'GIZI_BAIK',
      PengukuranTable.statusPertumbuhanColumnName: 'NORMAL',
      PengukuranTable.statusPengukuranPertumbuhanColumnName: 'SEHAT',
      PengukuranTable.penilaianTrenColumnName: 'NORMAL',
      PengukuranTable.statusPengukuranTrenColumnName: 'SEHAT',
      PengukuranTable.rekomendasiOrtuColumnName: 'Tidak ada rekomendasi',
      PengukuranTable.rekomendasiKaderColumnName: 'Tidak ada rekomendasi',
      PengukuranTable.createdAtColumnName: DateTime.now().toIso8601String(),
      PengukuranTable.updatedAtColumnName: DateTime.now().toIso8601String(),
    });

    final data = await database.rawQuery('''
     SELECT 
      p.${PengukuranTable.localIdColumnName},
      p.${PengukuranTable.serverIdColumnName},
      p.${PengukuranTable.anakIdColumnName},
      p.${PengukuranTable.tanggalPengukuranColumnName},
      p.${PengukuranTable.beratBadanColumnName},
      p.${PengukuranTable.tinggiBadanColumnName},
      p.${PengukuranTable.imtColumnName},
      p.${PengukuranTable.kategoriBBUColumnName},
      p.${PengukuranTable.kategoriTBUColumnName},
      p.${PengukuranTable.kategoriBBTBColumnName},
      p.${PengukuranTable.kategoriIMTUColumnName},
      p.${PengukuranTable.statusPertumbuhanColumnName},
      p.${PengukuranTable.statusPengukuranPertumbuhanColumnName},
      p.${PengukuranTable.penilaianTrenColumnName},
      p.${PengukuranTable.statusPengukuranTrenColumnName},
      p.${PengukuranTable.rekomendasiOrtuColumnName},
      p.${PengukuranTable.rekomendasiKaderColumnName},
      a.${AnakTable.namaColumnName} AS ${AnakTable.namaColumnNameAlias},
      a.${AnakTable.tanggalLahirColumnName},
      a.${AnakTable.jenisKelaminColumnName},
      a.${AnakTable.nikColumnName},
      a.${AnakTable.bbLahirColumnName},
      a.${AnakTable.tbLahirColumnName},
      a.${AnakTable.mingguLahirColumnName},
      a.${AnakTable.orangTuaIdColumnName},
      pos1.${PosyanduTable.namaPosyanduColumnName} AS ${PosyanduTable.namaPosyanduColumnNameAlias1},
      o.${OrangTuaTable.noHpColumnName},
      o.${OrangTuaTable.namaColumnName} AS ${OrangTuaTable.namaColumnNameAlias},
      o.${OrangTuaTable.alamatColumnName},
      pos2.${PosyanduTable.namaPosyanduColumnName} AS ${PosyanduTable.namaPosyanduColumnNameAlias2}
    FROM ${PengukuranTable.tableName} p
    JOIN ${AnakTable.tableName} a
      ON p.${PengukuranTable.anakIdColumnName} = a.${AnakTable.localIdColumnName}
    JOIN ${PosyanduTable.tableName} pos1
      ON p.${PengukuranTable.posyanduIdColumnName} = pos1.${PosyanduTable.serverIdColumnName}
    LEFT JOIN ${OrangTuaTable.tableName} o
      ON a.${AnakTable.orangTuaIdColumnName} = o.${OrangTuaTable.serverIdColumnName}
    JOIN ${PosyanduTable.tableName} pos2
      ON p.${OrangTuaTable.posyanduIdColumnName} = pos2.${PosyanduTable.serverIdColumnName}
    WHERE p.${PengukuranTable.deletedAtColumnName} IS NULL
    ORDER BY p.${PengukuranTable.tanggalPengukuranColumnName} DESC
  ''');

    final dataString = jsonEncode(data);
    print(dataString);
    return data
        .map((pengukuran) => PengukuranModel.fromMap(pengukuran))
        .toList();
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
      {PengukuranTable.deletedAtColumnName: DateTime.now().toIso8601String()},
      where: '${PengukuranTable.localIdColumnName} = ?',
      whereArgs: [localId],
    );
  }
}
