import 'package:app/core/model/anak_model.dart';
import 'package:app/core/model/orang_tua_model.dart';
import 'package:app/core/providers/pengguna_aktif_notifier.dart';
import 'package:app/features/user_orang_tua/model/riwayat_kunjungan_model.dart';
import 'package:app/features/user_orang_tua/model/user_ortu_model.dart';
import 'package:app/features/user_orang_tua/repositories/ortu_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ortu_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class OrtuViewModel extends _$OrtuViewModel {
  late OrtuLocalRepository _ortuLocalRepository;
  late OrangTuaModel _orangTua;

  @override
  Future<UserOrtuModel> build() async {
    state = const AsyncLoading();
    _ortuLocalRepository = await ref.read(authLocalRepositoryProvider.future);
    final currentUser = ref.read(penggunaAktifNotifierProvider);
    switch (currentUser!.data) {
      case Left(value: final l):
        _orangTua = l;
        break;
      case Right():
        throw Exception('Pengguna tidak ditemukan');
    }
    return await _getUserOrtuModel();
  }

  Future<UserOrtuModel> _getUserOrtuModel() async {
    final listAnak = await _ortuLocalRepository.ambilDataAnak();
    return UserOrtuModel(
      listAnak: listAnak,
      listRiwayatKunjungan: _getRiwayatKunjungan(listAnak),
    );
  }

  List<RiwayatKunjunganModel> _getRiwayatKunjungan(List<AnakModel> listAnak) {
    List<RiwayatKunjunganModel> riwayatKunjungan = [];
    for (final anak in listAnak) {
      if (anak.pengukuran == null) continue;
      for (final pengukuran in anak.pengukuran!) {
        // Tambahkan pengecekan untuk memastikan nama posyandu dan tanggal pengukuran tidak duplikat
        if (riwayatKunjungan.any(
          (item) =>
              item.namaPosyandu == pengukuran.namaPosyandu &&
              item.tanggalKunjungan == pengukuran.tanggalPengukuran,
        )) {
          continue;
        }
        riwayatKunjungan.add(
          RiwayatKunjunganModel(
            namaPosyandu: pengukuran.namaPosyandu!,
            tanggalKunjungan: pengukuran.tanggalPengukuran,
          ),
        );
      }
    }
    return riwayatKunjungan;
  }

  Future<void> tambahDataAnak(AnakModel anak) async {
    state = const AsyncLoading();
    final newAnak = anak.copyWith(orangTuaId: _orangTua.id);
    await _ortuLocalRepository.tambahDataAnak(newAnak);
    state = AsyncValue.data(await _getUserOrtuModel());
  }

  Future<void> perbaruiDataAnak(AnakModel anak) async {
    state = const AsyncLoading();
    await _ortuLocalRepository.perbaruiDataAnak(anak);
    state = AsyncValue.data(await _getUserOrtuModel());
  }

  Future<void> hapusDataAnak(int localId) async {
    state = const AsyncLoading();
    await _ortuLocalRepository.hapusDataAnak(localId);
    state = AsyncValue.data(await _getUserOrtuModel());
  }

  Future<void> segarkan() async {
    state = AsyncValue.data(await _getUserOrtuModel());
  }
}
