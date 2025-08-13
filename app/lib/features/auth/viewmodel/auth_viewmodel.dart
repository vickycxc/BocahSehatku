import 'package:app/core/providers/pengajuan_otp_notifier.dart';
import 'package:app/core/providers/pengajuan_verifikasi_notifier.dart';
import 'package:app/features/auth/model/navigasi_auth_model.dart';
import 'package:app/features/auth/model/pengajuan_otp_model.dart';
import 'package:app/core/model/user_model.dart';
import 'package:app/core/providers/pengguna_aktif_notifier.dart';
import 'package:app/core/model/orang_tua_model.dart';
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
  AsyncValue<NavigasiAuthModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _pengajuanVerifikasiNotifier = ref.watch(
      pengajuanVerifikasiNotifierProvider.notifier,
    );
    _penggunaAktifNotifier = ref.watch(penggunaAktifNotifierProvider.notifier);
    _pengajuanOtpNotifier = ref.watch(pengajuanOtpNotifierProvider.notifier);
    return null;
  }

  Future<void> ambilDataPengguna() async {
    final user = _authLocalRepository.getUser();
    if (user != null) {
      _penggunaAktifNotifier.aturPenggunaAktif(user);
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
    if (res.sukses == true) {
      _pengajuanOtpNotifier.aturPengajuanOtp(
        PengajuanOtpModel(noHp: noHp, tujuan: tujuan),
      );
      if (nik != null) {
        _pengajuanVerifikasiNotifier.aturPengajuanVerifikasi(
          VerifikasiPenggunaModel(noHp: noHp, nik: nik, kodeOtp: null),
        );
      }
      state = AsyncData(
        NavigasiAuthModel(tujuan: 'OTP_PAGE', noHp: noHp, message: res.message),
      );
    } else {
      if (res.noHpBaru != null) {
        state = AsyncError(
          NavigasiAuthModel(
            tujuan: 'SUDAH_MENGAJUKAN',
            message: res.message,
            noHp: res.noHpBaru,
            posyandu: res.posyandu,
          ),
          StackTrace.current,
        );
      } else {
        state = AsyncError(res.message, StackTrace.current);
      }
    }
  }

  Future<void> daftar({required String noHp, required String kodeOtp}) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.daftar(
      noHp: noHp,
      kodeOtp: kodeOtp,
    );
    if (res.token != null) {
      _berhasilMasuk(res: res, tujuan: 'COMPLETE_PROFILE_PAGE');
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
      id: userOrangTua.id!,
      nama: nama,
      nik: nik,
      jenisKelamin: jenisKelamin,
      alamat: alamat,
      posyanduId: posyanduId,
    );
    if (res.userOrangTua != null) {
      _berhasilPerbaruiProfil(res: res, tujuan: 'ORTU_PAGE');
    } else {
      if (res.noHpBaru != null) {
        state = AsyncError(
          NavigasiAuthModel(
            tujuan: 'NIK_SUDAH_TERDAFTAR',
            message: res.message,
            noHp: res.noHpBaru,
          ),
          StackTrace.current,
        );
      } else {
        state = AsyncError(res.message, StackTrace.current);
      }
    }
  }

  Future<void> hapusAkun() async {
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
    final res = await _authRemoteRepository.hapusAkun(token: user.token);
    if (res.sukses == true) {
      _penggunaAktifNotifier.hapusPenggunaAktif();
      _authLocalRepository.removeUser();
      state = AsyncData(
        NavigasiAuthModel(tujuan: 'ONBOARDING_PAGE', message: res.message),
      );
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
      _berhasilPerbaruiProfil(res: res, tujuan: '');
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<void> verifikasiOtp({
    required String noHp,
    required String kodeOtp,
    required String tujuan,
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
      state = AsyncData(
        NavigasiAuthModel(
          message: res.message,
          tujuan: 'PILIH_POSYANDU',
          noHp: noHp,
        ),
      );
    } else {
      state = AsyncError(
        NavigasiAuthModel(
          tujuan: 'SUDAH_MENGAJUKAN',
          message: res.message,
          noHp: res.noHpBaru,
          posyandu: res.posyandu,
        ),
        StackTrace.current,
      );
    }
  }

  Future<void> ajukanUbahNoHp({required int posyanduId}) async {
    final verifikasi = _pengajuanVerifikasiNotifier.state;
    final nik = verifikasi?.nik;
    final noHpBaru = verifikasi?.noHp;
    final kodeOtp = verifikasi?.kodeOtp;

    if (nik == null || noHpBaru == null || kodeOtp == null) {
      state = AsyncError(
        'Gagal Mengajukan Pengajuan Ubah No. HP, NIK, No. HP Baru & Kode OTP Tidak Ditemukan!',
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
      state = AsyncData(
        NavigasiAuthModel(tujuan: 'ONBOARDING_PAGE', message: res.message),
      );
    } else {
      state = AsyncError(
        NavigasiAuthModel(
          tujuan: 'SUDAH_MENGAJUKAN',
          message: res.message,
          noHp: res.noHpBaru,
          posyandu: res.posyandu,
        ),
        StackTrace.current,
      );
    }
  }

  Future<void> batalkanPengajuanUbahNoHp() async {
    state = const AsyncLoading();
    final verifikasi = _pengajuanVerifikasiNotifier.state;
    final nik = verifikasi?.nik;

    if (nik == null) {
      state = AsyncError(
        'Gagal Membatalkan Pengajuan Ubah No. HP, NIK Tidak Ditemukan!',
        StackTrace.current,
      );
      return;
    }
    final res = await _authRemoteRepository.batalkanPengajuanUbahNoHp(nik);
    if (res.sukses == true) {
      _pengajuanVerifikasiNotifier.hapusPengajuanVerifikasi();
      state = AsyncData(
        NavigasiAuthModel(tujuan: 'ONBOARDING_PAGE', message: res.message),
      );
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<List<PengajuanVerifikasiModel>> cekVerifikasiAkun(String token) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.cekVerifikasiAkun(token);
    if (res.verifikasiAkun != null) {
      state = AsyncData(NavigasiAuthModel(tujuan: '', message: res.message));
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
      state = AsyncData(NavigasiAuthModel(tujuan: '', message: res.message));
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  Future<void> masuk({required String noHp, required String kodeOtp}) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.masuk(noHp: noHp, kodeOtp: kodeOtp);
    if (res.token != null) {
      _berhasilMasuk(res: res, tujuan: 'ORTU_PAGE');
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
      _berhasilMasuk(res: res, tujuan: 'POSYANDU_PAGE');
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  void keluar() {
    _authLocalRepository.removeUser();
    _penggunaAktifNotifier.hapusPenggunaAktif();
  }

  void _berhasilMasuk({
    required AuthResponseModel res,
    required String tujuan,
  }) {
    final token = res.token!;
    final UserModel user = res.userOrangTua != null
        ? UserModel(token: token, data: Left(res.userOrangTua!))
        : UserModel(token: token, data: Right(res.userPosyandu!));

    _authLocalRepository.setUser(user);
    _penggunaAktifNotifier.aturPenggunaAktif(user);
    state = AsyncData(NavigasiAuthModel(tujuan: tujuan, message: res.message));
  }

  void _berhasilPerbaruiProfil({
    required AuthResponseModel res,
    required String tujuan,
  }) {
    final user = _penggunaAktifNotifier.state;
    final UserModel newUser = res.userOrangTua != null
        ? UserModel(token: user!.token, data: Left(res.userOrangTua!))
        : UserModel(token: user!.token, data: Right(res.userPosyandu!));
    _penggunaAktifNotifier.aturPenggunaAktif(newUser);
    state = AsyncData(NavigasiAuthModel(tujuan: tujuan, message: res.message));
  }
}
