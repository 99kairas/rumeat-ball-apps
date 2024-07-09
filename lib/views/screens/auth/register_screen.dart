import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/views/screens/auth/register_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'package:rumeat_ball_apps/views/widgets/forms.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          ListView(
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
                    CustomFormField(
                      title: "Email Address",
                      keyboardType: TextInputType.emailAddress,
                      controller: registerProvider.emailController,
                      errorMessage: registerProvider.errorEmailMessage,
                      onChanged: (email) {
                        registerProvider.validateEmail(email);
                      },
                      isValid: registerProvider.isEmailValid,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomFormField(
                      title: "Name",
                      controller: registerProvider.nameController,
                      errorMessage: registerProvider.errorNameMessage,
                      isValid: registerProvider.isNameValid,
                      onChanged: (name) {
                        registerProvider.validateName(name);
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomFormField(
                      title: "Phone Number",
                      keyboardType: TextInputType.phone,
                      controller: registerProvider.phoneController,
                      errorMessage: registerProvider.errorPhoneNumberMessage,
                      isValid: registerProvider.isPhoneNumberValid,
                      onChanged: (phone) {
                        registerProvider.validatePhone(phone);
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomFormField(
                      title: "Password",
                      controller: registerProvider.passwordController,
                      obscureText: registerProvider.isHidePassword,
                      errorMessage: registerProvider.errorPasswordMessage,
                      isValid: registerProvider.isPasswordValid,
                      suffixIcon: IconButton(
                        onPressed: () {
                          registerProvider.showHidePassword();
                        },
                        icon: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            color: blackColor,
                            registerProvider.isHidePassword
                                ? "assets/icons/ic_eye_lock.png"
                                : "assets/icons/ic_eye.png",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomFormField(
                      onChanged: (value) {
                        registerProvider.validateConfirmPassword(value);
                      },
                      controller: registerProvider.confirmPasswordController,
                      title: 'Confirm Password',
                      hintText: '*****',
                      errorMessage:
                          registerProvider.errorConfirmPasswordMessage,
                      isValid: registerProvider.isConfirmPasswordValid,
                      obscureText: registerProvider.isHideConfirmPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          registerProvider.showHideConfirmPassword();
                        },
                        icon: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            color: blackColor,
                            registerProvider.isHideConfirmPassword
                                ? "assets/icons/ic_eye_lock.png"
                                : "assets/icons/ic_eye.png",
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
                        onPressed: () {
                          registerProvider.registerProvider(context);
                        },
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
          if (registerProvider.isLoading)
            Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: primaryColor,
                size: 50,
              ),
            ),
        ],
      ),
    );
  }
}
