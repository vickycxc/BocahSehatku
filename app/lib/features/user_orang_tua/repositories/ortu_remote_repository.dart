import 'dart:convert';

import 'package:app/core/constants/constants.dart';
import 'package:app/core/model/anak_model.dart';
import 'package:app/features/user_orang_tua/model/ortu_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'ortu_remote_repository.g.dart';

@riverpod
OrtuRemoteRepository authRemoteRepository(Ref ref) {
  return OrtuRemoteRepository();
}

class OrtuRemoteRepository {
  Future<OrtuResponseModel> ambilDataSinkronisasi({
    required DateTime sinkronisasiTerakhir,
    required String token,
  }) async {
    try {
      final queryParams = {
        'sinkronisasiTerakhir': sinkronisasiTerakhir.toIso8601String(),
      };
      final response = await http.get(
        Uri.http(Constants.serverUrl, '/ortu/sinkron', queryParams),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      if (response.statusCode == 200) {
        return OrtuResponseModel.fromJson(response.body).copyWith(sukses: true);
      } else {
        return OrtuResponseModel.fromJson(
          response.body,
        ).copyWith(sukses: false);
      }
    } catch (error) {
      return OrtuResponseModel(sukses: false, message: error.toString());
    }
  }

  Future<OrtuResponseModel> unggahDataSinkronisasi({
    List<AnakModel>? listAnak,
    required String token,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${Constants.serverUrl}/ortu/sinkron'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        body: jsonEncode({
          'listAnak': listAnak?.map((e) => e.toMap()).toList(),
        }),
      );

      if (response.statusCode == 200) {
        return OrtuResponseModel.fromJson(response.body).copyWith(sukses: true);
      } else {
        return OrtuResponseModel.fromJson(
          response.body,
        ).copyWith(sukses: false);
      }
    } catch (error) {
      return OrtuResponseModel(sukses: false, message: error.toString());
    }
  }
}
