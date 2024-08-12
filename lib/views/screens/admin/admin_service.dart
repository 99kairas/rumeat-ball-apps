import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:rumeat_ball_apps/models/admin_get_all_order_response.dart';
import 'package:rumeat_ball_apps/models/get_all_categories_response.dart';
import 'package:rumeat_ball_apps/models/get_all_menu_response.dart';
import 'package:rumeat_ball_apps/models/get_all_order_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class AdminService {
  Dio dio = Dio();
  Future<GetAllMenuResponse> getAllMenu() async {
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/menu',
      );
      return GetAllMenuResponse.fromJson(response.data);
    } on DioException catch (e) {
      return GetAllMenuResponse.fromJson(e.response?.data);
    }
  }

  Future<AdminGetAllOrderResponse> fetchOrders() async {
    final token = await SharedPref.getToken();
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/admin/order',
        options: Options(
          headers: APIConstant.auth('$token'),
        ),
      );
      return AdminGetAllOrderResponse.fromJson(response.data);
    } on DioException catch (e) {
      return AdminGetAllOrderResponse.fromJson(e.response?.data ?? {});
    }
  }

  Future<GetAllCategoriesResponse> getAllCategories() async {
    try {
      final response = await dio.get('${APIConstant.baseUrl}/category');
      print('Response data: ${response.data}'); // Tambahkan print statement
      return GetAllCategoriesResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('Error: ${e.message}'); // Tambahkan print statement untuk error
      return GetAllCategoriesResponse.fromJson(e.response?.data);
    }
  }

  Future<bool> editMenu(String menuId, String menuName, String description,
      double price, String? categoryId, File? image) async {
    final token = await SharedPref.getToken();
    try {
      var form = FormData();
      form.fields.add(MapEntry("name", menuName));
      form.fields.add(MapEntry("price", price.toString()));
      form.fields.add(MapEntry("description", description));
      if (categoryId != null) {
        form.fields.add(MapEntry("category_id", categoryId));
      }
      if (image != null) {
        String filename = image.path.split('/').last;
        var mediaType = MediaType.parse(
            lookupMimeType(image.path) ?? "application/octet-stream");
        var n = image.lengthSync();
        var mFile = MultipartFile(image.openRead(0, n), n,
            filename: filename, contentType: mediaType);
        form.files.add(MapEntry("image", mFile));
      }

      final response = await dio.put(
        '${APIConstant.baseUrl}/admin/menu/$menuId',
        data: form,
        options: Options(
          headers: APIConstant.auth("$token"),
        ),
      );
      print(response);
      return response.statusCode == 200;
    } on DioException catch (e) {
      return false;
    }
  }

  Future<bool> addMenu(String menuName, String description, double price,
      String? categoryId, File? image) async {
    final token = await SharedPref.getToken();
    try {
      var form = FormData();
      form.fields.add(MapEntry("name", menuName));
      form.fields.add(MapEntry("price", price.toString()));
      form.fields.add(MapEntry("description", description));
      if (categoryId != null) {
        form.fields.add(MapEntry("category_id", categoryId));
      }
      if (image != null) {
        String filename = image.path.split('/').last;
        var mediaType = MediaType.parse(
            lookupMimeType(image.path) ?? "application/octet-stream");
        var n = image.lengthSync();
        var mFile = MultipartFile(image.openRead(0, n), n,
            filename: filename, contentType: mediaType);
        form.files.add(MapEntry("image", mFile));
      }

      final response = await dio.post(
        '${APIConstant.baseUrl}/admin/menu',
        data: form,
        options: Options(
          headers: APIConstant.auth("$token"),
        ),
      );
      print(response);
      return response.statusCode == 201;
    } on DioException catch (e) {
      return false;
    }
  }

  Future<bool> deleteMenu(String menuId) async {
    final token = await SharedPref.getToken();
    try {
      final response = await dio.delete(
        '${APIConstant.baseUrl}/admin/menu/$menuId',
        options: Options(
          headers: APIConstant.auth("$token"),
        ),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      return false;
    }
  }
}
