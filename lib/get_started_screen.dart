import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_finance_tracker/login_page.dart';
import 'package:personal_finance_tracker/signup_page.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Started'),
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
            SizedBox(height: 20),
            Text(
              'Start your financial journey!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the signup screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => SignUpPage()), // Replace `SignUpScreen` with the actual name of your signup screen
                );
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginPage()), // Replace `LoginPage` with the actual name of your login screen
                );
              },
              child: Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}

