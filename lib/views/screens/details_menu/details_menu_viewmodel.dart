import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/get_detail_menu_response.dart';
import 'package:rumeat_ball_apps/services/detail_menu_service.dart';

class DetailsMenuViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DetailMenu? _menu;
  DetailMenu? get menu => _menu;

  void getDetailMenu({String? menuID}) async {
    try {
      _isLoading = true;
      await Future.delayed(const Duration(seconds: 1));
      final result = await DetailMenuService().getDetailMenu(menuID: menuID);
      _menu = result.response;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
