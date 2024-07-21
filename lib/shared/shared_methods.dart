import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static final rupiah =
      NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0);
}

String formatCurrency(
  num number, {
  String symbol = 'Rp',
}) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: symbol,
    decimalDigits: 0,
  ).format(number);
}

scaffoldMessengerSuccess({
  required BuildContext context,
  required String title,
}) {
  // Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: primaryColor,
      content: Text(title),
    ),
  );
}

scaffoldMessengerFailed({
  required BuildContext context,
  required String title,
}) {
  // Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: redColor,
      content: Text(title),
    ),
  );
}

class SharedPref {
  static SharedPreferences? _preferences;

  static Future<SharedPreferences> get preferences async {
    if (_preferences != null) {
      return _preferences!;
    }

    _preferences = await SharedPreferences.getInstance();
    return _preferences!;
  }

  static Future<void> saveToken(String token) async {
    final prefs = await preferences;
    prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await preferences;
    return prefs.getString('token');
  }

  static Future<void> removeToken() async {
    final prefs = await preferences;
    prefs.remove('token');
  }
}

class APIConstant {
  static String baseUrl = 'http://10.0.2.2:8080'; // THIS IS FOR LOCAL API DON'T CHANGE IT
  // static String baseUrl = 'https://spp-payment.up.railway.app/api';
  // static String imageUrl = 'http://10.0.2.2:5000';
  // static String imageUrl = 'https://spp-payment.up.railway.app';
  static Map<String, String> auth(String token) => {
        "Authorization": "Bearer $token",
      };
}
