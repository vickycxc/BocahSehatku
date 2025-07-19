import 'package:app/core/providers/current_user_notifier.dart';
import 'package:app/core/model/user_orang_tua_model.dart';
import 'package:app/core/model/user_posyandu_model.dart';
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
        _berhasilAmbilDataPengguna(res);
      }
    }
  }

  Future<void> kirimOtp({required String noHp, required String tujuan}) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.kirimOtp(
      noHp: noHp,
      tujuan: tujuan,
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
    final token = res.token;
    _authLocalRepository.setToken(token);
    final Either<UserOrangTuaModel, UserPosyanduModel> user =
        res.userOrangTua != null
        ? Left(res.userOrangTua!)
        : Right(res.userPosyandu!);
    _currentUserNotifier.addUser(user);
    state = AsyncData(res.message);
  }

  void _berhasilAmbilDataPengguna(AuthResponse res) {
    final Either<UserOrangTuaModel, UserPosyanduModel> user =
        res.userOrangTua != null
        ? Left(res.userOrangTua!)
        : Right(res.userPosyandu!);
    _currentUserNotifier.addUser(user);
  }
}
