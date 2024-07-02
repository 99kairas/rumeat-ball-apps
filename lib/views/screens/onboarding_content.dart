import 'package:flutter/material.dart';

class UnbordingContent {
  Widget image;
  String title;
  String discription;

  UnbordingContent({
    required this.image,
    this.title = "We serve incomparable delicacies",
    required this.discription,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
      image: Image.asset('assets/images/onboarding1.png'),
      discription: 'Grow your skill & push your limit'),
  UnbordingContent(
      image: Image.asset('assets/images/onboarding2.png'),
      discription: 'Study from anywhere with experts'),
  UnbordingContent(
      image: Image.asset('assets/images/onboarding3.png'),
      discription: 'Get access to unlimited educational resources'),
  UnbordingContent(
      title: ' STIKI MALANG',
      image: Image.asset('assets/images/image5.png'),
      discription:
          'Find the best teacher & upgrade your skills, start learn now with'),
];
