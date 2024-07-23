import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class RegisterViewModel with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Email Property
  String _email = "";
  String get email => _email;

  bool _isEmailValid = true;
  bool get isEmailValid => _isEmailValid;

  String _errorEmailMessage = "";
  String get errorEmailMessage => _errorEmailMessage;

  void validateEmail(String email) {
    _email = email;
    if (email.isEmpty) {
      _isEmailValid = false;
      _errorEmailMessage = "Email cannot be empty";
    } else {
      _errorEmailMessage = "";
      _isEmailValid = true;
    }
    notifyListeners();
  }
  // End of Email Property

  // Name Property
  String _name = "";
  String get name => _name;

  bool _isNameValid = true;
  bool get isNameValid => _isNameValid;

  String _errorNameMessage = "";
  String get errorNameMessage => _errorNameMessage;

  void validateName(String name) {
    _name = name;
    if (name.isEmpty) {
      _isNameValid = false;
      _errorNameMessage = "Name cannot be empty";
    } else {
      _errorNameMessage = "";
      _isNameValid = true;
    }
    notifyListeners();
  }
  // End of Name Property

  // Phone Number Property
  String _phone = "";
  String get phone => _phone;

  bool _isPhoneNumberValid = true;
  bool get isPhoneNumberValid => _isPhoneNumberValid;

  String _errorPhoneNumberMessage = "";
  String get errorPhoneNumberMessage => _errorPhoneNumberMessage;

  void validatePhone(String phone) {
    _phone = phone;
    if (phone.isEmpty) {
      _isPhoneNumberValid = false;
      _errorPhoneNumberMessage = "Phone Number cannot be empty";
    } else {
      _errorPhoneNumberMessage = "";
      _isPhoneNumberValid = true;
    }
    notifyListeners();
  }
  // End of Phone Number Property

  // Password Property
  String _password = "";
  String get password => _password;

  bool _isPasswordValid = true;
  bool get isPasswordValid => _isPasswordValid;

  String _errorPasswordMessage = "";
  String get errorPasswordMessage => _errorPasswordMessage;

  bool _isHidePassword = true;
  bool get isHidePassword => _isHidePassword;

  void validatePassword(String password) {
    _password = password;
    if (password.isEmpty) {
      _isPasswordValid = false;
      _errorPasswordMessage = "Password cannot be empty";
    } else {
      _errorPasswordMessage = "";
      _isPasswordValid = true;
    }
    notifyListeners();
  }

  void showHidePassword() {
    _isHidePassword = !_isHidePassword;
    notifyListeners();
  }
  // End of Password Property

  // Confirm Password Property
  String _confirmPassword = "";
  String get confirmPassword => _confirmPassword;

  bool _isConfirmPasswordValid = true;
  bool get isConfirmPasswordValid => _isConfirmPasswordValid;

  String _errorConfirmPasswordMessage = "";
  String get errorConfirmPasswordMessage => _errorConfirmPasswordMessage;

  bool _isHideConfirmPassword = true;
  bool get isHideConfirmPassword => _isHideConfirmPassword;

  void validateConfirmPassword(String value) {
    _confirmPassword = value;
    if (_confirmPassword != _password) {
      _errorConfirmPasswordMessage = "Passwords do not match";
      _isConfirmPasswordValid = false;
    } else {
      _errorConfirmPasswordMessage = "";
      _isConfirmPasswordValid = true;
    }
    notifyListeners();
  }

  void showHideConfirmPassword() {
    _isHideConfirmPassword = !_isHideConfirmPassword;
    notifyListeners();
  }
  // End Confirm Password

  bool validateAllFields() {
    validateEmail(emailController.text);
    validateName(nameController.text);
    validatePhone(phoneController.text);
    validatePassword(passwordController.text);
    validateConfirmPassword(confirmPasswordController.text);

    return _isEmailValid &&
        _isNameValid &&
        _isPhoneNumberValid &&
        _isPasswordValid &&
        _isConfirmPasswordValid;
  }

  // Provider
  registerProvider(BuildContext context) async {
    if (!validateAllFields()) {
      scaffoldMessengerFailed(
          context: context, title: 'Please fill in all fields correctly');
      return;
    }

    _isLoading = true;
    notifyListeners(); // Notify listeners that loading started

    Dio dio = Dio();
    try {
      final response = await dio.post(
        '${APIConstant.baseUrl}/users/signup',
        data: {
          'email': emailController.text,
          'name': nameController.text,
          'password': passwordController.text,
          'phone': phoneController.text,
          'address': "",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        scaffoldMessengerSuccess(
          context: context,
          title: response.data['message'],
        );
        await Future.delayed(const Duration(seconds: 1));
        navigateToOTPScreen(context);
      } else {
        scaffoldMessengerFailed(
            context: context, title: response.data['response']);
      }
    } on DioException catch (e) {
      scaffoldMessengerFailed(
          context: context, title: '${e.response?.data['response']}');
    }

    _isLoading = false;
    notifyListeners(); // Notify listeners that loading finished
    print("Loading finished: $_isLoading");
  }
  // End of Provider

  void navigateToOTPScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/otp',
      (route) => false,
      arguments: emailController.text,
    );
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    phoneController.clear();
  }
}
