import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'package:rumeat_ball_apps/views/widgets/forms.dart';
import 'dart:ui';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isModalVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.only(top: 18, bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reset Password",
                      style: blackTextStyle.copyWith(
                        fontSize: 32,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Your new password must be different from the previously used password",
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomFormField(
                      title: "New Password",
                      obscureText: true,
                      suffixIcon: IconButton(
                        onPressed: null,
                        icon: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            color: blackColor,
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
                            color: blackColor,
                            "assets/icons/ic_eye_lock.png",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    CustomFilledButton(
                      title: "Verify Account",
                      onPressed: () => _showModalBottomSheet(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isModalVisible)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    setState(() {
      _isModalVisible = true;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              const SizedBox(
                height: 200,
                child: Image(
                  image: AssetImage(
                    "assets/icons/ic_success_reset.png",
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 32,
              ),
              Text(
                "Password Changed",
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Password changed successfully, you can login again with a new password",
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              CustomFilledButton(
                title: "Verify Account",
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isModalVisible = false;
                  });
                },
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        _isModalVisible = false;
      });
    });
  }
}
