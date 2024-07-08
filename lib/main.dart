import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/views/screens/auth/login_screen.dart';
import 'package:rumeat_ball_apps/views/screens/auth/login_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/auth/register_screen.dart';
import 'package:rumeat_ball_apps/views/screens/auth/register_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/home_screen.dart';
import 'package:rumeat_ball_apps/views/screens/otp_screen.dart';
import 'package:rumeat_ball_apps/views/screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create: (_) => RegisterViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const SplashScreen(),
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/otp': (context) => const OTPScreen(),
      },
    );
  }
}
