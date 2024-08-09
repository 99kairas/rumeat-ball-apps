import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/detail_order_history_response.dart';
import 'package:rumeat_ball_apps/services/detail_order_history_service.dart';

class DetailsOrderHistoryViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DetailsOrderHistory? _orderHistoryItems;
  DetailsOrderHistory? get orderHistoryItems => _orderHistoryItems;

  void getDetailsOrderHistory(BuildContext context, {String? orderID}) async {
    try {
      _isLoading = true;
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();
      final result = await DetailOrderHistoryService()
          .getDetailsOrderHistory(orderID: orderID);
      if (result != null) {
        _orderHistoryItems = result;
        print("Order History ID in ViewModel: ${_orderHistoryItems?.id}");
      } else {
        print("Result is null");
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Error in ViewModel: $e");
      throw e;
    }
  }
}
