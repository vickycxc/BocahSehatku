import 'package:app/core/providers/current_user_notifier.dart';
import 'package:app/core/model/user_orang_tua_model.dart';
import 'package:app/core/model/user_posyandu_model.dart';
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
  AsyncValue<Either<UserOrangTuaModel, UserPosyanduModel>>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);

    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  Future<void> daftar({required String noHp, required String kodeOtp}) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.daftar(
      noHp: noHp,
      kodeOtp: kodeOtp,
    );
    final val = switch (res) {
      Left(value: final l) => state = AsyncError(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncData(r),
    };
    print(val);
  }

  Future<void> masuk({required String noHp, required String kodeOtp}) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.masuk(noHp: noHp, kodeOtp: kodeOtp);
    final val = switch (res) {
      Left(value: final l) => state = AsyncError(l.message, StackTrace.current),
      Right(value: final r) => _berhasilMasuk(r),
    };
    print(val);
  }

  AsyncValue<Either<UserOrangTuaModel, UserPosyanduModel>>? _berhasilMasuk(
    Either<UserOrangTuaModel, UserPosyanduModel> r1,
  ) {
    final token = switch (r1) {
      Left(value: final l2) => l2.token,
      Right(value: final r2) => r2.token,
    };
    _authLocalRepository.setToken(token);
    _currentUserNotifier.addUser(r1);
    state = AsyncData(r1);
    return null;
  }

  Future<Either<UserOrangTuaModel, UserPosyanduModel>?>
  ambilDataPengguna() async {
    state = const AsyncLoading();
    final token = _authLocalRepository.getToken();
    if (token != null) {
      final res = await _authRemoteRepository.ambilDataPenggunaSaatIni(token);
      final val = switch (res) {
        Left(value: final l) => state = AsyncError(
          l.message,
          StackTrace.current,
        ),
        Right(value: final r) => _berhasilAmbilDataPengguna(r),
      };
      return val.value;
    }
    return null;
  }

  AsyncValue<Either<UserOrangTuaModel, UserPosyanduModel>>
  _berhasilAmbilDataPengguna(
    Either<UserOrangTuaModel, UserPosyanduModel> user,
  ) {
    _currentUserNotifier.addUser(user);
    return state = AsyncData((user));
  }
}
