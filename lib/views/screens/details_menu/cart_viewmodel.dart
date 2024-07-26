import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/cart_model.dart';
import 'package:rumeat_ball_apps/models/get_order_by_id_response.dart';
import 'package:rumeat_ball_apps/services/detail_menu_service.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class CartModel with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item, BuildContext context) {
    int index = _items.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    scaffoldMessengerSuccess(
        context: context,
        title:
            "Berhasil menambahkan ${item.quantity} ${item.name} ke keranjang");
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    int index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void increaseQuantity(String id) {
    int index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String id) {
    int index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        removeItem(id);
      }
      notifyListeners();
    }
  }

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  Future<void> createOrderCart(BuildContext context) async {
    final List<Map<String, dynamic>> orderItems = _items.map((item) {
      return {
        'menu_id': item.id,
        'quantity': item.quantity,
      };
    }).toList();

    try {
      final response = await DetailMenuService()
          .createOrder(orderItems); // Panggil service dengan token

      if (response.statusCode == 200 || response.statusCode == 201) {
        scaffoldMessengerSuccess(
          context: context,
          title: response.data['message'],
        );
        await Future.delayed(const Duration(seconds: 1));
      } else {
        scaffoldMessengerFailed(
            context: context, title: response.data['response']);
      }
    } on DioException catch (e) {
      scaffoldMessengerFailed(
          context: context, title: '${e.response?.data['response']}');
    }

    notifyListeners(); // Notify listeners that loading finished
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  OrderItems? _order;
  OrderItems? get order => _order;
  void getOrderByID({String? orderID}) async {
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    final result = await DetailMenuService().getOrderByID(orderID: orderID);
    _order = result.response;
    _isLoading = false;
    notifyListeners();
  }
}
