class AnakTable {
  static const String tableName = 'anak';
  static const String localIdColumnName = 'localId';
  static const String serverIdColumnName = 'serverId';
  static const String namaColumnName = 'nama';
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

  static const String namaColumnNameAlias = 'anakNama';

  static const String createTableQuery =
      '''
        CREATE TABLE $tableName (
        $localIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
        $serverIdColumnName INTEGER UNIQUE NOT NULL,
        $namaColumnName TEXT NOT NULL,
        $tanggalLahirColumnName INTEGER NOT NULL,
        $jenisKelaminColumnName TEXT NOT NULL,
        $nikColumnName TEXT UNIQUE,
        $bbLahirColumnName REAL,
        $tbLahirColumnName REAL,
        $mingguLahirColumnName INTEGER,
        $orangTuaIdColumnName INTEGER,
        $createdAtColumnName INTEGER NOT NULL,
        $updatedAtColumnName INTEGER NOT NULL,
        $deletedAtColumnName INTEGER,
        FOREIGN KEY ($orangTuaIdColumnName) REFERENCES orang_tua(serverId) ON DELETE SET NULL
        )
      ''';
}
