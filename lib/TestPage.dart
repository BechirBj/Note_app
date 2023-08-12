import 'package:flutter/material.dart';
import 'StorageManager.dart'; // Import the StorageManager class

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final StorageManager _storageManager = StorageManager();
  String _username = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _loadLoginData();
  }

  Future<void> _loadLoginData() async {
    final loginData = await _storageManager.getLoginData();
    if (loginData != null && loginData is Map<String, String>) {
      setState(() {
        _username = loginData['username'] ?? '';
        _password = loginData['password'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Username: $_username'),
            SizedBox(height: 12.0),
            Text('Password: $_password'),
          ],
        ),
      ),
    );
  }
}
