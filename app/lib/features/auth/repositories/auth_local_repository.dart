import 'package:app/core/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(Ref ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setUser(UserModel? user) {
    if (user != null) {
      final userJson = user.toJson();
      _sharedPreferences.setString('user', userJson);
    }
  }

  UserModel? getUser() {
    final userJson = _sharedPreferences.getString('user');
    if (userJson != null) {
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  void removeUser() {
    _sharedPreferences.remove('user');
  }
}
