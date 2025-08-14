class ResponsErrorApi {
  static const Map<String, String> _kirimOtpError = {
    'HP_TUJUAN_KOSONG': 'No. HP dan Tujuan Harus Diisi!',
    'NIK_KOSONG': 'NIK: Harus Diisi untuk Mengubah No. HP!',
    'SUDAH_DIAJUKAN': 'Pengajuan Ubah No. HP Sudah Diajukan!',
    'TUJUAN_TIDAK_VALID': 'Gagal Mengirim OTP, Tujuan Tidak Valid!',
    'AKUN_TIDAK_VALID': 'Gagal Mengirim OTP, Akun Tidak Ditemukan!',
    'HP_SUDAH_TERDAFTAR': 'Gagal Mengirim OTP, No. HP Sudah Terdaftar!',
    'OTP_GAGAL_DIKIRIM': 'Gagal Mengirim OTP, Pastikan No. HP Valid!',
    'INTERNAL_ERROR': 'Gagal Mengirim OTP, Terjadi Kesalahan Di Server!',
  };

  static const Map<String, String> _daftarError = {
    'HP_OTP_TIDAK_VALID':
        'Gagal Membuat Akun, No. HP dan Kode OTP Harus Diisi!',
    'HP_SUDAH_TERDAFTAR': 'Gagal Membuat Akun, No. HP Sudah Terdaftar!',
    'OTP_TIDAK_VALID': 'Gagal Membuat Akun, Kode OTP Tidak Valid!',
    'OTP_KADALUARSA': 'Gagal Membuat Akun, Kode OTP Sudah Kadaluarsa!',
    'INTERNAL_ERROR': 'Gagal Membuat Akun, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _perbaruiProfilError = {
    'FIELD_TIDAK_LENGKAP': 'Gagal Memperbarui Profil, Semua Field Harus Diisi!',
    'JENIS_KELAMIN_TIDAK_VALID':
        'Gagal Memperbarui Profil, Jenis Kelamin Tidak Valid!',
    'AKUN_TIDAK_DITEMUKAN': 'Gagal Memperbarui Profil, Akun Tidak Ditemukan!',
    'NIK_SUDAH_TERDAFTAR': 'Gagal Memperbarui Profil, NIK Sudah Terdaftar!',
    'POSYANDU_TIDAK_DITEMUKAN':
        'Gagal Memperbarui Profil, Posyandu Tidak Ditemukan!',
    'INTERNAL_ERROR':
        'Gagal Memperbarui Profil, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _hapusAkunError = {
    'AKUN_TIDAK_DITEMUKAN': 'Gagal Menghapus Akun, Akun Tidak Ditemukan!',
    'INTERNAL_ERROR': 'Gagal Menghapus Akun, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _ubahNoHpError = {
    'NO_HP_OTP_KOSONG':
        'Gagal Mengubah No. HP, No. HP Baru dan Kode OTP Harus Diisi!',
    'NO_HP_SUDAH_TERDAFTAR': 'Gagal Mengubah No. HP, No. HP Sudah Terdaftar!',
    'AKUN_TIDAK_DITEMUKAN': 'Gagal Mengubah No. HP, Akun Tidak Ditemukan!',
    'OTP_TIDAK_VALID': 'Gagal Mengubah No. HP, Kode OTP Tidak Valid!',
    'OTP_KADALUARSA': 'Gagal Mengubah No. HP, Kode OTP Sudah Kadaluarsa!',
    'INTERNAL_ERROR': 'Gagal Mengubah No. HP, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _verifikasiOtpError = {
    'NO_HP_OTP_KOSONG':
        'Gagal Verifikasi OTP, No. HP dan Kode OTP Harus Diisi!',
    'OTP_TIDAK_VALID': 'Gagal Memverifikasi OTP, Kode OTP Tidak Valid!',
    'OTP_KADALUARSA': 'Gagal Memverifikasi OTP, Kode OTP Sudah Kadaluarsa!',
    'INTERNAL_ERROR': 'Gagal Memverifikasi OTP, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _ajukanUbahNoHpError = {
    'NO_HP_KODE_OTP_NIK_POSYANDU_KOSONG':
        'Gagal Mengajukan Ubah No. HP, No. HP Baru, Kode OTP, NIK, dan ID Posyandu Harus Diisi!',
    'OTP_TIDAK_VALID': 'Gagal Memverifikasi OTP, Kode OTP Tidak Valid!',
    'OTP_KADALUARSA': 'Gagal Memverifikasi OTP, Kode OTP Sudah Kadaluarsa!',
    'PENGAJUAN_SUDAH_DILAKUKAN': 'Pengajuan Ubah No. HP Sudah Diajukan!',
    'POSYANDU_TIDAK_DITEMUKAN':
        'Gagal Mengajukan Ubah No. HP, Posyandu Tidak Ditemukan!',
    'AKUN_TIDAK_DITEMUKAN':
        'Gagal Mengajukan Ubah No. HP, Akun Tidak Ditemukan!',
    'INTERNAL_ERROR': 'Gagal Mengubah No. HP, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _batalkanPengajuanUbahNoHpError = {
    'NIK_KOSONG': 'Gagal Membatalkan Pengajuan Ubah No. HP, NIK Harus Diisi!',
    'PENGAJUAN_TIDAK_DITEMUKAN':
        'Gagal Membatalkan Pengajuan Ubah No. HP, Pengajuan Tidak Ditemukan!',
    'INTERNAL_ERROR':
        'Gagal Membatalkan Pengajuan No. HP, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _verifikasiAkunError = {
    'NIK_KOSONG': 'Gagal Memverifikasi Akun, NIK Harus Diisi!',
    'PENGAJUAN_TIDAK_DITEMUKAN':
        'Gagal Memverifikasi Akun, Pengajuan Verifikasi Akun Tidak Ditemukan!',
    'INTERNAL_ERROR':
        'Gagal Memverifikasi Akun, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _masukError = {
    'NO_HP_OTP_KOSONG': 'Gagal Masuk, No. HP dan Kode OTP Harus Diisi!',
    'AKUN_TIDAK_DITEMUKAN': 'Gagal Masuk, Akun Tidak Ditemukan!',
    'OTP_TIDAK_VALID': 'Gagal Masuk, Kode OTP Tidak Valid!',
    'OTP_KADALUARSA': 'Gagal Masuk, Kode OTP Sudah Kadaluarsa!',
    'INTERNAL_ERROR': 'Gagal Masuk, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _masukPosyanduError = {
    'KODE_POSYANDU_PASSWORD_KOSONG':
        'Gagal Masuk Ke Posyandu, Kode Posyandu dan Password Harus Diisi!',
    'KODE_POSYANDU_TIDAK_VALID':
        'Gagal Masuk ke Posyandu, Kode Posyandu Tidak Valid!',
    'PASSWORD_TIDAK_VALID': 'Gagal Masuk ke Posyandu, Password Tidak Valid!',
    'INTERNAL_ERROR': 'Gagal Login Posyandu, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _checkAuthError = {
    'INTERNAL_ERROR':
        'Gagal Mengecek Otorisasi, Terjadi Kesalahan Pada Server!',
  };

  static const Map<String, String> _protectRouteError = {
    'TOKEN_TIDAK_DITEMUKAN': 'Tidak Diizinkan - Token Tidak Ditemukan!',
    'TOKEN_TIDAK_VALID': 'Tidak Diizinkan - Token Tidak Valid!',
    'PENGGUNA_TIDAK_DITEMUKAN': 'Tidak Diizinkan - Pengguna Tidak Ditemukan!',
    'PERAN_TIDAK_DIKENAL': 'Tidak Diizinkan - Peran Tidak Dikenal!',
  };

  static String getKirimOtpError(String key, int? waktuTungguOtp) {
    if (key == 'TERLALU_BANYAK_PERMINTAAN_OTP') {
      return 'Terlalu banyak permintaan OTP. Silakan tunggu $waktuTungguOtp menit lagi.';
    }
    return _kirimOtpError[key] ?? key;
  }

  static String getDaftarError(String key) {
    return _daftarError[key] ?? key;
  }

  static String getPerbaruiProfilError(String key) {
    return _perbaruiProfilError[key] ?? _protectRouteError[key] ?? key;
  }

  static String getHapusAkunError(String key) {
    return _hapusAkunError[key] ?? _protectRouteError[key] ?? key;
  }

  static String getUbahNoHpError(String key) {
    return _ubahNoHpError[key] ?? _protectRouteError[key] ?? key;
  }

  static String getVerifikasiOtpError(String key) {
    return _verifikasiOtpError[key] ?? key;
  }

  static String getAjukanUbahNoHpError(String key) {
    return _ajukanUbahNoHpError[key] ?? key;
  }

  static String getBatalkanPengajuanUbahNoHpError(String key) {
    return _batalkanPengajuanUbahNoHpError[key] ?? key;
  }

  static String getVerifikasiAkunError(String key) {
    return _verifikasiAkunError[key] ?? key;
  }

  static String getMasukError(String key) {
    return _masukError[key] ?? key;
  }

  static String getMasukPosyanduError(String key) {
    return _masukPosyanduError[key] ?? key;
  }

  static String getCheckAuthError(String key) {
    return _checkAuthError[key] ?? key;
  }

  static String getProtectRouteError(String key) {
    return _protectRouteError[key] ?? _protectRouteError[key] ?? key;
  }
}
