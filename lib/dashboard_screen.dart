import 'package:flutter/material.dart';
import 'AboutScreen.dart';
import 'HelpScreen.dart'; // Make sure this import is correct
import 'SalaryScreen.dart'; // make sure file name matches

class DashboardScreen extends StatelessWidget {
    final int userId;
    final String userName; // ✅ Add this

  DashboardScreen({required this.userId, required this.userName});
  final List<Map<String, dynamic>> options = [
    {'icon': Icons.person, 'label': 'Profile'},
    {'icon': Icons.attach_money, 'label': 'Salary'},
    {'icon': Icons.help_outline, 'label': 'Help'},
    {'icon': Icons.settings, 'label': 'Settings'},
    {'icon': Icons.info, 'label': 'About'}, // We'll link this to AboutScreen
    {'icon': Icons.message, 'label': 'Messages'},
    {'icon': Icons.security, 'label': 'Security'},
    {'icon': Icons.feedback, 'label': 'Feedback'},
    {'icon': Icons.logout, 'label': 'Logout'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions:  [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(child: Text("Welcome ${userName}",
             style: TextStyle(color: Colors.white),
            )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildRow(context, 0),
            const SizedBox(height: 20),
            buildRow(context, 3),
            const SizedBox(height: 20),
            buildRow(context, 6),
          ],
        ),
      ),
    );
  }

  Widget buildRow(BuildContext context, int startIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (i) {
        final item = options[startIndex + i];

        return GestureDetector(
          onTap: () {
            if (item['label'] == 'About') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            }
             else if (item['label'] == 'Help') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              );
            }
             else if (item['label'] == 'Salary') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SalaryScreen(userId: userId)),
              );
            }  else if (item['label'] == 'Logout') {
              Navigator.pop(context); // Just go back for now
            }
          },
          child: Column(
            children: [
              Icon(item['icon'], size: 40, color: Colors.green),
              const SizedBox(height: 5),
              Text(item['label'], style: const TextStyle(fontSize: 13)),
            ],
          ),
        );
      }),
    );
  }
}
