import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/onboarding_screen.dart';
import 'package:personal_finance_tracker/splash_screen.dart';
import 'package:personal_finance_tracker/get_started_screen.dart';
import 'package:personal_finance_tracker/login_page.dart';
import 'package:personal_finance_tracker/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Finance Tracker',
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/get_started': (context) => const GetStartedScreen(),
        '/login': (context) => const LoginPage(),
        'home': (context) => const HomePage(),
        // Add other screens here
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
