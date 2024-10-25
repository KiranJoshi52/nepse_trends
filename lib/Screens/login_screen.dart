import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nepse_trends/Screens/dashboard_screen.dart';
import 'package:nepse_trends/services/auth_services/auth_services.dart'; // Assuming AuthService exists

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String loginScreenRoute = '/';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;
  bool isLoading = true;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Reduced async operations to minimize delays and overhead
  Future<GoogleSignInAccount?> _getLoggedInUser() async {
    try {
      GoogleSignInAccount? user = _googleSignIn.currentUser ?? await _googleSignIn.signInSilently();
      return user;
    } catch (error) {
      debugPrint('Error in signInSilently: $error');
      return null;
    }
  }

  Future<void> _checkLoginStatus() async {
    final user = await _getLoggedInUser();

    if (user != null) {
      setState(() {
        isLoggedIn = true;
      });

      // Navigate to the dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      setState(() {
        isLoading = false; // Stop loading if no user is logged in
      });
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      isLoading = true; // Start loading when sign-in is initiated
    });

    try {
      final credential = await signInWithGoogle();

      if (credential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        _showErrorSnackBar('Google sign-in failed. Please try again.');
      }
    } catch (error) {
      debugPrint('Error during sign-in: $error');
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar('Sign-in failed. Please try again.');
    }
  }

  // Show error snackbar (reusable)
  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Nepse Trends'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in to access Nepse Trends',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : ElevatedButton.icon(
                          onPressed: _handleGoogleSignIn,
                          icon: const Icon(Icons.login, size: 24),
                          label: const Text(
                            'Sign in with Google',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  if (!isLoading)
                    const Text(
                      'Access market trends and insights effortlessly.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
