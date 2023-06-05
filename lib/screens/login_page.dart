/*import 'package:flutter/material.dart';

class LoginSignUpPage extends StatefulWidget {
  @override
  _LoginSignUpPageState createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login/Sign-up'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            RaisedButton(
              child: Text('Login'),
              onPressed: () {
                // Perform login logic
              },
            ),
            FlatButton(
              child: Text('Sign up'),
              onPressed: () {
                // Navigate to sign-up page
              },
            ),
          ],
        ),
      ),
    );
  }
}


void login() {
  // Get the entered email and password
  String email = emailController.text;
  String password = passwordController.text;

  // Perform your login logic here, such as validating credentials

  // Example: Show a snackbar with the result
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Logged in successfully'),
    ),
  );
}



void navigateToSignUpPage() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignUpPage()),
  );
}

*/

