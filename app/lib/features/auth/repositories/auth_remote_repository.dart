import 'dart:convert';

import 'package:app/core/constants.dart';
import 'package:app/core/failure/app_failure.dart';
import 'package:app/features/auth/model/user_orang_tua_model.dart';
import 'package:app/features/auth/model/user_posyandu_model.dart';
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
  Future<Either<AppFailure, (String, UserOrangTuaModel)>> daftar({
    required String noHp,
    required String kodeOtp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/daftar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHp': noHp, 'kodeOtp': kodeOtp}),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(AppFailure(resBodyMap['message']));
      }
      return Right((
        resBodyMap['message'],
        UserOrangTuaModel.fromMap(
          resBodyMap['userOrangTua'],
        ).copyWith(token: resBodyMap['token']),
      ));
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }

  Future<Either<AppFailure, (String, UserOrangTuaModel)>> masuk({
    required String noHp,
    required String kodeOtp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverUrl}/auth/masuk'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'noHp': noHp, 'kodeOtp': kodeOtp}),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(AppFailure(resBodyMap['message']));
      }
      return Right((
        resBodyMap['message'],
        UserOrangTuaModel.fromMap(resBodyMap['userOrangTua']),
      ));
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }

  Future<void> masukPosyandu() async {}
  Future<void> ubahNoHp() async {}
  Future<
    Either<AppFailure, (String, Either<UserOrangTuaModel, UserPosyanduModel>)>
  >
  ambilDataPenggunaSaatIni(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.serverUrl}/auth/masuk'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(AppFailure(resBodyMap['message']));
      }

      if (resBodyMap['userOrangTua'] != null) {
        return Right((
          resBodyMap['message'],
          Left(
            UserOrangTuaModel.fromMap(
              resBodyMap['userOrangTua'],
            ).copyWith(token: token),
          ),
        ));
      }

      if (resBodyMap['userPosyandu'] != null) {
        return Right((
          resBodyMap['message'],
          Right(resBodyMap['userPosyandu']),
        ));
      }
      throw Exception('Format tidak sesuai');
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }
}
