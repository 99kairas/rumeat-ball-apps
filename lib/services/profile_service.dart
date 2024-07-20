import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/get_user_profile_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class ProfileService with ChangeNotifier {
  Dio dio = Dio();

  Future<GetUserProfileResponse> getUserProfile() async {
    final token = await SharedPref.getToken();
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/users/profile',
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
      );
      return GetUserProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      return GetUserProfileResponse.fromJson(e.response?.data);
    }
  }
}
