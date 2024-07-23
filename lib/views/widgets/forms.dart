import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final bool obscureText;
  final TextEditingController? controller;
  final bool isShowTitle;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? enabled;
  final double? letterSpacing;
  final bool isValid;
  final String errorMessage;

  const CustomFormField({
    super.key,
    required this.title,
    this.obscureText = false,
    this.controller,
    this.isShowTitle = true,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
    this.keyboardType,
    this.enabled,
    this.letterSpacing,
    required this.isValid,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle)
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular,
            ),
          ),
        if (isShowTitle) const SizedBox(height: 8),
        TextFormField(
          textCapitalization: TextCapitalization.words,
          obscureText: obscureText,
          controller: controller,
          obscuringCharacter: '*',
          enabled: enabled,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: greyTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular,
              letterSpacing: letterSpacing,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        if (!isValid)
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 5),
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
