class PengukuranTable {
  static const String tableName = 'pengukuran';
  static const String localIdColumnName = 'localId';
  static const String serverIdColumnName = 'serverId';
  static const String anakIdColumnName = 'anakId';
  static const String posyanduIdColumnName = 'posyanduId';
  static const String tanggalPengukuranColumnName = 'tanggalPengukuran';
  static const String beratBadanColumnName = 'beratBadan';
  static const String tinggiBadanColumnName = 'tinggiBadan';
  static const String imtColumnName = 'imt';
  static const String kategoriBBUColumnName = 'kategoriBBU';
  static const String kategoriTBUColumnName = 'kategoriTBU';
  static const String kategoriBBTBColumnName = 'kategoriBBTB';
  static const String kategoriIMTUColumnName = 'kategoriIMTU';
  static const String statusPertumbuhanColumnName = 'statusPertumbuhan';
  static const String statusPengukuranPertumbuhanColumnName =
      'statusPengukuranPertumbuhan';
  static const String penilaianTrenColumnName = 'penilaianTren';
  static const String statusPengukuranTrenColumnName = 'statusPengukuranTren';
  static const String rekomendasiOrtuColumnName = 'rekomendasiOrtu';
  static const String rekomendasiKaderColumnName = 'rekomendasiKader';
  static const String createdAtColumnName = 'createdAt';
  static const String updatedAtColumnName = 'updatedAt';
  static const String deletedAtColumnName = 'deletedAt';

  static const String createTableQuery =
      '''
        CREATE TABLE $tableName (
        $localIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
        $serverIdColumnName INTEGER,
        $anakIdColumnName INTEGER NOT NULL,
        $posyanduIdColumnName INTEGER NOT NULL,
        $tanggalPengukuranColumnName TEXT NOT NULL,
        $beratBadanColumnName REAL NOT NULL,
        $tinggiBadanColumnName REAL NOT NULL,
        $imtColumnName REAL NOT NULL,
        $kategoriBBUColumnName TEXT NOT NULL,
        $kategoriTBUColumnName TEXT NOT NULL,
        $kategoriBBTBColumnName TEXT NOT NULL,
        $kategoriIMTUColumnName TEXT NOT NULL,
        $statusPertumbuhanColumnName TEXT NOT NULL,
        $statusPengukuranPertumbuhanColumnName TEXT NOT NULL,
        $penilaianTrenColumnName TEXT,
        $statusPengukuranTrenColumnName TEXT,
        $rekomendasiOrtuColumnName TEXT,
        $rekomendasiKaderColumnName TEXT,
        $createdAtColumnName TEXT NOT NULL,
        $updatedAtColumnName TEXT NOT NULL,
        $deletedAtColumnName TEXT
        FOREIGN KEY ($anakIdColumnName) REFERENCES anak(serverId) ON DELETE CASCADE,
        )
      ''';
}
