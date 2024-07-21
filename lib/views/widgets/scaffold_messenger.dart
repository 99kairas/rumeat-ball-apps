import 'package:flutter/material.dart';

scaffoldMessenger({
  required BuildContext context,
  required String title,
  required Color color,
  bool? result,
}) {
  if (result == true) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(title),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(title),
      ),
    );
  }
}
