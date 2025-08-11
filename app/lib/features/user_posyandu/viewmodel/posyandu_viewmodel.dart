import 'package:app/core/model/pengukuran_model.dart';
import 'package:app/features/user_posyandu/repositories/posyandu_local_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posyandu_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class PosyanduViewModel extends _$PosyanduViewModel {
  late PosyanduLocalRepository _posyanduLocalRepository;

  @override
  Future<List<PengukuranModel>> build() async {
    state = const AsyncLoading();
    _posyanduLocalRepository = await ref.read(
      posyanduLocalRepositoryProvider.future,
    );
    return await _getPengukuran();
  }

  Future<List<PengukuranModel>> _getPengukuran() async {
    return await _posyanduLocalRepository.ambilDataPengukuran();
  }

  // Future<void> tambahDataAnak(AnakModel anak) async {
  //   state = const AsyncLoading();
  //   final newAnak = anak.copyWith(orangTuaId: _orangTua.id);
  //   await _posyanduLocalRepository.tambahDataAnak(newAnak);
  //   state = AsyncValue.data(await _getPengukuran());
  // }

  // Future<void> perbaruiDataAnak(AnakModel anak) async {
  //   state = const AsyncLoading();
  //   await _posyanduLocalRepository.perbaruiDataAnak(anak);
  //   state = AsyncValue.data(await _getPengukuran());
  // }

  // Future<void> hapusDataAnak(int localId) async {
  //   state = const AsyncLoading();
  //   await _posyanduLocalRepository.hapusDataAnak(localId);
  //   state = AsyncValue.data(await _getPengukuran());
  // }

  // Future<void> segarkan() async {
  //   state = AsyncValue.data(await _getPengukuran());
  // }
}
