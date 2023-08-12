import 'package:flutter/material.dart';
import 'StorageManager.dart'; // Import the StorageManager class
import 'TestPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final StorageManager _storageManager = StorageManager();

  Future<void> _handleLogin(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Store the login data
    await _storageManager.saveLoginData(username, password);

    // Navigate to the Test page with route arguments
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestPage(),
      ),
    );
  }

  void _goToTestPage(BuildContext context) {
    // Directly navigate to the Test page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadLoginData();
  }

  Future<void> _loadLoginData() async {
    final loginData = await _storageManager.getLoginData();
    if (loginData != null && loginData is Map<String, String>) {
      _usernameController.text = loginData['username'] ?? '';
      _passwordController.text = loginData['password'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _handleLogin(context),
              child: Text('Login'),
            ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () => _goToTestPage(context),
              child: Text('Go to Test Page (Skip Login)'),
            ),
          ],
        ),
      ),
    );
  }
}
