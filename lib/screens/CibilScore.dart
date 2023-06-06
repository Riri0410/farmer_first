import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CibilScorePage extends StatefulWidget {
  @override
  _CibilScorePageState createState() => _CibilScorePageState();
}

class _CibilScorePageState extends State<CibilScorePage> {
  late TextEditingController _loansPaidBackController;
  late TextEditingController _loansTakenController;
  late TextEditingController _previousCreditScoreController;
  late TextEditingController _presentYearCropsController;
  late TextEditingController _totalBalanceController;
  double _creditScore = 0.0;

  @override
  void initState() {
    super.initState();
    _loansPaidBackController = TextEditingController();
    _loansTakenController = TextEditingController();
    _previousCreditScoreController = TextEditingController();
    _presentYearCropsController = TextEditingController();
    _totalBalanceController = TextEditingController();
    fetchData();
  }

  @override
  void dispose() {
    _loansPaidBackController.dispose();
    _loansTakenController.dispose();
    _previousCreditScoreController.dispose();
    _presentYearCropsController.dispose();
    _totalBalanceController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      _loansPaidBackController.text = data['loansPaidBack'].toString();
      _loansTakenController.text = data['loansTaken'].toString();
      _previousCreditScoreController.text =
          data['previousCreditScore'].toString();
      _presentYearCropsController.text = data['presentYearCrops'].toString();
      _totalBalanceController.text = data['totalBalance'].toString();

      calculateCreditScore();
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error
    }
  }

  Future<void> updateData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'loansPaidBack': double.parse(_loansPaidBackController.text),
        'loansTaken': double.parse(_loansTakenController.text),
        'previousCreditScore':
            double.parse(_previousCreditScoreController.text),
        'presentYearCrops': double.parse(_presentYearCropsController.text),
        'totalBalance': double.parse(_totalBalanceController.text),
        'currentscore': _creditScore,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data updated successfully')),
      );
    } catch (e) {
      print('Error updating data: $e');
      // Handle error
    }
  }

  void calculateCreditScore() {
    final calculator = CreditScoreCalculator();
    final double loansPaidBack = double.parse(_loansPaidBackController.text);
    final double loansTaken = double.parse(_loansTakenController.text);
    final double previousCreditScore =
        double.parse(_previousCreditScoreController.text);
    final double presentYearCrops =
        double.parse(_presentYearCropsController.text);
    final double totalBalance = double.parse(_totalBalanceController.text);

    setState(() {
      _creditScore = calculator.calculateCreditScore(
        presentYearCrops: presentYearCrops,
        totalBalance: totalBalance,
        loansTaken: loansTaken,
        loansPaidBack: loansPaidBack,
        previousCreditScore: previousCreditScore,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CIBIL Score Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _loansPaidBackController,
              decoration: InputDecoration(labelText: 'Loans Paid Back'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _loansTakenController,
              decoration: InputDecoration(labelText: 'Loans Taken'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _previousCreditScoreController,
              decoration: InputDecoration(labelText: 'Previous Credit Score'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _presentYearCropsController,
              decoration: InputDecoration(labelText: 'Present Year Crops'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _totalBalanceController,
              decoration: InputDecoration(labelText: 'Total Balance'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                calculateCreditScore();
                updateData();
              },
              child: Text('Update Parameters'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Credit Score: $_creditScore',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
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

void main() {
  runApp(MaterialApp(
    title: 'CIBIL Score Calculator',
    home: CibilScorePage(),
  ));
}
