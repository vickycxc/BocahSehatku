import 'dart:convert';

import 'package:app/core/falure/app_failure.dart';
import 'package:app/features/auth/model/user_orang_tua_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  // TODO add connection timeout
  Future<Either<AppFailure, UserOrangTuaModel>> daftar({
    required String noHp,
    required String kodeOtp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.88.19:3000/api/auth/daftar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHp': noHp, 'kodeOtp': kodeOtp}),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(AppFailure(resBodyMap['message']));
      }
      return Right(UserOrangTuaModel.fromMap(resBodyMap['userOrangTua']));
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }

  Future<Either<AppFailure, UserOrangTuaModel>> masuk({
    required String noHp,
    required String kodeOtp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.88.19:3000/api/auth/masuk'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHp': noHp, 'kodeOtp': kodeOtp}),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(AppFailure(resBodyMap['message']));
      }
      return Right(UserOrangTuaModel.fromMap(resBodyMap['userOrangTua']));
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }

  Future<void> masukPosyandu() async {}
  Future<void> ubahNoHp() async {}
}
