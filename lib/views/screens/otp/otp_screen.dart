import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'otp_viewmodel.dart';

class OTPScreen extends StatelessWidget {
  final String email;

  const OTPScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OTPViewModel(),
      child: Scaffold(
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
        body: Consumer<OTPViewModel>(
          builder: (context, otpViewModel, child) {
            return ListView(
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
                        "Enter the verification code we sent you on:\n$email",
                        style: greyTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
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
                                controller: otpViewModel.otpControllers[index],
                                focusNode: otpViewModel.focusNodes[index],
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
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
                          onPressed: () {
                            otpViewModel.verifyOTP(context, email);
                          },
                          height: 52,
                          width: 327,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
