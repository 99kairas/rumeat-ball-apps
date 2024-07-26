import 'package:dio/dio.dart';
import 'package:rumeat_ball_apps/models/detail_order_history_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class DetailOrderHistoryService {
  final Dio dio = Dio();

  Future<DetailsOrderHistory?> getDetailsOrderHistory({String? orderID}) async {
    final token = await SharedPref.getToken();
    try {
      final response = await dio.get(
        '${APIConstant.baseUrl}/users/order/$orderID',
        options: Options(
          headers: APIConstant.auth('$token'),
        ),
      );
      final parsedResponse = GetDetailsOrderHistoryResponse.fromJson(response.data);
      return parsedResponse.response;
    } on DioException catch (e) {
      return GetDetailsOrderHistoryResponse.fromJson(e.response?.data).response;
    }
  }
}
