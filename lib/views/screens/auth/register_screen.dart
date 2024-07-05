import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'package:rumeat_ball_apps/views/widgets/forms.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create your new\naccount.",
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Create an account to start looking for the food you like",
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const CustomFormField(
                  title: "Email Address",
                ),
                const SizedBox(
                  height: 14,
                ),
                const CustomFormField(
                  title: "User Name",
                ),
                const SizedBox(
                  height: 14,
                ),
                CustomFormField(
                  title: "Password",
                  obscureText: true,
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "assets/icons/ic_eye_lock.png",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                CustomFormField(
                  title: "Confirm Password",
                  obscureText: true,
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "assets/icons/ic_eye_lock.png",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomFilledButton(
                    title: "Sign Up",
                    onPressed: () {},
                    height: 52,
                    width: 327,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sign In",
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
