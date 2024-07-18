import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onPressed;

  CategoryCard({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: onPressed,
            color: primaryColor,
            icon: Icon(icon, color: primaryColor),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 70,
          alignment: Alignment.center,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontSize: 12,
              fontWeight: regular,
            ),
          ),
        ),
      ],
    );
  }
}
