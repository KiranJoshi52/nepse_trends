import 'package:flutter/material.dart';
import 'package:nepse_trends/Screens/dashboard_screen.dart';
import 'package:nepse_trends/services/auth_services/auth_services.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Add your onPressed action here
            print('Button Pressed!');
            final credential = await signInWithGoogle();
            // print('----- credentials ------');
            // print(credential);
            if (credential != null) {
              print('----- credentials ------');
              print(credential);
              // Navigate to the HomeScreen after successful login
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            } else {
              print('Login failed');
            }
          },
          child: Text('Click Me'),
        ),
      ),
    );
  }
}
