import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_finance_tracker/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding(); // Navigate to the onboarding screen after a delay
  }

  void _navigateToOnboarding() async {
    await Future.delayed(Duration(seconds: 3)); // Splash screen duration

    // Navigate to the onboarding screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Change to your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LottieBuilder.asset(
              'assets/animation_lmkuwzy6.json', // Replace with your Lottie animation file
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Finance Pal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
