import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _panCardController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  Future<void> searchUsers() async {
    setState(() {
      _isLoading = true;
      _searchResults.clear();
    });

    String panCard = _panCardController.text;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('pancard', isEqualTo: panCard)
        .get();

    setState(() {
      _isLoading = false;
      _searchResults = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  void editParameters(int index) {
    // Navigate to the edit parameters page and pass the user details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditParametersPage(
          userDetails: _searchResults[index],
        ),
      ),
    ).then((_) {
      // Refresh search results after editing parameters
      searchUsers();
    });
  }

  Widget buildUserCard(int index) {
    Map<String, dynamic> userDetails = _searchResults[index];

    return Card(
      child: ListTile(
        title: Text('Name: ${userDetails['name']}'),
        subtitle: Text('Pan Card: ${userDetails['pancard']}'),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            editParameters(index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _panCardController,
              decoration: InputDecoration(
                labelText: 'Enter Pan Card',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: searchUsers,
              child: Text('Search'),
            ),
            SizedBox(height: 20.0),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return buildUserCard(index);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class EditParametersPage extends StatefulWidget {
  final Map<String, dynamic> userDetails;

  EditParametersPage({required this.userDetails});

  @override
  _EditParametersPageState createState() => _EditParametersPageState();
}

class _EditParametersPageState extends State<EditParametersPage> {
  TextEditingController _loansPaidBackController = TextEditingController();
  TextEditingController _loansTakenController = TextEditingController();
  TextEditingController _presentYearCropsController = TextEditingController();
  TextEditingController _totalBalanceController = TextEditingController();
  TextEditingController _previousCreditScoreController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with user details
    _loansPaidBackController.text =
        widget.userDetails['loansPaidBack'].toString();
    _loansTakenController.text = widget.userDetails['loansTaken'].toString();
    _presentYearCropsController.text =
        widget.userDetails['presentYearCrops'].toString();
    _totalBalanceController.text =
        widget.userDetails['totalBalance'].toString();
    _previousCreditScoreController.text =
        widget.userDetails['previousCreditScore'].toString();
  }

  void saveChanges() {
    // Get the updated parameter values from the controllers
    String loansPaidBack = _loansPaidBackController.text;
    String loansTaken = _loansTakenController.text;
    String presentYearCrops = _presentYearCropsController.text;
    String totalBalance = _totalBalanceController.text;
    String previousCreditScore = _previousCreditScoreController.text;

    // Update the user details in Firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userDetails['userId'])
        .update({
      'loansPaidBack': double.parse(loansPaidBack),
      'loansTaken': double.parse(loansTaken),
      'presentYearCrops': double.parse(presentYearCrops),
      'totalBalance': double.parse(totalBalance),
      'previousCreditScore': double.parse(previousCreditScore),
    }).then((_) {
      // Show a success message or navigate back to the previous page
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Parameters updated successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      // Show an error message
      print('Error: $error'); // Print the error message for debugging
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update parameters. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Parameters'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _loansPaidBackController,
              decoration: InputDecoration(
                labelText: 'Loans Paid Back',
              ),
            ),
            TextField(
              controller: _loansTakenController,
              decoration: InputDecoration(
                labelText: 'Loans Taken',
              ),
            ),
            TextField(
              controller: _presentYearCropsController,
              decoration: InputDecoration(
                labelText: 'Present Year Crops',
              ),
            ),
            TextField(
              controller: _totalBalanceController,
              decoration: InputDecoration(
                labelText: 'Total Balance',
              ),
            ),
            TextField(
              controller: _previousCreditScoreController,
              decoration: InputDecoration(
                labelText: 'Previous Credit Score',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
