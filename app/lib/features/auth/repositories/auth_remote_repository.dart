import 'dart:convert';

import 'package:app/core/constants.dart';
import 'package:app/core/failure/app_failure.dart';
import 'package:app/core/model/user_orang_tua_model.dart';
import 'package:app/core/model/user_posyandu_model.dart';
import 'package:app/features/auth/model/auth_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  // TODO add connection timeout
  Future<AuthResponse> daftar({
    required String noHp,
    required String kodeOtp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/daftar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHp': noHp, 'kodeOtp': kodeOtp}),
      );
      return AuthResponse.fromJson(response.body);
    } catch (error) {
      return AuthResponse(message: error.toString());
    }
  }

  Future<AuthResponse> masuk({
    required String noHp,
    required String kodeOtp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/masuk'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHp': noHp, 'kodeOtp': kodeOtp}),
      );
      return AuthResponse.fromJson(response.body);
    } catch (error) {
      return AuthResponse(message: error.toString());
    }
  }

  Future<void> masukPosyandu() async {}
  Future<void> ubahNoHp() async {}
  Future<AuthResponse> ambilDataPenggunaSaatIni(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.serverUrl}/auth'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      return AuthResponse.fromJson(response.body);
    } catch (error) {
      return AuthResponse(message: error.toString());
    }
  }
}
