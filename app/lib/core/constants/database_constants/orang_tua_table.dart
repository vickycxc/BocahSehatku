class OrangTuaTable {
  static const String tableName = 'orang_tua';
  static const String localIdColumnName = 'localId';
  static const String serverIdColumnName = 'serverId';
  static const String noHpColumnName = 'noHp';
  static const String namaColumnName = 'nama';
  static const String nikColumnName = 'nik';
  static const String jenisKelaminColumnName = 'jenisKelamin';
  static const String alamatColumnName = 'alamat';
  static const String posyanduIdColumnName = 'posyanduId';
  static const String createdAtColumnName = 'createdAt';
  static const String updatedAtColumnName = 'updatedAt';
  static const String deletedAtColumnName = 'deletedAt';

  static const String namaColumnNameAlias = 'orangTuaNama';

  static const String createTableQuery =
      '''
        CREATE TABLE $tableName (
        $localIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
        $serverIdColumnName INTEGER UNIQUE NOT NULL,
        $noHpColumnName TEXT UNIQUE NOT NULL,
        $namaColumnName TEXT NOT NULL,
        $nikColumnName TEXT UNIQUE NOT NULL,
        $jenisKelaminColumnName TEXT NOT NULL,
        $alamatColumnName TEXT NOT NULL,
        $posyanduIdColumnName INTEGER NOT NULL,
        $createdAtColumnName TEXT NOT NULL,
        $updatedAtColumnName TEXT NOT NULL,
        $deletedAtColumnName TEXT,
        FOREIGN KEY ($posyanduIdColumnName) REFERENCES posyandu(serverId)
        )
      ''';
}
