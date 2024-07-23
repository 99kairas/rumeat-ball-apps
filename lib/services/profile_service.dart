import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
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
          headers: APIConstant.auth('$token'),
        ),
      );
      return GetUserProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      return GetUserProfileResponse.fromJson(e.response?.data);
    }
  }

  Future<bool> updateProfile({String? address, String? phone}) async {
    final token = await SharedPref.getToken();
    try {
      FormData formData = FormData.fromMap({
        'address': address,
        'phone': phone,
      });
      final response = await dio.put(
        '${APIConstant.baseUrl}/users/profile',
        data: formData,
        options: Options(
          headers: APIConstant.auth('$token'),
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateFotoProfile() async {
    final token = await SharedPref.getToken();
    var dio = Dio();
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      var resolver = MimeTypeResolver();

      if (result != null) {
        File file = File(result.files.single.path ?? " ");
        String filename = file.path.split('/').last;
        var mediaType = MediaType.parse(
            resolver.lookup(file.path) ?? "application/octet-stream");
        var n = file.lengthSync();
        var mFile = MultipartFile(file.openRead(0, n), n,
            filename: filename, contentType: mediaType);

        var form = FormData();

        form.files.add(MapEntry("profile_image", mFile));

        final response = await dio.put(
          '${APIConstant.baseUrl}/users/profile',
          data: form,
          options: Options(
            headers: APIConstant.auth("$token"),
          ),
        );
        if (response.statusCode == 200) {
          return true;
        }
      } else {
        return false;
      }
      return true;
    } on DioException catch (e) {
      e.message;
      return false;
    }
  }
}
