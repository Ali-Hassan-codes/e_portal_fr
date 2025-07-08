import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackScreen extends StatefulWidget {
  final int userId;

  const FeedbackScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  bool isLoading = false;
  String message = '';

  Future<void> submitFeedback() async {
    setState(() {
      isLoading = true;
      message = '';
    });

    final url = Uri.parse('http://127.0.0.1:8000/api/feedback');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': widget.userId,
          'message': _feedbackController.text,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          message = 'Feedback submitted successfully';
          _feedbackController.clear();
        });
      } else {
        setState(() {
          message = 'Submission failed';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Server error';
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _feedbackController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Enter your feedback here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: submitFeedback,
                    child: Text('Submit'),
                  ),
            SizedBox(height: 10),
            if (message.isNotEmpty)
              Text(
                message,
                style: TextStyle(color: Colors.green),
              )
          ],
        ),
      ),
    );
  }
}
