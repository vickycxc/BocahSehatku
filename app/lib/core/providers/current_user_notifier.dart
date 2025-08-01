import 'package:app/features/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  UserModel? build() {
    return null;
  }

  void setUser(UserModel user) {
    state = user;
  }

  void removeUser() {
    state = null;
  }
}
