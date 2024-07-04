import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu_screen.dart';
import 'package:rumeat_ball_apps/views/screens/forgot_password_screen.dart';
import 'package:rumeat_ball_apps/views/screens/home_screen.dart';
import 'package:rumeat_ball_apps/views/screens/login_screen.dart';
import 'package:rumeat_ball_apps/views/screens/otp_screen.dart';
import 'package:rumeat_ball_apps/views/screens/payment_screen.dart';
import 'package:rumeat_ball_apps/views/screens/profile_screen.dart';
import 'package:rumeat_ball_apps/views/screens/register_screen.dart';
import 'package:rumeat_ball_apps/views/screens/reset_password_screen.dart';
// import 'package:rumeat_ball_apps/views/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.scale(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 100],
          colors: [
            Color(0xffF87146),
            Color(0xffF9E083),
          ],
        ),
        childWidget: SizedBox(
          // height: 50,
          width: MediaQuery.of(context).size.width * 0.75,
          child: Image.asset("assets/images/rumeat-ball.png"),
        ),
        duration: const Duration(milliseconds: 3500),
        animationDuration: const Duration(milliseconds: 2000),
        onAnimationEnd: () => debugPrint("On Scale End"),
        nextScreen: ProfileScreen(),
      ),
    );
  }
}
