import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/views/screens/admin/admin_dashboard.dart';
import 'package:rumeat_ball_apps/views/screens/admin/admin_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'package:rumeat_ball_apps/views/widgets/forms.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final adminLoginProvider = Provider.of<AdminViewModel>(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 100),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login to your \naccount.",
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Please sign in to your Admin account ",
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                CustomFormField(
                  title: "Email Address",
                  controller: adminLoginProvider.emailController,
                  isValid: adminLoginProvider.isEmailValid,
                  errorMessage: adminLoginProvider.errorEmailMessage,
                  onChanged: (p0) {
                    adminLoginProvider.validateEmail(p0);
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                CustomFormField(
                  title: "Password",
                  controller: adminLoginProvider.passwordController,
                  obscureText: adminLoginProvider.isHidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      adminLoginProvider.showHidePassword();
                    },
                    icon: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        adminLoginProvider.isHidePassword
                            ? "assets/icons/ic_eye_lock.png"
                            : "assets/icons/ic_eye.png",
                      ),
                    ),
                  ),
                  isValid: adminLoginProvider.isPasswordValid,
                  errorMessage: adminLoginProvider.errorPasswordMessage,
                  onChanged: (p0) {
                    adminLoginProvider.validatePassword(p0);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomFilledButton(
                    title: "Sign In",
                    onPressed: () {
                      adminLoginProvider.loginProvider(context);
                    },
                    height: 52,
                    width: 327,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You're an user?",
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                        adminLoginProvider.emailController.clear();
                        adminLoginProvider.passwordController.clear();
                      },
                      child: Text(
                        "Log In As User",
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
