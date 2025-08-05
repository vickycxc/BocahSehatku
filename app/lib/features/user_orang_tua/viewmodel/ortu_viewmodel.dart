import 'package:app/core/model/anak_model.dart';
import 'package:app/core/model/orang_tua_model.dart';
import 'package:app/core/providers/pengguna_aktif_notifier.dart';
import 'package:app/features/user_orang_tua/repositories/ortu_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ortu_viewmodel.g.dart';

@riverpod
class OrtuViewModel extends _$OrtuViewModel {
  late OrtuLocalRepository _ortuLocalRepository;
  late OrangTuaModel _orangTua;

  @override
  Future<List<AnakModel>> build() async {
    _ortuLocalRepository = await ref.watch(authLocalRepositoryProvider.future);
    final currentUser = ref.watch(penggunaAktifNotifierProvider);
    switch (currentUser!.data) {
      case Left(value: final l):
        _orangTua = l;
        break;
      case Right():
        throw Exception('Pengguna tidak ditemukan');
    }
    final listAnak = await _ortuLocalRepository.ambilDataAnak();
    return listAnak;
  }

  Future<void> tambahDataAnak({
    required String nama,
    required String tanggalLahir,
    required String jenisKelamin,
    String? nik,
    double? bbLahir,
    double? tbLahir,
    int? mingguLahir,
  }) async {
    state = const AsyncLoading();
    await _ortuLocalRepository.tambahDataAnak(
      nama: nama,
      tanggalLahir: tanggalLahir,
      jenisKelamin: jenisKelamin,
      nik: nik,
      bbLahir: bbLahir,
      tbLahir: tbLahir,
      mingguLahir: mingguLahir,
      orangTuaId: _orangTua.id,
    );
    state = AsyncValue.data(await _ortuLocalRepository.ambilDataAnak());
  }

  Future<void> perbaruiDataAnak(AnakModel anak) async {
    state = const AsyncLoading();
    await _ortuLocalRepository.perbaruiDataAnak(anak);
    state = AsyncValue.data(await _ortuLocalRepository.ambilDataAnak());
  }

  Future<void> hapusDataAnak(int localId) async {
    state = const AsyncLoading();
    await _ortuLocalRepository.hapusDataAnak(localId);
    state = AsyncValue.data(await _ortuLocalRepository.ambilDataAnak());
  }
}
