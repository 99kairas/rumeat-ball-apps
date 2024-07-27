import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/checkout_model.dart';
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

  final CheckoutService _checkoutService = CheckoutService();

  String _error = '';
  String get error => _error;

  TransactionModel? _orderModel;
  TransactionModel? get orderModel => _orderModel;

  Future<void> placeOrder(String orderId, double totalAmount) async {
    _isLoading = true;
    notifyListeners();

    try {
      _orderModel =
          await _checkoutService.createTransaction(orderId, totalAmount);
      _error = '';
    } catch (e) {
      _error = e.toString();
      _order = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}