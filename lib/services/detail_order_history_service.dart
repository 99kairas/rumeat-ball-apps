import 'package:dio/dio.dart';
import 'package:rumeat_ball_apps/models/detail_order_history_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class DetailOrderHistoryService {
  final Dio _dio = Dio();

  Future<OrderDetails> fetchOrderDetails(String orderId) async {
    final response = await _dio.get('${APIConstant.baseUrl}/users/order/$orderId');
    if (response.statusCode == 200) {
      return OrderDetails.fromJson(response.data);
    } else {
      throw Exception('Failed to load order details');
    }
  }
}
