import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/get_user_profile_response.dart';
import 'package:rumeat_ball_apps/services/profile_service.dart';

class ProfileViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserProfile? _user;
  UserProfile? get user => _user;

  String? _image;
  String? get image => _image;

  void getUserInfo(BuildContext context) async {
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    final result = await ProfileService().getUserProfile();
    if (result.response != "") {
      _user = result.response;
    }
    _isLoading = false;
    notifyListeners();
  }
}
