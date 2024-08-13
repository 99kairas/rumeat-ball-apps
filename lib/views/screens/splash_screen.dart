import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumeat_ball_apps/views/screens/onboarding_screen.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    await Future.delayed(Duration(seconds: 3));
    if (isFirstLaunch) {
      // Set the flag to false once onboarding is shown
      await prefs.setBool('isFirstLaunch', false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

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
          width: MediaQuery.of(context).size.width * 0.75,
          child: Image.asset("assets/images/rumeat-ball.png"),
        ),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(seconds: 3),
        onAnimationEnd: () => debugPrint("On Scale End"),
      ),
    );
  }
}
