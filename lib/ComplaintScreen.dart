import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ComplaintScreen extends StatefulWidget {
  final int userId; // Passed from Dashboard

  const ComplaintScreen({required this.userId});

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  String? selectedCategory;
  String? selectedSubcategory;
  final addressController = TextEditingController();
  String message = '';
  bool isLoading = false;

  final Map<String, List<String>> subcategories = {
    'Electric': ['No Power', 'Short Circuit', 'Light Flickering', 'Wiring Issue', 'Other'],
    'Water': ['Leakage', 'No Water', 'Low Pressure', 'Contamination', 'Other'],
    'Gas': ['Leakage', 'Low Pressure', 'No Gas', 'Billing Issue', 'Other'],
  };

  List<String> get subcategoryList =>
      selectedCategory != null ? subcategories[selectedCategory!]! : [];

  Future<void> submitComplaint() async {
    final category = selectedCategory;
    final subcategory = selectedSubcategory;
    final address = addressController.text;

    if (category == null || subcategory == null || address.isEmpty) {
      setState(() {
        message = 'Please fill all fields';
      });
      return;
    }

    setState(() {
      isLoading = true;
      message = '';
    });

    final url = Uri.parse('http://127.0.0.1:8000/api/complaints');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': widget.userId,
          'category': category,
          'subcategory': subcategory,
          'address': address,
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          message = 'Complaint submitted successfully!';
        });
        addressController.clear();
        setState(() {
          selectedCategory = null;
          selectedSubcategory = null;
        });
      } else {
        setState(() {
          message = 'Failed to submit complaint';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Server not reachable';
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Complaint')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCategory,
              hint: Text('Select Category'),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  selectedSubcategory = null;
                });
              },
              items: subcategories.keys.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedSubcategory,
              hint: Text('Select Subcategory'),
              onChanged: (value) {
                setState(() {
                  selectedSubcategory = value;
                });
              },
              items: subcategoryList.map((sub) {
                return DropdownMenuItem(value: sub, child: Text(sub));
              }).toList(),
            ),
            SizedBox(height: 15),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            if (message.isNotEmpty)
              Text(
                message,
                style: TextStyle(color: message.contains('success') ? Colors.green : Colors.red),
              ),
            SizedBox(height: 10),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: submitComplaint,
                    child: Text('Submit'),
                  ),
          ],
        ),
      ),
    );
  }
}
