import 'package:flutter/material.dart';
import 'AboutScreen.dart';
import 'HelpScreen.dart';
import 'SalaryScreen.dart';
import 'ComplaintScreen.dart';
import 'ProfileScreen.dart'; // 
import 'SettingsScreens.dart';
import 'MessagesScreen.dart';
import 'FeedbackScreen.dart';

class DashboardScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final String userEmail;

  DashboardScreen({required this.userId, required this.userName, required this.userEmail});

  final List<Map<String, dynamic>> options = [
    {'icon': Icons.person, 'label': 'Profile'},
    {'icon': Icons.attach_money, 'label': 'Salary'},
    {'icon': Icons.help_outline, 'label': 'Help'},
    {'icon': Icons.settings, 'label': 'Settings'},
    {'icon': Icons.info, 'label': 'About'},
    {'icon': Icons.message, 'label': 'Messages'},
    {'icon': Icons.safety_check, 'label': 'Complain'},
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
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "Welcome $userName",
                style: TextStyle(color: Colors.white),
              ),
            ),
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
            if (item['label'] == 'Profile') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(
                    userId: userId,
                    userName: userName,
                    userEmail: userEmail,
                  ),
                ),
              );
            } else if (item['label'] == 'Salary') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SalaryScreen(userId: userId)),
              );
            } 
            else if (item['label'] == 'Profile') {
                Navigator.push(
                context,
                  MaterialPageRoute(
                  builder: (_) => ProfileScreen(
                userId: userId,
                userName: userName,
                userEmail: userEmail,
              ),
            ),
          );
        }

            else if (item['label'] == 'Help') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HelpScreen()),
              );
            } else if (item['label'] == 'About') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AboutScreen()),
              );
            } else if (item['label'] == 'Complain') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ComplaintScreen(userId: userId)),
              );
            } else if (item['label'] == 'Settings') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen(userId: userId,
                userName: userName,
                userEmail: userEmail,)), // Placeholder
              );
            } else if (item['label'] == 'Messages') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Messagesscreen()), // Placeholder
              );
            } else if (item['label'] == 'Feedback') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FeedbackScreen(userId: userId)),
              );
            } else if (item['label'] == 'Logout') {
              Navigator.pop(context);
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
