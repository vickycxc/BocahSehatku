// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/model/user_model.dart';
import 'package:app/core/providers/shared_preferences_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesNotifierProvider)!;
  return AuthLocalRepository(sharedPreferences);
}

class AuthLocalRepository {
  final SharedPreferences sharedPreferences;
  AuthLocalRepository(this.sharedPreferences);

  void setUser(UserModel? user) {
    if (user != null) {
      final userJson = user.toJson();
      sharedPreferences.setString('user', userJson);
    }
  }

  UserModel? getUser() {
    final userJson = sharedPreferences.getString('user');
    if (userJson != null) {
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  void removeUser() {
    sharedPreferences.remove('user');
  }
}
