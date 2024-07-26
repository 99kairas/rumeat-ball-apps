import 'package:dio/dio.dart';
import 'package:rumeat_ball_apps/models/checkout_model.dart';
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

  Future<TransactionModel> createTransaction(String orderId, double totalAmount) async {
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/users/transaction',
        data: {
          "order_id": orderId,
          "total_amount": totalAmount,
        }
      );

      if (response.statusCode == 200) {
        return TransactionModel.fromJson(response.data['response']);
      } else {
        throw Exception('Failed to create order');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
