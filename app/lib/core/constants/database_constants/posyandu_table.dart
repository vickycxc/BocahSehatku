class PosyanduTable {
  static const String tableName = 'posyandu';
  static const String localIdColumnName = 'localId';
  static const String serverIdColumnName = 'serverId';
  static const String namaPosyanduColumnName = 'namaPosyandu';
  static const String kecamatanColumnName = 'kecamatan';
  static const String puskesmasColumnName = 'puskesmas';
  static const String desaKelurahanColumnName = 'desaKelurahan';
  static const String alamatColumnName = 'alamat';
  static const String createdAtColumnName = 'createdAt';
  static const String updatedAtColumnName = 'updatedAt';
  static const String deletedAtColumnName = 'deletedAt';

  static const String namaPosyanduColumnNameAlias1 = 'posyanduPengukuranNama';
  static const String namaPosyanduColumnNameAlias2 = 'posyanduOrangTuaNama';

  static const String createTableQuery =
      '''
        CREATE TABLE $tableName (
        $localIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
        $serverIdColumnName INTEGER UNIQUE NOT NULL,
        $namaPosyanduColumnName TEXT NOT NULL,
        $kecamatanColumnName TEXT NOT NULL,
        $puskesmasColumnName TEXT NOT NULL,
        $desaKelurahanColumnName TEXT NOT NULL,
        $alamatColumnName TEXT NOT NULL,
        $createdAtColumnName TEXT NOT NULL,
        $updatedAtColumnName TEXT NOT NULL,
        $deletedAtColumnName TEXT
        )
      ''';
}
