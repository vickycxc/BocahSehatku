import 'package:app/core/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengguna_aktif_notifier.g.dart';

@Riverpod(keepAlive: true)
class PenggunaAktifNotifier extends _$PenggunaAktifNotifier {
  @override
  UserModel? build() {
    return null;
  }

  void aturPenggunaAktif(UserModel user) {
    state = user;
  }

  void hapusPenggunaAktif() {
    state = null;
  }
}
