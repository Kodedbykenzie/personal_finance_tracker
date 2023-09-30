import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_finance_tracker/login_page.dart';
import 'package:personal_finance_tracker/signup_page.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Started'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LottieBuilder.asset(
              'assets/animation_lmjs40ql.json', // Replace with your Lottie animation file
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Start your financial journey!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the signup screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) =>
                          const SignUpPage()), // Replace `SignUpScreen` with the actual name of your signup screen
                );
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) =>
                          const LoginPage()), // Replace `LoginPage` with the actual name of your login screen
                );
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
