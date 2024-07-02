import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'package:rumeat_ball_apps/views/widgets/forms.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "OTP",
          style: blackTextStyle.copyWith(
            fontSize: 25,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email Verification",
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Enter the verification code we send you on:\nemailAnda@gmail.com",
                  style: greyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (index) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 65,
                        height: 70,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1)
                          ],
                          textAlign: TextAlign.center,
                          style: blackTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: semiBold,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn’t receive code?",
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Resend",
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomFilledButton(
                    title: "Continue",
                    onPressed: () {},
                    height: 52,
                    width: 327,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
