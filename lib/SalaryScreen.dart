import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SalaryScreen extends StatefulWidget {
  final int userId;
  const SalaryScreen({required this.userId});

  @override
  _SalaryScreenState createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  List<dynamic> salaries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSalaries();
  }

  Future<void> fetchSalaries() async {
    final url = 'http://127.0.0.1:8000/api/salaries/${widget.userId}';
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        salaries = data['salaries'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Error fetching salary data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Salary Details')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: salaries.length,
              itemBuilder: (context, index) {
                final salary = salaries[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Month: ${salary['month']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Basic Salary: ${salary['basic_salary']}'),
                        Text('Allowances: ${salary['Allownces']}'),
                        Text('Cutting: ${salary['Cutting']}'),
                        Text('Net Salary: ${salary['Net Salary']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
