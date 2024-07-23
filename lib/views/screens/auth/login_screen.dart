import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/views/screens/auth/login_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'package:rumeat_ball_apps/views/widgets/forms.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginViewModel>(context);
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
                  "Please sign in to your account ",
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
                  controller: loginProvider.emailController,
                  isValid: loginProvider.isEmailValid,
                  errorMessage: loginProvider.errorEmailMessage,
                  onChanged: (p0) {
                    loginProvider.validateEmail(p0);
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                CustomFormField(
                  title: "Password",
                  controller: loginProvider.passwordController,
                  obscureText: loginProvider.isHidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      loginProvider.showHidePassword();
                    },
                    icon: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        loginProvider.isHidePassword
                            ? "assets/icons/ic_eye_lock.png"
                            : "assets/icons/ic_eye.png",
                      ),
                    ),
                  ),
                  isValid: loginProvider.isPasswordValid,
                  errorMessage: loginProvider.errorPasswordMessage,
                  onChanged: (p0) {
                    loginProvider.validatePassword(p0);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/forgot-password',
                          (route) => false,
                        );
                      },
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
                    title: "Sign In",
                    onPressed: () {
                      loginProvider.loginProvider(context);
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
                      "Don't have an account?",
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                        loginProvider.emailController.clear();
                        loginProvider.passwordController.clear();
                      },
                      child: Text(
                        "Register",
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
