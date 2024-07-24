import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/detail_order_history_response.dart';
import 'package:rumeat_ball_apps/services/detail_order_history_service.dart';

class DetailsOrderHistoryViewModel extends ChangeNotifier {
  final DetailOrderHistoryService _orderService = DetailOrderHistoryService();
  OrderDetails? _orderDetails;
  bool _isLoading = false;

  OrderDetails? get orderDetails => _orderDetails;
  bool get isLoading => _isLoading;

  Future<void> fetchOrderDetails(String orderId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _orderDetails = await _orderService.fetchOrderDetails(orderId);
    } catch (e) {
      print('Error fetching order details: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
