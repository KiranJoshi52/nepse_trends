import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nepse_trends/Screens/dashboard_screen.dart';
import 'package:nepse_trends/services/auth_services/auth_services.dart'; // Assuming auth services exist

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> getLoggedInUser() async {
    // Try to get the previously signed-in user
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    // Optionally, try to sign in silently (if user signed in before)
    if (user == null) {
      user = await _googleSignIn.signInSilently();
    }

    return user; // Will return null if no user is logged in
  }

  Future<void> _checkLoginStatus() async {
    // Add your logic to check if user is logged in
    final credential = await getLoggedInUser();
    if (credential != null) {
      setState(() {
        isLoggedIn = true;
      });
      // Navigate to the dashboard screen if already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login screen'),
      ),
      body: Center(
        child: isLoggedIn
            ? ElevatedButton(
                onPressed: () async {
                  // Add your onPressed action here
                  print('Button Pressed!');
                  final credential = await signInWithGoogle();
                  if (credential != null) {
                    print('----- credentials ------');
                    print(credential);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()),
                    );
                  } else {
                    print('Login failed');
                  }
                },
                child: Text('Click Me'),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
