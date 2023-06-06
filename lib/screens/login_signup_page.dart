import 'package:farmer_app/auth_methods/auth_methods.dart';
import 'package:farmer_app/responsive/utils.dart';
import 'package:farmer_app/screens/homePageBank.dart';
import 'package:farmer_app/screens/home_page.dart';
import 'package:farmer_app/screens/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmailFocused = false;
  bool _obscurePassword = true;
  String _signInAs = 'User';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser(String accountType) async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      String res = await AuthMethods().loginUser(
        email: email,
        password: password,
      );

      if (res == "Successfully Logged In!") {
        showSnackBar(res, context);

        if (accountType == 'user') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (accountType == 'bank') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageBank()),
          );
        }
      } else {
        showSnackBar(res, context);
      }
    } else {
      showSnackBar("Please enter email and password", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'lib/assets/logo.png',
                height: 200.0,
                width: 200.0,
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Login As: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'Bank',
                          groupValue: _signInAs,
                          onChanged: (value) {
                            setState(() {
                              _signInAs = value!;
                            });
                          },
                        ),
                        Icon(Icons.business), // Icon for Bank
                        Text('Bank'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'User',
                          groupValue: _signInAs,
                          onChanged: (value) {
                            setState(() {
                              _signInAs = value!;
                            });
                          },
                        ),
                        Icon(Icons.account_circle), // Icon for User
                        Text('User'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: isEmailFocused ? 60.0 : 45.0,
                child: TextFormField(
                  onTap: () {
                    setState(() {
                      isEmailFocused = true;
                    });
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.person),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: _obscurePassword,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_signInAs == 'User') {
                    loginUser('user');
                  } else if (_signInAs == 'Bank') {
                    loginUser('bank');
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text('Log In'),
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign up here',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
