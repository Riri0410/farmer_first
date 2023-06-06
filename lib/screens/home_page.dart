import 'package:farmer_app/auth_methods/auth_methods.dart';
import 'package:farmer_app/screens/CibilParametersEditor.dart';
import 'package:farmer_app/screens/CibilScore.dart';
import 'package:farmer_app/screens/analysis.dart';
import 'package:farmer_app/screens/bankerProfile.dart';
import 'package:farmer_app/screens/cibilParameterUpdate.dart';
import 'package:farmer_app/screens/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> name = getdata('name');
    Future<String> email = getdata('email');
    Future<int> currentScore = getIntData('currentscore');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer First'),
      ),
      drawer: Drawer(
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([name, currentScore, email]),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String nameNonFuture = snapshot.data![0];
              int score = snapshot.data![1];
              String emailNonFuture = snapshot.data![2];
              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(nameNonFuture),
                    accountEmail: Text(
                        emailNonFuture), // Modify this if you have an email field
                    currentAccountPicture: CircleAvatar(
                      child: const Icon(Icons.person),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.score),
                    title: const Text('Credit Score'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CibilCalculatorPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.swap_horiz),
                    title: const Text('Transactions'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CibilScoreUpdaterPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: const Text('Log Out'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30.0),
              FutureBuilder<int>(
                future: currentScore,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    int score = snapshot.data!;
                    if (score == 0) {
                      return Text(
                        'Credit Score Unavailable',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 160.0,
                              child: CustomPaint(
                                painter: _PieChartPainter(
                                  percentage: (score / 10).roundToDouble(),
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
                                  '$score/1000',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                const Text(
                                  'Credit Score',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 30.0),
              FutureBuilder<String>(
                future: name,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    String nameNonFuture = snapshot.data!;
                    return Text(
                      'Welcome, $nameNonFuture!',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSquareButton(
                    Icons.calculate,
                    'Calculate Cibil Score',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CibilCalculatorPage()),
                      );
                    },
                  ),
                  const SizedBox(width: 20.0),
                  _buildSquareButton(
                    Icons.swap_horiz,
                    'Transactions',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CibilScorePage()),
                      );
                    },
                  ),
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
                        MaterialPageRoute(builder: (context) => ProfilePage()),
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
              const SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _buildSquareButton(
                  Icons.analytics,
                  'Analysis',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnalysisFarmer()),
                    );
                  },
                ),
              ])
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
    final startAngle = (-pi / 2).round();
    final sweepAngle = 2 * pi * percentage.round();

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius.roundToDouble()),
      startAngle.roundToDouble(),
      sweepAngle.roundToDouble(),
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
    home: HomePage(),
  ));
}
