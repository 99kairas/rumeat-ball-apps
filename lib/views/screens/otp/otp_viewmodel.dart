import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';

class OTPViewModel with ChangeNotifier {
  List<TextEditingController> _otpControllers = [];
  List<FocusNode> _focusNodes = [];

  OTPViewModel() {
    _initializeControllersAndFocusNodes();
  }

  List<TextEditingController> get otpControllers => _otpControllers;
  List<FocusNode> get focusNodes => _focusNodes;

  void _initializeControllersAndFocusNodes() {
    _otpControllers = List.generate(6, (index) => TextEditingController());
    _focusNodes = List.generate(6, (index) => FocusNode());

    for (int i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(() {
        if (_otpControllers[i].text.length == 1) {
          if (i < _otpControllers.length - 1) {
            _focusNodes[i + 1].requestFocus();
          } else {
            _focusNodes[i].unfocus();
            // Optionally submit the OTP here if you want
          }
        }
        notifyListeners();
      });
    }
  }

  String getOTP() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  void clearControllers() {
    _otpControllers.forEach((controller) => controller.clear());
  }

  Future<void> verifyOTP(BuildContext context, String email) async {
    String otp = getOTP();
    Dio dio = Dio();
    try {
      final response = await dio.put(
        '${APIConstant.baseUrl}/users/verify',
        data: {
          'email': email,
          'otp': otp,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle success
        scaffoldMessengerSuccess(
          context: context,
          title: response.data['message'],
        );
        navigateToHomeScreen(context);
      } else {
        scaffoldMessengerFailed(
            context: context, title: response.data['response']);
      }
    } on DioException catch (e) {
      scaffoldMessengerFailed(
          context: context, title: '${e.response?.data['response']}');
    }
  }

  @override
  void dispose() {
    _otpControllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      (route) => false,
    );
    _otpControllers.forEach((controller) => controller.clear());
  }
}
