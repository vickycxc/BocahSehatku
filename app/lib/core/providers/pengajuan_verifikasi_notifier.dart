import 'package:app/features/auth/model/verifikasi_akun_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengajuan_verifikasi_notifier.g.dart';

@riverpod
class PengajuanVerifikasiNotifier extends _$PengajuanVerifikasiNotifier {
  @override
  VerifikasiPenggunaModel? build() {
    return null;
  }

  void aturPengajuanVerifikasi(VerifikasiPenggunaModel verification) {
    state = verification;
  }

  void hapusPengajuanVerifikasi() {
    state = null;
  }
}
