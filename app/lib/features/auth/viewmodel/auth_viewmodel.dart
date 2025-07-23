import 'package:app/core/providers/pengajuan_otp_notifier.dart';
import 'package:app/core/providers/pengajuan_verifikasi_notifier.dart';
import 'package:app/features/auth/model/pengajuan_otp_model.dart';
import 'package:app/features/auth/model/user_model.dart';
import 'package:app/core/providers/pengguna_aktif_notifier.dart';
import 'package:app/features/auth/model/orang_tua_model.dart';
import 'package:app/features/auth/model/auth_response_model.dart';
import 'package:app/features/auth/model/verifikasi_akun_model.dart';
import 'package:app/features/auth/model/pengajuan_verifikasi_model.dart';
import 'package:app/features/auth/repositories/auth_local_repository.dart';
import 'package:app/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late PenggunaAktifNotifier _penggunaAktifNotifier;
  late PengajuanVerifikasiNotifier _pengajuanVerifikasiNotifier;
  late PengajuanOtpNotifier _pengajuanOtpNotifier;

  @override
  AsyncValue<String>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _pengajuanVerifikasiNotifier = ref.watch(
      pengajuanVerifikasiNotifierProvider.notifier,
    );
    _penggunaAktifNotifier = ref.watch(penggunaAktifNotifierProvider.notifier);
    _pengajuanOtpNotifier = ref.watch(pengajuanOtpNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  Future<void> ambilDataPengguna() async {
    final token = _authLocalRepository.getToken();
    if (token != null) {
      final res = await _authRemoteRepository.ambilDataPenggunaSaatIni(token);
      if (res.userOrangTua != null || res.userPosyandu != null) {
        _berhasilAmbilDataPengguna(res, token);
      }
    }
  }

  Future<void> kirimOtp({
    required String noHp,
    required String tujuan,
    String? nik,
  }) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.kirimOtp(
      noHp: noHp,
      tujuan: tujuan,
      nik: nik,
    );
    print('🚀 ~ AuthViewModel ~ res: $res');
    if (res.sukses == true) {
      state = AsyncData(res.message);
      _pengajuanOtpNotifier.aturPengajuanOtp(
        PengajuanOtpModel(noHp: noHp, tujuan: tujuan),
      );
      if (nik != null) {
        _pengajuanVerifikasiNotifier.aturPengajuanVerifikasi(
          VerifikasiPenggunaModel(noHp: noHp, nik: nik, kodeOtp: null),
        );
      }
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<void> daftar({required String noHp, required String kodeOtp}) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.daftar(
      noHp: noHp,
      kodeOtp: kodeOtp,
    );
    if (res.token != null) {
      _berhasilMasuk(res);
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<void> perbaruiProfil({
    required String nama,
    required String nik,
    required String jenisKelamin,
    required String alamat,
    required int posyanduId,
  }) async {
    state = const AsyncLoading();
    final user = _penggunaAktifNotifier.state;
    if (user == null) {
      state = AsyncError('Pengguna Tidak Ditemukan!', StackTrace.current);
      return;
    }
    OrangTuaModel? userOrangTua;
    switch (user.data) {
      case Left(value: final l):
        userOrangTua = l;
      case Right():
        state = AsyncError('Pengguna Bukan Orang Tua!', StackTrace.current);
    }
    if (userOrangTua == null) {
      state = AsyncError('Pengguna Tidak Ditemukan!', StackTrace.current);
      return;
    }
    final res = await _authRemoteRepository.perbaruiProfil(
      token: user.token,
      id: userOrangTua.id,
      nama: nama,
      nik: nik,
      jenisKelamin: jenisKelamin,
      alamat: alamat,
      posyanduId: posyanduId,
    );
    if (res.userOrangTua != null) {
      _berhasilPerbaruiProfil(res);
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<void> ubahNoHp({
    required String noHpBaru,
    required String kodeOtp,
  }) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.ubahNoHp(
      noHpBaru: noHpBaru,
      kodeOtp: kodeOtp,
    );

    if (res.userOrangTua != null) {
      _berhasilPerbaruiProfil(res);
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<void> verifikasiOtp({
    required String noHp,
    required String kodeOtp,
  }) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.verifikasiOtp(
      noHp: noHp,
      kodeOtp: kodeOtp,
    );

    if (res.sukses == true) {
      final nik = _pengajuanVerifikasiNotifier.state?.nik;
      _pengajuanVerifikasiNotifier.aturPengajuanVerifikasi(
        VerifikasiPenggunaModel(nik: nik, noHp: noHp, kodeOtp: kodeOtp),
      );
      state = AsyncData(res.message);
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<void> ajukanUbahNoHp({required int posyanduId}) async {
    final verifikasi = _pengajuanVerifikasiNotifier.state;
    final nik = verifikasi?.nik;
    final noHpBaru = verifikasi?.noHp;
    final kodeOtp = verifikasi?.kodeOtp;

    if (nik == null || noHpBaru == null || kodeOtp == null) {
      state = AsyncError(
        'Gagal Mengajukan Pengubahan No. HP, NIK, No. HP Baru & Kode OTP Tidak Ditemukan!',
        StackTrace.current,
      );
      return;
    }
    state = const AsyncLoading();
    final res = await _authRemoteRepository.ajukanUbahNoHp(
      noHpBaru: noHpBaru,
      kodeOtp: kodeOtp,
      nik: nik,
      posyanduId: posyanduId,
    );

    if (res.sukses == true) {
      _pengajuanVerifikasiNotifier.hapusPengajuanVerifikasi();
      state = AsyncData(res.message);
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<List<PengajuanVerifikasiModel>> cekVerifikasiAkun(String token) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.cekVerifikasiAkun(token);
    if (res.verifikasiAkun != null) {
      state = AsyncData(res.message);
      return res.verifikasiAkun!;
    } else {
      state = AsyncError(res.message, StackTrace.current);
      return [];
    }
  }

  Future<void> verifikasiAkun({
    required String token,
    required String nik,
  }) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.verifikasiAkun(
      token: token,
      nik: nik,
    );
    if (res.sukses == true) {
      state = AsyncData(res.message);
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<void> masuk({required String noHp, required String kodeOtp}) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.masuk(noHp: noHp, kodeOtp: kodeOtp);
    if (res.token != null) {
      _berhasilMasuk(res);
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<void> masukPosyandu({
    required String kodePosyandu,
    required String password,
  }) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.masukPosyandu(
      kodePosyandu: kodePosyandu,
      password: password,
    );
    if (res.token != null) {
      _berhasilMasuk(res);
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  void keluar() {
    _authLocalRepository.removeToken();
    _penggunaAktifNotifier.hapusPenggunaAktif();
  }

  void _berhasilMasuk(AuthResponseModel res) {
    final token = res.token!;
    _authLocalRepository.setToken(token);
    final UserModel user = res.userOrangTua != null
        ? UserModel(token: token, data: Left(res.userOrangTua!))
        : UserModel(token: token, data: Right(res.userPosyandu!));
    _penggunaAktifNotifier.aturPenggunaAktif(user);
    state = AsyncData(res.message);
  }

  void _berhasilPerbaruiProfil(AuthResponseModel res) {
    final user = _penggunaAktifNotifier.state;
    final UserModel newUser = res.userOrangTua != null
        ? UserModel(token: user!.token, data: Left(res.userOrangTua!))
        : UserModel(token: user!.token, data: Right(res.userPosyandu!));
    _penggunaAktifNotifier.aturPenggunaAktif(newUser);
    state = AsyncData(res.message);
  }

  void _berhasilAmbilDataPengguna(AuthResponseModel res, String token) {
    final UserModel user = res.userOrangTua != null
        ? UserModel(token: token, data: Left(res.userOrangTua!))
        : UserModel(token: token, data: Right(res.userPosyandu!));
    _penggunaAktifNotifier.aturPenggunaAktif(user);
  }
}
