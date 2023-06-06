import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CibilScoreUpdaterPage extends StatefulWidget {
  @override
  _CibilScoreUpdaterPageState createState() => _CibilScoreUpdaterPageState();
}

class _CibilScoreUpdaterPageState extends State<CibilScoreUpdaterPage> {
  late TextEditingController _loansPaidBackController;
  late TextEditingController _loansTakenController;
  late TextEditingController _previousCreditScoreController;
  late TextEditingController _presentYearCropsController;
  late TextEditingController _totalBalanceController;

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
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data updated successfully')),
      );
    } catch (e) {
      print('Error updating data: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CIBIL Score Calculator'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              onPressed: updateData,
              child: Text('Update Parameters'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'CIBIL Score Calculator',
    home: CibilScoreUpdaterPage(),
  ));
}
