import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_finance_tracker/home_screen.dart';
import 'package:personal_finance_tracker/login_page.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Inside SignUpPage build method
              Lottie.asset(
                'assets/animation_lml0j212.json', // Replace with your animation file path
                width: 200,
                height: 200,
                repeat: true, // Set to true if you want the animation to loop
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  icon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  icon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  icon: Icon(Icons.account_circle),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  icon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Implement your signup logic here
                  // Typically, you'd send the user's data to a server or database
                  // and handle the response accordingly.
                  // For this example, we'll show a success message.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sign Up Successful!'),
                    ),
                  );

                  // After successful signup, navigate to the login page
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  // Navigate to the login page directly
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
                child: Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


