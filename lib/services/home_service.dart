import 'package:dio/dio.dart';
import 'package:rumeat_ball_apps/models/get_all_categories_response.dart';
import 'package:rumeat_ball_apps/models/get_all_menu_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class HomeService {
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

  Future<GetAllCategoriesResponse> getAllCategories() async {
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/category',
      );
      return GetAllCategoriesResponse.fromJson(response.data);
    } on DioException catch (e) {
      return GetAllCategoriesResponse.fromJson(e.response?.data);
    }
  }


}
