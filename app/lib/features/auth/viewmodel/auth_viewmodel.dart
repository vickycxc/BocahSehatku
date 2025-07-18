import 'package:app/features/auth/model/user_orang_tua_model.dart';
import 'package:app/features/auth/model/user_posyandu_model.dart';
import 'package:app/features/auth/repositories/auth_local_repository.dart';
import 'package:app/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;

  @override
  AsyncValue<(String, Either<UserOrangTuaModel, UserPosyanduModel>)>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);

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
      Right(value: final r) => state = AsyncData((r.$1, Left(r.$2))),
    };
    print(val);
  }

  Future<void> masuk({required String noHp, required String kodeOtp}) async {
    state = const AsyncLoading();
    final res = await _authRemoteRepository.masuk(noHp: noHp, kodeOtp: kodeOtp);
    final val = switch (res) {
      Left(value: final l) => state = AsyncError(l.message, StackTrace.current),
      Right(value: final r) => _suksesMasuk(r),
    };
    print(val);
  }

  AsyncValue<(String, UserOrangTuaModel)>? _suksesMasuk(
    (String, UserOrangTuaModel) r,
  ) {
    _authLocalRepository.setToken(r.$2.token);
    state = AsyncData((r.$1, Left(r.$2)));
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
        Right(value: final r) => state = (AsyncData(r)),
      };
      return val.value?.$2;
    }
    return null;
  }
}
