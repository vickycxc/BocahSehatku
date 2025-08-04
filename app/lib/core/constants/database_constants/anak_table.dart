class AnakTable {
  static const String tableName = 'anak';
  static const String localIdColumnName = 'localId';
  static const String serverIdColumnName = 'serverId';
  static const String tanggalLahirColumnName = 'tanggalLahir';
  static const String jenisKelaminColumnName = 'jenisKelamin';
  static const String nikColumnName = 'nik';
  static const String bbLahirColumnName = 'bbLahir';
  static const String tbLahirColumnName = 'tbLahir';
  static const String mingguLahirColumnName = 'mingguLahir';
  static const String orangTuaIdColumnName = 'orangTuaId';
  static const String createdAtColumnName = 'createdAt';
  static const String updatedAtColumnName = 'updatedAt';
  static const String deletedAtColumnName = 'deletedAt';

  static const String createTableQuery =
      '''
        CREATE TABLE $tableName (
        $localIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
        $serverIdColumnName INTEGER,
        $tanggalLahirColumnName TEXT NOT NULL,
        $jenisKelaminColumnName TEXT NOT NULL,
        $nikColumnName TEXT,
        $bbLahirColumnName REAL,
        $tbLahirColumnName REAL,
        $mingguLahirColumnName INTEGER,
        $orangTuaIdColumnName INTEGER,
        $createdAtColumnName TEXT NOT NULL,
        $updatedAtColumnName TEXT NOT NULL,
        $deletedAtColumnName TEXT
        )
      ''';
}
