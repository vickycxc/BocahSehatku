import 'package:app/core/model/anak_model.dart';
import 'package:app/features/user_orang_tua/repositories/ortu_local_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ortu_viewmodel.g.dart';

@riverpod
class OrtuViewModel extends _$OrtuViewModel {
  late OrtuLocalRepository _ortuLocalRepository;

  @override
  Future<List<AnakModel>> build() async {
    _ortuLocalRepository = await ref.watch(authLocalRepositoryProvider.future);
    final listAnak = await _ortuLocalRepository.ambilDataAnak();
    return listAnak;
  }

  // Future<void> ambilDataAnak() async {
  //   state = const AsyncLoading();
  //   try {
  //     final data = await _ortuLocalRepository.ambilDataAnak();
  //     state = AsyncData(data);
  //   } catch (e, st) {
  //     state = AsyncError(e, st);
  //   }
  // }
}
