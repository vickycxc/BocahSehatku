import 'dart:convert';

import 'package:app/core/constants.dart';
import 'package:app/features/auth/model/auth_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  // TODO add connection timeout

  Future<AuthResponse> kirimOtp({
    required String noHp,
    required String tujuan,
    String? nik,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/kirim-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHp': noHp, 'tujuan': tujuan, 'nik': nik}),
      );

      print(response.body);
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(
          response.body,
        ).copyWith(suksesMengirimOtp: true);
      } else {
        return AuthResponse.fromJson(
          response.body,
        ).copyWith(suksesMengirimOtp: false);
      }
    } catch (error) {
      return AuthResponse(message: error.toString(), suksesMengirimOtp: false);
    }
  }

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

  Future<AuthResponse> perbaruiProfil({
    required String token,
    required int id,
    required String nama,
    required String nik,
    required String jenisKelamin,
    required String alamat,
    required int posyanduId,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${Constants.serverUrl}/auth/perbarui-profil'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        body: jsonEncode({
          'id': id,
          'nama': nama,
          'nik': nik,
          'jenisKelamin': jenisKelamin,
          'alamat': alamat,
          'posyanduId': posyanduId,
        }),
      );
      return AuthResponse.fromJson(response.body);
    } catch (error) {
      return AuthResponse(message: error.toString());
    }
  }
}
