import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'ChangePasswordForm.dart';

class AccountPage extends StatelessWidget {
  final String username;
  final String email;
  final String mobile;

  const AccountPage({super.key,
    required this.username,
    required this.email,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.all(5),
              child: TextButton(
                onPressed: (){
                  context.go("/home");
                },
                child: const Text("Home"),
              )
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: $username', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Email: $email', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Mobile: $mobile', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Code to delete account
                // You can show a confirmation dialog before deleting
              },
              child: const Text('Delete Account'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to ChangePasswordPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                );
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}

