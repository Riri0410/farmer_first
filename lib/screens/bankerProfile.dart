import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isPanCardVisible = false;
  bool _isPasswordVisible = false;
  String _panCardNumber = 'P21312412';
  String _email = 'johndoe@example.com';
  String _password = 'Apple';
  String _name = 'John Doe';

  String _newName = '';
  String _newPassword = '';

  final _nameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  void _showChangeNameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Name'),
          content: Form(
            key: _nameFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: _name,
                  decoration: const InputDecoration(
                    labelText: 'New Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _newName = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_nameFormKey.currentState!.validate()) {
                  setState(() {
                    _name = _newName;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Change'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Form(
            key: _passwordFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _newPassword = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_passwordFormKey.currentState!.validate()) {
                  setState(() {
                    _password = _newPassword;
                    _isPasswordVisible = false;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Change'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  child: Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              ListTile(
                leading: const Icon(Icons.person),
                title: Row(
                  children: [
                    Text(
                      'Name: $_name',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(width: 10.0),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _showChangeNameDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              ListTile(
                leading: const Icon(Icons.credit_card),
                title: Text(
                  'PanCard Number: ${_isPanCardVisible ? _panCardNumber : '********'}',
                  style: TextStyle(fontSize: 18.0),
                ),
                trailing: IconButton(
                  icon: Icon(
                    _isPanCardVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPanCardVisible = !_isPanCardVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(
                  'Email: $_email',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(height: 20.0),
              ListTile(
                leading: const Icon(Icons.lock),
                title: Row(
                  children: [
                    Text(
                      'Password: ${_isPasswordVisible ? _password : '********'}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(width: 10.0),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _showChangePasswordDialog(context);
                      },
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BankerProfilePage extends StatelessWidget {
  final String bankerId = '12332';
  final String bankName = 'SBI Bank';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banker Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text(
                'Banker ID: $bankerId',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 20.0),
            ListTile(
              leading: Icon(Icons.business),
              title: Text(
                'Bank Name: $bankName',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfilePage(),
  ));
}
