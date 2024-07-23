import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/get_all_order_response.dart';
import 'package:rumeat_ball_apps/services/order_service.dart';

class OrderViewModel extends ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await OrderService().fetchOrders();
      _orders = response.response?.orders ?? [];
      _orders.sort((a, b) => (b.date!).compareTo((a.date!)));
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // DateTime parseDate(String date) {
  //   final DateFormat formatter = DateFormat('d MMMM yyyy HH:mm');
  //   return formatter.parse(date);
  // }

  Order? getOrderById(String id) {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }
}