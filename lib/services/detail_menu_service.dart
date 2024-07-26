import 'package:dio/dio.dart';
import 'package:rumeat_ball_apps/models/get_detail_menu_response.dart';
import 'package:rumeat_ball_apps/models/get_order_by_id_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class DetailMenuService {
  Dio dio = Dio();
  Future<GetDetailMenuResponse> getDetailMenu({String? menuID}) async {
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/menu/$menuID',
      );
      return GetDetailMenuResponse.fromJson(response.data);
    } on DioException catch (e) {
      return GetDetailMenuResponse.fromJson(e.response?.data);
    }
  }

  Future createOrder(List<Map<String, dynamic>> orderItems) async {
    final token = await SharedPref.getToken();
    try {
      final response = await dio.post(
        '${APIConstant.baseUrl}/users/order',
        data: {
          'items': orderItems,
        },
        options: Options(headers: APIConstant.auth("${token}")),
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<GetOrderByIdResponse> getOrderByID({String? orderID}) async {
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/users/order/$orderID',
      );
      print("ini adalah detail menu service : $orderID");
      return GetOrderByIdResponse.fromJson(response.data);
    } on DioException catch (e) {
      return GetOrderByIdResponse.fromJson(e.response?.data);
    }
  }
}
