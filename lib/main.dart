import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/models/get_all_menu_response.dart';
import 'package:rumeat_ball_apps/views/screens/auth/login_screen.dart';
import 'package:rumeat_ball_apps/views/screens/auth/login_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/auth/register_screen.dart';
import 'package:rumeat_ball_apps/views/screens/auth/register_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu_screen.dart';
import 'package:rumeat_ball_apps/views/screens/home/home_screen.dart';
import 'package:rumeat_ball_apps/views/screens/home/home_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/otp/otp_screen.dart';
import 'package:rumeat_ball_apps/views/screens/otp/otp_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/profile/personal_data_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/profile/profile_viewmodel.dart';
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
        ChangeNotifierProvider<OTPViewModel>(
          create: (_) => OTPViewModel(),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (_) => ProfileViewModel(),
        ),
        ChangeNotifierProvider<PersonalDataViewModel>(
          create: (_) => PersonalDataViewModel(),
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
        '/detail-menu': (context) => const DetailsMenuScreen(),
        '/otp': (context) {
          final email = ModalRoute.of(context)!.settings.arguments as String;
          return OTPScreen(
            email: email,
          );
        },
      },
    );
  }
}
