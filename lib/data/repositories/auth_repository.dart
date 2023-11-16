// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:savio/constants/constant.dart';

class AuthRepository {
  final Dio dio;
  AuthRepository({
    required this.dio,
  });
  Future<String> login(String email, String password) async {
    try {
      final response = await dio.post(
        UserApiConstants.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      return response.data["token"];
    } on DioException catch (e) {
      final String error = e.response!.data['non_field_errors'][0];
      throw Exception(error);
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name,
      required String city,
      File? profilePic}) async {
    try {
      await dio.post(
        UserApiConstants.create,
        data: FormData.fromMap({
          "email": email,
          "password": password,
          "name": name,
          "city": city,
          "profile_pic": profilePic != null
              ? await MultipartFile.fromFile(
                  profilePic.path,
                )
              : null,
        }),
      );
    } on DioException catch (e) {
      final map = e.response!.data as Map<String, dynamic>;
      for (var key in map.keys) {
        final error = map[key] as List<dynamic>;
        throw Exception("$key: ${error.first}");
      }
    }
  }
}
