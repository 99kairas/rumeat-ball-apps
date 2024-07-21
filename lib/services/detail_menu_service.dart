import 'package:dio/dio.dart';
import 'package:rumeat_ball_apps/models/get_detail_menu_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class DetailMenuService {
  Dio dio = Dio();
  Future<GetDetailMenuResponse> getDetailMenu({String? menuID}) async {
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/menu/$menuID',
      );
      print(response.data);
      return GetDetailMenuResponse.fromJson(response.data);
    } on DioException catch (e) {
      return GetDetailMenuResponse.fromJson(e.response?.data);
    }
  }
}
