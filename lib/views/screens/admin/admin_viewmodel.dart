import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

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
          'password': passwordController.text
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        saveToken(
          response.data['response']['token'],
        );
        scaffoldMessengerSuccess(
          context: context,
          title: response.data['message'],
        );
        navigateToDashboard(context);
      }
    } on DioException catch (e) {
      scaffoldMessengerFailed(
          context: context, title: '${e.response?.data['response']}');
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
}
