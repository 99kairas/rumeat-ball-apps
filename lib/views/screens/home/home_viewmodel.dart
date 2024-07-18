import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/get_all_categories_response.dart';
import 'package:rumeat_ball_apps/models/get_all_menu_response.dart';
import 'package:rumeat_ball_apps/services/user_get_all_menu_service.dart';

class HomeViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<AllMenu>? _menu;
  List<AllMenu>? get menu => _menu;

  List<AllCategories>? _category;
  List<AllCategories>? get category => _category;

  void getAllMenu() async {
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    final result = await HomeService().getAllMenu();

    _menu = result.response;
    _isLoading = false;
    notifyListeners();
  }


  void getAllCategories() async {
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    final result = await HomeService().getAllCategories();

    _category = result.response;
    _isLoading = false;
    notifyListeners();
  }
}
