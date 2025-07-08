import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingsScreen extends StatefulWidget {
  final int userId;
  final String userName;
  final String userEmail;

  const SettingsScreen({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  final passwordController = TextEditingController();
  String message = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userName);
    emailController = TextEditingController(text: widget.userEmail);
  }

  Future<void> updateUser() async {
    setState(() {
      isLoading = true;
      message = '';
    });

    final url = Uri.parse('http://127.0.0.1:8000/api/users/${widget.userId}');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text.isNotEmpty ? passwordController.text : null,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          message = data['message'];
        });
      } else {
        setState(() {
          message = 'Failed: ${data['message'] ?? 'Unknown error'}';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
            ),
            SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
            ),
            SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password (optional)', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(onPressed: updateUser, child: Text('Update')),
            if (message.isNotEmpty) ...[
              SizedBox(height: 15),
              Text(message, style: TextStyle(color: Colors.green)),
            ]
          ],
        ),
      ),
    );
  }
}
