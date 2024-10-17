import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 50),
            // Image.asset('assets/image/logo.png'), // Add your logo here
            SizedBox(height: 20),
            Text(
              'Email / Mobile Number',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email or Phone is Invalid',
                errorText: 'Email or Phone is Invalid',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Password / Pin',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.visibility),
                hintText: 'Enter valid pin or password',
                errorText: 'Enter valid pin or password',
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Forgot password action
                },
                child: Text('Forgot Password?'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Login action
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.teal, // Adjust according to design
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(child: Divider()),
                Text("Or Continue with"),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Login with Google action
              },
              icon: Icon(Icons.g_mobiledata),
              label: Text('Login with Google'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Register action
              },
              child: Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
