import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_finance_tracker/get_started_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Slide> slides = [
    Slide(
      title: "Welcome to Finance Pal",
      widgetTitle: LottieBuilder.asset(
        'assets/animation_lmjtdifi.json',
        width: 400,
        height: 300,
      ),
      description:
      "Your personal finance tracker.\n\nTake control of your finances with ease and confidence, empowering you to achieve your financial goals",
      backgroundColor: Colors.white, // White background
      styleTitle: TextStyle(
        color: Colors.blue, // Blue text color
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      styleDescription: TextStyle(
        color: Colors.blue, // Black text color for content
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    Slide(
      title: "Track Your Spending",
      widgetTitle: LottieBuilder.asset(
        'assets/NQpSWZfdkg.json',
        width: 400,
        height: 280,
      ),
      description:
      "Easily track how much you're spending each day, week, or month.\n\nSet budget limits and receive alerts when you exceed them.",
      backgroundColor: Colors.blue, // Blue background
      styleDescription: TextStyle(
        color: Colors.white, // White text color
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      styleTitle: TextStyle(
        color: Colors.white, // White text color for content
        fontSize: 18,
      ),
    ),
    Slide(
      title: "Stay on Budget",
      widgetTitle: LottieBuilder.asset(
        'assets/animation_lmjtperk.json',
        width: 400,
        height: 300,
      ),
      description:
      "Set budget limits and receive alerts when you exceed them.\n\nEasily set budget to spend each day, week, or month.",
      backgroundColor: Colors.white, // White background
      styleDescription: TextStyle(
        color: Colors.blue, // White text color
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      styleTitle: TextStyle(
        color: Colors.white, // White text color for content
        fontSize: 18,
      ),
    ),
  ];

  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Automatically transition to the next slide every 2 seconds
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (currentIndex < slides.length - 1) {
        currentIndex++;
        _pageController.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        // When the last slide is reached, navigate to the "Get Started" screen
        _navigateToGetStarted();
        timer.cancel(); // Cancel the timer to stop automatic transitions
      }
    });
  }

  void _navigateToGetStarted() async {
    // Delay the navigation to give time for the user to view the slides
    await Future.delayed(Duration(seconds: 3)); // Adjust the duration as needed

    // Navigate to the "Get Started" screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => GetStartedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: slides.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              IntroSlider(
                slides: [slides[index]],
                renderDoneBtn: Container(), // Remove the "Done" button
                renderSkipBtn: Container(), // Remove the "Skip" button
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentIndex != 0)
                        InkWell(
                          onTap: () {
                            // Handle the "Previous" link tap
                            currentIndex--;
                            _pageController.animateToPage(
                              currentIndex,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            "",
                            style: TextStyle(
                              color: Colors.blue, // Customize link color
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      // No "Next" button
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


