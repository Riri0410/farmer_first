import 'package:flutter/material.dart';

class CibilCalculatorPage extends StatefulWidget {
  @override
  _CibilCalculatorPageState createState() => _CibilCalculatorPageState();
}

class _CibilCalculatorPageState extends State<CibilCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _calculator = CreditScoreCalculator();
  double _presentYearCrops = 0.0;
  double _totalBalance = 0.0;
  double _loansTaken = 0.0;
  double _loansPaidBack = 0.0;
  double _previousCreditScore = 0.0;
  double _creditScore = 0.0;

  void _calculateCreditScore() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _creditScore = _calculator.calculateCreditScore(
          presentYearCrops: _presentYearCrops,
          totalBalance: _totalBalance,
          loansTaken: _loansTaken,
          loansPaidBack: _loansPaidBack,
          previousCreditScore: _previousCreditScore,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cibil Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Present Year Crops'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _presentYearCrops = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Total Balance'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _totalBalance = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Loans Taken'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _loansTaken = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Loans Paid Back'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _loansPaidBack = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Previous Credit Score'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _previousCreditScore = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Present Year Crops'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _presentYearCrops = double.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _calculateCreditScore,
                child: Text('Calculate'),
              ),
              SizedBox(height: 16.0),
              if (_creditScore > 0)
                Column(
                  children: [
                    Text(
                      'Credit Score: $_creditScore/1000',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 16.0),
                    CustomPaint(
                      size: Size(200, 200),
                      painter: CreditScorePainter(_creditScore),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreditScoreCalculator {
  double calculateCreditScore({
    required double presentYearCrops,
    required double totalBalance,
    required double loansTaken,
    required double loansPaidBack,
    required double previousCreditScore,
  }) {
    // Your credit score calculation logic here
    final weight1 = 0.3;
    final weight2 = 0.2;
    final weight3 = 0.2;
    final weight4 = 0.1;

    final normalizedPresentYearCrops = _normalize(presentYearCrops, 0, 100000);
    final normalizedTotalBalance = _normalize(totalBalance, 0, 200000);
    final normalizedLoansTaken = _normalize(loansTaken, 0, 10);
    final normalizedLoansPaidBack = _normalize(loansPaidBack, 0, 10);
    final normalizedPreviousCreditScore =
        _normalize(previousCreditScore, 0, 1000);

    final creditScore = ((normalizedPresentYearCrops * weight1) +
            (normalizedTotalBalance * weight2) +
            (normalizedLoansTaken * weight3) +
            (normalizedLoansPaidBack * weight3) +
            (normalizedPreviousCreditScore * weight4)) *
        10;

    return creditScore;
  }

  double _normalize(double value, double minValue, double maxValue) {
    return (value - minValue) / (maxValue - minValue) * 100;
  }
}

double _normalize(double value, double minValue, double maxValue) {
  return (value - minValue) / (maxValue - minValue) * 100;
}

class CreditScorePainter extends CustomPainter {
  final double creditScore;

  CreditScorePainter(this.creditScore);

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate angles for credit score
    final creditScoreAngle = 2 * 3.14 * (creditScore / 1000);
    final remainingAngle = 2 * 3.14 - creditScoreAngle;

    // Draw credit score arc
    final creditScorePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16.0;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -3.14 / 2,
      creditScoreAngle,
      false,
      creditScorePaint,
    );

    // Draw remaining arc
    final remainingPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16.0;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -3.14 / 2 + creditScoreAngle,
      remainingAngle,
      false,
      remainingPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Cibil Calculator',
    home: CibilCalculatorPage(),
  ));
}
