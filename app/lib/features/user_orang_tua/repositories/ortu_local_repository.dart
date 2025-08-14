import 'package:app/core/constants/database_constants/anak_table.dart';
import 'package:app/core/model/anak_model.dart';
import 'package:app/core/providers/database_notifier.dart';
import 'package:app/core/providers/shared_preferences_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

part 'ortu_local_repository.g.dart';

@riverpod
Future<OrtuLocalRepository> authLocalRepository(Ref ref) async {
  final sharedPreferences = ref.watch(sharedPreferencesNotifierProvider)!;
  final databaseNotifier = ref.watch(databaseNotifierProvider.notifier);
  await databaseNotifier.initDatabase();
  return OrtuLocalRepository(sharedPreferences, databaseNotifier);
}

class OrtuLocalRepository {
  final SharedPreferences sharedPrefences;
  final DatabaseNotifier databaseNotifier;
  late Database _database;

  OrtuLocalRepository(this.sharedPrefences, this.databaseNotifier) {
    _database = databaseNotifier.database!;
  }

  Future<void> tambahDataAnak(AnakModel anak) async {
    final newAnak = anak.copyWith(
      localId: null,
      serverId: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _database.insert(AnakTable.tableName, newAnak.toMap());
  }

  Future<List<AnakModel>> ambilDataAnak() async {
    // await database.delete(AnakTable.tableName);
    final data = await _database.query(
      AnakTable.tableName,
      where: '${AnakTable.deletedAtColumnName} IS NULL',
    );
    return data.map((anak) => AnakModel.fromMap(anak)).toList();
  }

  Future<void> perbaruiDataAnak(AnakModel anak) async {
    await _database.update(
      AnakTable.tableName,
      anak.toMap(),
      where: '${AnakTable.localIdColumnName} = ?',
      whereArgs: [anak.localId],
    );
  }

  Future<void> hapusDataAnak(int localId) async {
    await _database.update(
      AnakTable.tableName,
      {AnakTable.deletedAtColumnName: DateTime.now().millisecondsSinceEpoch},
      where: '${AnakTable.localIdColumnName} = ?',
      whereArgs: [localId],
    );
  }

  Future<void> simpanSinkronisasiTerakhir(DateTime sinkronisasiTerakhir) async {
    await sharedPrefences.setString(
      'sinkronisasiTerakhir',
      sinkronisasiTerakhir.toIso8601String(),
    );
  }

  DateTime? ambilSinkronisasiTerakhir() {
    final sinkronisasiTerakhir = sharedPrefences.getString(
      'sinkronisasiTerakhir',
    );
    if (sinkronisasiTerakhir != null) {
      return DateTime.parse(sinkronisasiTerakhir);
    }
    return null;
  }

  Future<void> keluar() async {
    sharedPrefences.remove('sinkronisasiTerakhir');
    _database.close();
    await databaseNotifier.deleteDatabase();
  }
}
