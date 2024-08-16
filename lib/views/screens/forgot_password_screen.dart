import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'package:rumeat_ball_apps/views/widgets/forms.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot password?",
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Enter your email address and we’ll send you confirmation code to reset your password",
                  style: greyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const CustomFormField(
                  title: "Email Address",
                  hintText: "emailAnda@email.com",
                  errorMessage: "",
                  isValid: false,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                const Center(
                  child: CustomFilledButton(
                    title: "Continue",
                    width: 327,
                    height: 52,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
