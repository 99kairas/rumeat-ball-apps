import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/models/get_user_profile_response.dart';
import 'package:rumeat_ball_apps/services/profile_service.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/scaffold_messenger.dart';

class PersonalDataViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserProfile? _user;
  UserProfile? get user => _user;

  String? _image;
  String? get image => _image;

  void getUserInfo(BuildContext context) async {
    try {
      _isLoading = true;
      final result = await ProfileService().getUserProfile();
      if (result.response != null) {
        _user = result.response;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  // Update Profile
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void updateProfile(BuildContext context) async {
    try {
      final result = await ProfileService().updateProfile(
        address:
            addressController.text.isNotEmpty ? addressController.text : null,
        phone: phoneController.text.isNotEmpty ? phoneController.text : null,
      );

      if (result) {
        scaffoldMessenger(
          context: context,
          title: 'Berhasil ubah profil',
          color: greenColor,
          result: result,
        );
        addressController.clear();
        phoneController.clear();
      } else {
        scaffoldMessenger(
          context: context,
          title: 'Gagal ubah profil',
          color: redColor,
          result: result,
        );
      }

      notifyListeners();
    } catch (e) {
      print("ini error di view model $e");
      throw Exception(e);
    }
  }

  void updateFotoProfile(BuildContext context) async {
    _isLoading = true;
    notifyListeners(); // Notify listeners when the loading state changes

    final result = await ProfileService().updateFotoProfile();
    _isLoading = false; // Reset loading state
    notifyListeners(); // Notify listeners again

    if (result) {
      scaffoldMessenger(
        context: context,
        title: 'Berhasil ubah foto profil',
        color: greenColor,
        result: result,
      );
    } else {
      scaffoldMessenger(
        context: context,
        title: 'Gagal ubah profil',
        color: redColor,
        result: result,
      );
    }
  }
}
