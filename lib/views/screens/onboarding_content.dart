import 'package:flutter/material.dart';

class UnbordingContent {
  Widget image;
  String title;
  String discription;

  UnbordingContent({
    required this.image,
    this.title = "Explore a Wide Variety",
    required this.discription,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
      image: Image.asset(
        'assets/images/onboarding1.png',
        fit: BoxFit.cover,
      ),
      discription:
          'Welcome to Rumeat Ball! We`re excited to have you here. Discover a world of delicious food and beverages right at your fingertips.'),
  UnbordingContent(
      image: Image.asset('assets/images/onboarding2.png', fit: BoxFit.cover),
      discription:
          'From tasty burgers to refreshing drinks, explore a wide variety of categories and find your favorite dishes with ease.'),
  UnbordingContent(
      image: Image.asset('assets/images/onboarding3.png', fit: BoxFit.cover),
      discription:
          'Ordering food has never been easier! Simply select your favorite items, customize them to your liking, and place your order with just a few taps.'),
];
