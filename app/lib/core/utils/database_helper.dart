import 'package:app/core/constants/database_constants/anak_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;
  static final DatabaseHelper instance = DatabaseHelper._constructor();

  DatabaseHelper._constructor();
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'bocahsehatku.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _createDb,
    );
    return database;
  }

  Future<void> _createDb(Database db, int version) async {
    // Heroes table
    await db.execute(AnakTable.createTableQuery);
  }
}
