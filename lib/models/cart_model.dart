import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final int price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartModel with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    int index = _items.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }
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
}
