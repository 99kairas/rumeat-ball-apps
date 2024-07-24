import 'package:dio/dio.dart';
import 'package:rumeat_ball_apps/models/get_order_by_id_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class CheckoutService {
  Dio dio = Dio();

  Future<GetOrderByIdResponse> getOrderByID({String? orderID}) async {
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/users/order/$orderID',
      );
      return GetOrderByIdResponse.fromJson(response.data);
    } on DioException catch (e) {
      return GetOrderByIdResponse.fromJson(e.response?.data);
    }
  }
}
