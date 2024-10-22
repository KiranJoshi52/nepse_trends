import 'package:flutter/material.dart';
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
            print('----- credentials ------');
            print(credential);
          },
          child: Text('Click Me'),
        ),
      ),
    );
  }
}
