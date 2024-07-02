import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/onboarding1.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            child: Container(
              width: 335,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: primaryColor,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.032,
                  bottom: MediaQuery.of(context).size.height * 0.032,
                ),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "We serve incomparable delicacies",
                      style: whiteTextStyle.copyWith(
                        fontSize: 30,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      textAlign: TextAlign.center,
                      "All the best restaurants with their top menu waiting for you, they can’t wait for your order!!",
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Skip",
                            style: whiteTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Next",
                            style: whiteTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
