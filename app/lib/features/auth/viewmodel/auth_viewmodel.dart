import 'package:app/core/model/user_model.dart';
import 'package:app/core/providers/current_user_notifier.dart';
import 'package:app/core/model/orang_tua_model.dart';
import 'package:app/features/auth/model/auth_response.dart';
import 'package:app/features/auth/repositories/auth_local_repository.dart';
import 'package:app/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<String>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);

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
    if (res.suksesMengirimOtp == true) {
      state = AsyncData(res.message);
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
    final user = _currentUserNotifier.state;
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

  Future<void> masuk({required String noHp, required String kodeOtp}) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.masuk(noHp: noHp, kodeOtp: kodeOtp);
    if (res.token != null) {
      _berhasilMasuk(res);
    } else {
      state = AsyncError(res.message, StackTrace.current);
    }
  }

  void keluar() {
    _authLocalRepository.removeToken();
    _currentUserNotifier.removeUser();
  }

  void _berhasilMasuk(AuthResponse res) {
    final token = res.token!;
    _authLocalRepository.setToken(token);
    final UserModel user = res.userOrangTua != null
        ? UserModel(token: token, data: Left(res.userOrangTua!))
        : UserModel(token: token, data: Right(res.userPosyandu!));
    _currentUserNotifier.setUser(user);
    state = AsyncData(res.message);
  }

  void _berhasilPerbaruiProfil(AuthResponse res) {
    final user = _currentUserNotifier.state;
    final UserModel newUser = res.userOrangTua != null
        ? UserModel(token: user!.token, data: Left(res.userOrangTua!))
        : UserModel(token: user!.token, data: Right(res.userPosyandu!));
    _currentUserNotifier.setUser(newUser);
    state = AsyncData(res.message);
  }

  void _berhasilAmbilDataPengguna(AuthResponse res, String token) {
    final UserModel user = res.userOrangTua != null
        ? UserModel(token: token, data: Left(res.userOrangTua!))
        : UserModel(token: token, data: Right(res.userPosyandu!));
    _currentUserNotifier.setUser(user);
  }
}
