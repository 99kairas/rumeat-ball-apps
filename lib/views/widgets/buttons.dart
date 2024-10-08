import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class CustomFilledButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final Color? color;
  final IconData? icon;
  final TextStyle? style;

  const CustomFilledButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 50,
    this.onPressed,
    this.icon,
    this.color,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color != null ? color : primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(56),
          ),
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: whiteColor),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: style == null ? whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ) : style,
                  ),
                ],
              )
            : Text(
                title,
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  const CustomTextButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 24,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: Text(
          title,
          style: greyTextStyle.copyWith(
            fontSize: 16,
            fontWeight: regular,
          ),
        ),
      ),
    );
  }
}
