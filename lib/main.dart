import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/onboarding_screen.dart';
import 'package:personal_finance_tracker/splash_screen.dart';
import 'package:personal_finance_tracker/get_started_screen.dart';
import 'package:personal_finance_tracker/login_page.dart';
import 'package:personal_finance_tracker/home_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Tracker',
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/get_started': (context) => GetStartedScreen(),
        '/login': (context) => LoginPage(),
        'home': (context) => HomePage(),
    // Add other screens here
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

