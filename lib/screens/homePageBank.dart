// import 'package:flutter/material.dart';

// void main() => runApp(LoginSignupPage());

// class LoginSignupPage extends StatelessWidget {
//   const LoginSignupPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Login / Sign Up'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(height: 30.0),
//                 Text(
//                   'Welcome!',
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 30.0),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                   ),
//                   obscureText: true,
//                 ),
//                 SizedBox(height: 20.0),
//                 RaisedButton(
//                   onPressed: () {},
//                   child: Text('Login'),
//                 ),
//                 SizedBox(height: 20.0),
//                 Text(
//                   'New to the app? Sign up now!',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 RaisedButton(
//                   onPressed: () {},
//                   child: Text('Sign Up'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
/*
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background_image.jpg'), // Replace with your actual image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: !isPasswordVisible,
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
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Add your login logic here
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to signup page
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

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Transaction Details'),
            onTap: () {
              // Navigate to transaction details page
            },
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text('Companies Dealt With'),
            onTap: () {
              // Navigate to companies dealt with page
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Special Information'),
            onTap: () {
              // Navigate to special information page
            },
          ),
        ],
      ),
    );
  }
}
*/

// custom button starts from here
import 'package:farmer_app/screens/CibilParametersEditor.dart';
import 'package:farmer_app/screens/CibilScore.dart';
import 'package:farmer_app/screens/bankerProfile.dart';
import 'package:farmer_app/screens/login_signup_page.dart';
import 'package:farmer_app/screens/profile_page.dart';
import 'package:farmer_app/screens/search.dart';
import 'package:farmer_app/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:farmer_app/screens/profile_page.dart';

class HomePageBank extends StatelessWidget {
  const HomePageBank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer First - Banker Login'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Bank Login'),
              accountEmail: const Text('admin@app.com'),
              currentAccountPicture: CircleAvatar(
                child: const Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageBank()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BankerProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.score),
              title: const Text('Credit Score'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CibilCalculatorPage()),
                );
              },
            ),
            /*ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: const Text('Transactions'),
              onTap: () {
                // Handle transactions button tap
              },
            ),*/
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 160.0,
                      child: CustomPaint(
                        painter: _PieChartPainter(
                          percentage:
                              70.0, // Replace with the actual percentage of the chart to fill
                          radius: 80.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome!', // Replace with the user's credit score
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Credit Score Search',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Choose Option',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSquareButton(
                    Icons.calculate,
                    'Check Cibil Score',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                  ),
                  const SizedBox(width: 20.0),
                  /* _buildSquareButton(
                    Icons.swap_horiz,
                    'Transactions',
                    () {
                      // Handle transactions button tap
                    },
                  ),*/
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSquareButton(
                    Icons.person,
                    'Profile',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BankerProfilePage()),
                      );
                    },
                  ),
                  const SizedBox(width: 20.0),
                  _buildSquareButton(
                    Icons.logout,
                    'Log Out',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSquareButton(
      IconData icon, String label, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        height: 160.0,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(
            label,
            textAlign: TextAlign.center,
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(20.0),
          ),
        ),
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final double percentage;
  final double radius;

  _PieChartPainter({
    required this.percentage,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * percentage / 100;

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(_PieChartPainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePageBank(),
  ));
}
