import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/admin_get_all_order_response.dart';
import 'package:rumeat_ball_apps/models/get_all_categories_response.dart';
import 'package:rumeat_ball_apps/models/get_all_menu_response.dart';
import 'package:rumeat_ball_apps/models/get_all_order_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/admin/admin_service.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/scaffold_messenger.dart';

class AdminViewModel with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Email Property
  String _email = "";
  String get email => _email;

  bool _isEmailValid = true;
  bool get isEmailValid => _isEmailValid;

  String _errorEmailMessage = "";
  String get errorEmailMessage => _errorEmailMessage;

  bool _isButtonEmailValid = false;
  bool get isButtonEmailValid => _isButtonEmailValid;

  void validateEmail(String email) {
    _email = email;
    if (email.isEmpty) {
      _isEmailValid = false;
      _isButtonEmailValid = false;
      _errorEmailMessage = "Email cannot be empty";
    } else {
      _isButtonEmailValid = true;
      _isEmailValid = true;
    }
    notifyListeners();
  }

// End of Email Property

// Password Property
  String _password = "";
  String get password => _password;

  bool _isPasswordValid = true;
  bool get isPasswordValid => _isPasswordValid;

  String _errorPasswordMessage = "";
  String get errorPasswordMessage => _errorPasswordMessage;

  bool _isHidePassword = true;
  bool get isHidePassword => _isHidePassword;

  final bool _isButtonPasswordValid = false;
  bool get isButtonPasswordValid => _isButtonPasswordValid;

  void validatePassword(String password) {
    _password = password;
    if (password.isEmpty) {
      _isPasswordValid = false;
      _errorPasswordMessage = "Password cannot be empty";
    } else {
      _isPasswordValid = true;
      _isPasswordValid = true;
    }
    notifyListeners();
  }
// End of Password Property

  void saveToken(String token) {
    SharedPref.saveToken(token);
  }

  void showHidePassword() {
    _isHidePassword = !_isHidePassword;
    notifyListeners();
  }

  // Provider
  loginProvider(BuildContext context) async {
    Dio dio = Dio();
    try {
      final response = await dio.post(
        '${APIConstant.baseUrl}/admin/login',
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      // Cek status kode terlebih dahulu
      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['response']['token'];
        final role =
            response.data['response']['role']; // Mendapatkan role dari response
        if (role == 'admin') {
          saveToken(token);

          scaffoldMessengerSuccess(
            context: context,
            title: response.data['message'],
          );
          navigateToDashboard(context);
        } else {
          scaffoldMessengerFailed(
            context: context,
            title:
                'Unauthorized: You do not have access to the admin dashboard.',
          );
        }
      }
    } on DioException catch (e) {
      scaffoldMessengerFailed(
        context: context,
        title: '${e.response?.data['response']}',
      );
    }
  }

  // End of Provider

  void navigateToDashboard(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/admin-dashboard',
      (route) => false,
    );
    emailController.clear();
    passwordController.clear();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<AllMenu>? _menu;
  List<AllMenu>? get menu => _menu;

  void getAllMenu() async {
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    final result = await AdminService().getAllMenu();

    _menu = result.response;
    _isLoading = false;
    notifyListeners();
  }

  List<AdminAllOrderResponse> _orders = [];
  List<AdminAllOrderResponse> get orders => _orders;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await AdminService().fetchOrders();
      _orders = response.response
          .where((order) =>
              order.status == Status.PROCESSED ||
              order.status == Status.SUCCESSED)
          .toList(); // Filter orders
      _orders.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  List<AllCategories>? _categories;
  List<AllCategories>? get categories => _categories;

  Future<void> getAllCategories() async {
    try {
      final response = await AdminService().getAllCategories();
      _categories = response.response;
    } catch (e) {
      _categories = [];
    }
    notifyListeners();
  }

  Future<void> addMenu(BuildContext context, String menuName,
      String description, double price, String? categoryId, File? image) async {
    _isLoading = true;
    notifyListeners();

    final result = await AdminService().addMenu(
      menuName,
      description,
      price,
      categoryId,
      image,
    );
    _isLoading = false;
    notifyListeners();

    if (result) {
      scaffoldMessenger(
        context: context,
        title: 'Berhasil tambah menu',
        color: greenColor,
        result: result,
      );
      Navigator.pop(context);
    } else {
      scaffoldMessenger(
        context: context,
        title: 'Gagal tambah menu',
        color: redColor,
        result: result,
      );
    }
  }

  Future<void> editMenu(BuildContext context, String menuId, String menuName,
      String description, double price, String categoryId, File? image) async {
    _isLoading = true;
    notifyListeners();

    final result = await AdminService().editMenu(
      menuId,
      menuName,
      description,
      price,
      categoryId,
      image,
    );

    _isLoading = false;
    notifyListeners();

    if (result) {
      scaffoldMessenger(
        context: context,
        title: 'Berhasil mengedit menu',
        color: greenColor,
        result: result,
      );
      Navigator.pop(context);
    } else {
      scaffoldMessenger(
        context: context,
        title: 'Gagal mengedit menu',
        color: redColor,
        result: result,
      );
    }
  }

  Future<void> deleteMenu(BuildContext context, String menuId) async {
    _isLoading = true;
    notifyListeners();

    final result = await AdminService().deleteMenu(menuId);

    _isLoading = false;
    notifyListeners();

    if (context.mounted) {
      if (result) {
        scaffoldMessenger(
          context: context,
          title: 'Berhasil hapus menu',
          color: greenColor,
          result: result,
        );
        // Refresh menu list after deletion
        getAllMenu();
      } else {
        scaffoldMessenger(
          context: context,
          title: 'Gagal hapus menu',
          color: redColor,
          result: result,
        );
      }
    }
  }
}
