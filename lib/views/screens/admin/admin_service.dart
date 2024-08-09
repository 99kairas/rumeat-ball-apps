import 'package:dio/dio.dart';
import 'package:rumeat_ball_apps/models/admin_get_all_order_response.dart';
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
}
