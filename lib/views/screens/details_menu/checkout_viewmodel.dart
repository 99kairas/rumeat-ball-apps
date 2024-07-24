import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/get_order_by_id_response.dart';
import 'package:rumeat_ball_apps/services/checkout_service.dart';

class CheckoutViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  OrderItems? _order;
  OrderItems? get order => _order;
  void getOrderByID({String? orderID}) async {
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    final result = await CheckoutService().getOrderByID(orderID: orderID);
    _order = result.response;
    _isLoading = false;
    notifyListeners();
  }
}
