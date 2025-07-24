import 'dart:convert';

import 'package:app/core/constants.dart';
import 'package:app/features/auth/model/auth_response_model.dart';
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

  Future<AuthResponseModel> kirimOtp({
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
      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.body).copyWith(sukses: true);
      } else {
        return AuthResponseModel.fromJson(
          response.body,
        ).copyWith(sukses: false);
      }
    } catch (error) {
      return AuthResponseModel(message: error.toString(), sukses: false);
    }
  }

  Future<AuthResponseModel> daftar({
    required String noHp,
    required String kodeOtp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/daftar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHp': noHp, 'kodeOtp': kodeOtp}),
      );
      return AuthResponseModel.fromJson(response.body);
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> perbaruiProfil({
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
      return AuthResponseModel.fromJson(response.body);
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> hapusAkun({required String token}) async {
    try {
      final response = await http.delete(
        Uri.parse('${Constants.serverUrl}/auth/hapus-akun'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.body).copyWith(sukses: true);
      } else {
        return AuthResponseModel.fromJson(
          response.body,
        ).copyWith(sukses: false);
      }
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> ubahNoHp({
    required String noHpBaru,
    required String kodeOtp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/masuk-posyandu'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHpBaru': noHpBaru, 'kodeOtp': kodeOtp}),
      );
      return AuthResponseModel.fromJson(response.body);
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> verifikasiOtp({
    required String noHp,
    required String kodeOtp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/verifikasi-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHp': noHp, 'kodeOtp': kodeOtp}),
      );
      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.body).copyWith(sukses: true);
      } else {
        return AuthResponseModel.fromJson(
          response.body,
        ).copyWith(sukses: false);
      }
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> ajukanUbahNoHp({
    required String noHpBaru,
    required String kodeOtp,
    required String nik,
    required int posyanduId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/ajukan-ubah-no-hp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'noHpBaru': noHpBaru,
          'kodeOtp': kodeOtp,
          'nik': nik,
          'posyanduId': posyanduId,
        }),
      );
      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.body).copyWith(sukses: true);
      } else {
        return AuthResponseModel.fromJson(
          response.body,
        ).copyWith(sukses: false);
      }
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> batalkanPengajuanUbahNoHp(String nik) async {
    try {
      final response = await http.delete(
        Uri.parse('${Constants.serverUrl}/auth/batalkan-ubah-no-hp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nik': nik}),
      );
      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.body).copyWith(sukses: true);
      } else {
        return AuthResponseModel.fromJson(
          response.body,
        ).copyWith(sukses: false);
      }
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> cekVerifikasiAkun(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.serverUrl}/auth/cek-verifikasi-akun'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      return AuthResponseModel.fromJson(response.body);
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> verifikasiAkun({
    required String nik,
    required String token,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${Constants.serverUrl}/auth/cek-verifikasi-akun'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        body: jsonEncode({'nik': nik}),
      );

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.body).copyWith(sukses: true);
      } else {
        return AuthResponseModel.fromJson(
          response.body,
        ).copyWith(sukses: false);
      }
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> masuk({
    required String noHp,
    required String kodeOtp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/masuk'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHp': noHp, 'kodeOtp': kodeOtp}),
      );
      return AuthResponseModel.fromJson(response.body);
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> masukPosyandu({
    required String kodePosyandu,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/masuk-posyandu'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'kodePosyandu': kodePosyandu, 'password': password}),
      );
      return AuthResponseModel.fromJson(response.body);
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }

  Future<AuthResponseModel> ambilDataPenggunaSaatIni(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.serverUrl}/auth'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      return AuthResponseModel.fromJson(response.body);
    } catch (error) {
      return AuthResponseModel(message: error.toString());
    }
  }
}
