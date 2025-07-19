import 'package:app/core/model/user_orang_tua_model.dart';
import 'package:app/core/model/user_posyandu_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  Either<UserOrangTuaModel, UserPosyanduModel>? build() {
    return null;
  }

  void addUser(Either<UserOrangTuaModel, UserPosyanduModel> user) {
    state = user;
  }

  void removeUser() {
    state = null;
  }
}
