import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_finance_tracker/home_screen.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _firstNameError = '';
  String _lastNameError = '';
  String _usernameError = '';
  String _phoneNumberError = '';
  String _emailError = '';
  String _passwordError = '';

  void _login() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final username = _usernameController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Perform validation for each field
    if (firstName.isEmpty) {
      setState(() {
        _firstNameError = 'Please enter your first name';
      });
    } else {
      setState(() {
        _firstNameError = '';
      });
    }

    if (lastName.isEmpty) {
      setState(() {
        _lastNameError = 'Please enter your last name';
      });
    } else {
      setState(() {
        _lastNameError = '';
      });
    }

    if (username.isEmpty) {
      setState(() {
        _usernameError = 'Please enter a username';
      });
    } else {
      setState(() {
        _usernameError = '';
      });
    }

    if (phoneNumber.isEmpty) {
      setState(() {
        _phoneNumberError = 'Please enter your phone number';
      });
    } else {
      setState(() {
        _phoneNumberError = '';
      });
    }

    if (email.isEmpty || !email.contains('@')) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
    } else {
      setState(() {
        _emailError = '';
      });
    }

    if (password.isEmpty || password.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
    } else {
      setState(() {
        _passwordError = '';
      });
    }

    if (_firstNameError.isEmpty &&
        _lastNameError.isEmpty &&
        _usernameError.isEmpty &&
        _phoneNumberError.isEmpty &&
        _emailError.isEmpty &&
        _passwordError.isEmpty) {
      // After successful login, navigate to the HomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(
                    'assets/animation_lml0c7oz.json', // Replace with your animation file path
                    width: 200,
                    height: 200,
                    repeat: true, // Set to true if you want the animation to loop
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email),
                      errorText: _emailError,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.lock),
                      errorText: _passwordError,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




