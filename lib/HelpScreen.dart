import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Need Help?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '• If you forgot your password, contact admin.\n'
              '• For internet issues, contact the IT department.\n'
              '• For salary-related queries, contact HR.\n'
              '• You can also send feedback using the Feedback option.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // go back
                },
                child: Text('Back'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
