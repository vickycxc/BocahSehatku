import 'dart:convert';

import 'package:app/core/constants.dart';
import 'package:app/core/failure/app_failure.dart';
import 'package:app/core/model/user_orang_tua_model.dart';
import 'package:app/core/model/user_posyandu_model.dart';
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
  Future<Either<AppFailure, Either<UserOrangTuaModel, UserPosyanduModel>>>
  daftar({required String noHp, required String kodeOtp}) async {
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
      return Right(
        (Left(
          UserOrangTuaModel.fromMap(resBodyMap['userOrangTua']).copyWith(
            token: resBodyMap['token'],
            message: resBodyMap['message'],
          ),
        )),
      );
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }

  Future<Either<AppFailure, Either<UserOrangTuaModel, UserPosyanduModel>>>
  masuk({required String noHp, required String kodeOtp}) async {
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
      return Right(
        (Left(
          UserOrangTuaModel.fromMap(resBodyMap['userOrangTua']).copyWith(
            token: resBodyMap['token'],
            message: resBodyMap['message'],
          ),
        )),
      );
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }

  Future<void> masukPosyandu() async {}
  Future<void> ubahNoHp() async {}
  Future<Either<AppFailure, Either<UserOrangTuaModel, UserPosyanduModel>>>
  ambilDataPenggunaSaatIni(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.serverUrl}/auth'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(AppFailure(resBodyMap['message']));
      }

      if (resBodyMap['userOrangTua'] != null) {
        return Right(
          Left(
            UserOrangTuaModel.fromMap(
              resBodyMap['userOrangTua'],
            ).copyWith(token: token, message: resBodyMap['message']),
          ),
        );
      }

      if (resBodyMap['userPosyandu'] != null) {
        return Right(
          Right(
            UserPosyanduModel.fromMap(
              resBodyMap['userPosyandu'],
            ).copyWith(token: token, message: resBodyMap['message']),
          ),
        );
      }
      throw Exception('Format tidak sesuai');
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }
}
