import 'package:app/core/utils/database_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'database_notifier.g.dart';

@Riverpod(keepAlive: true)
class DatabaseNotifier extends _$DatabaseNotifier {
  @override
  Database? build() {
    return null;
  }

  Future<void> initDatabase() async {
    final db = await DatabaseHelper.instance.database;
    state = db;
  }

  Future<void> deleteDatabase() async {
    await DatabaseHelper.deleteCurrentDatabase();
    state = null;
  }

  Database? get database {
    return state;
  }
}
