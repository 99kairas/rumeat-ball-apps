import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rumeat_ball_apps/views/screens/onboarding_content.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: contents.length,
        onPageChanged: (value) {
          setState(
            () {
              currentIndex = value;
            },
          );
        },
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: contents[index].image),
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          contents[index].title,
                          style: whiteTextStyle.copyWith(
                            fontSize: 30,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          textAlign: TextAlign.center,
                          contents[index].discription,
                          style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: regular,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012,
                        ),
                        if (currentIndex != 3) ...[
                          Container(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                3,
                                (index) => buildDot(index, context),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (currentIndex != 0) {
                                  _controller.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.linear,
                                  );
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                }
                              },
                              child: Text(
                                currentIndex != 0 ? "Back" : "Skip",
                                style: whiteTextStyle.copyWith(
                                  fontSize: 17,
                                  fontWeight: regular,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (currentIndex == 2) {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                }
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.linear,
                                );
                              },
                              child: Text(
                                currentIndex == 2 ? "Get Started" : "Next",
                                style: whiteTextStyle.copyWith(
                                  fontSize: 17,
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
          );
        },
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 6,
      width: currentIndex == index ? 24 : 24,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? whiteColor : (Colors.grey),
      ),
    );
  }
}
