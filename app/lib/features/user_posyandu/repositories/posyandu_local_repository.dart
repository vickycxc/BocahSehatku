import 'package:app/core/constants/database_constants/anak_table.dart';
import 'package:app/core/constants/database_constants/pengukuran_table.dart';
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

  Future<void> tambahDataPengukuran(PengukuranModel pengukuran) async {
    final newPengukuran = pengukuran.copyWith(
      localId: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await database.insert(PengukuranTable.tableName, newPengukuran.toMap());
  }

  Future<List<PengukuranModel>> ambilDataPengukuran(int anakId) async {
    // await database.delete(AnakTable.tableName);
    final data = await database.query(
      PengukuranTable.tableName,
      where:
          '${AnakTable.deletedAtColumnName} IS NULL AND ${PengukuranTable.anakIdColumnName} = ?',
      whereArgs: [anakId],
      orderBy: '${PengukuranTable.tanggalPengukuranColumnName} DESC',
    );
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
