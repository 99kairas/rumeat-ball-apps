import 'package:dio/dio.dart';
import 'package:rumeat_ball_apps/models/get_all_order_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class OrderService {
  Dio dio = Dio();

  Future<GetAllOrderResponse> fetchOrders() async {
    final token = await SharedPref.getToken();
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/users/order',
        options: Options(
          headers: APIConstant.auth('$token'),
        ),
      );
      print("ini adalah order service : ${response.data}");
      return GetAllOrderResponse.fromJson(response.data);
    } on DioException catch (e) {
      return GetAllOrderResponse.fromJson(e.response?.data);
    }
  }
}
