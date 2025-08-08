import 'package:app/core/constants/database_constants/anak_table.dart';
import 'package:app/core/model/anak_model.dart';
import 'package:app/core/providers/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'ortu_local_repository.g.dart';

@riverpod
Future<OrtuLocalRepository> authLocalRepository(Ref ref) async {
  final db = await ref.watch(databaseProvider.future);
  return OrtuLocalRepository(db);
}

class OrtuLocalRepository {
  final Database database;

  OrtuLocalRepository(this.database);

  Future<void> tambahDataAnak(AnakModel anak) async {
    final newAnak = anak.copyWith(
      localId: null,
      serverId: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await database.insert(AnakTable.tableName, newAnak.toMap());
  }

  Future<List<AnakModel>> ambilDataAnak() async {
    // await database.delete(AnakTable.tableName);
    final data = await database.query(
      AnakTable.tableName,
      where: '${AnakTable.deletedAtColumnName} IS NULL',
    );
    return data.map((anak) => AnakModel.fromMap(anak)).toList();
  }

  Future<void> perbaruiDataAnak(AnakModel anak) async {
    await database.update(
      AnakTable.tableName,
      anak.toMap(),
      where: '${AnakTable.localIdColumnName} = ?',
      whereArgs: [anak.localId],
    );
  }

  Future<void> hapusDataAnak(int localId) async {
    await database.update(
      AnakTable.tableName,
      {AnakTable.deletedAtColumnName: DateTime.now().toIso8601String()},
      where: '${AnakTable.localIdColumnName} = ?',
      whereArgs: [localId],
    );
  }
}
