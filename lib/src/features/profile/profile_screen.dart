import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Demo Trainee'),
              subtitle: Text('demo@chqm.app'),
            ),
            SizedBox(height: 8),
            Text('Enrolled Programs: 2'),
            Text('Completed Exams: 1'),
            Text('Certificates: 1'),
          ],
        ),
      ),
    );
  }
}
