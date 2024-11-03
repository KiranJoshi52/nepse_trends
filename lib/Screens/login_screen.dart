import 'package:flutter/material.dart';
import 'package:nepse_trends/Screens/dashboard_screen.dart';
import 'package:nepse_trends/provider/google_sign_in_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String loginScreenRoute = '/login';

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed during navigation
    final String? message = ModalRoute.of(context)?.settings.arguments as String?;

    // Display the SnackBar if the message exists
    if (message != null) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating, // Makes the snackbar float
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20), // Custom margins
          ),
        );
      });
    }

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
          Consumer<GoogleSignInProvider>(builder: (context, provider, child) {
            if (provider.user != null) {
              // Navigate to Dashboard if user is logged in
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                );
              });
              return Container(); // Return an empty container while navigating
            }

            return Center(
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
                    if (provider.isLoading)
                      const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    else
                      ElevatedButton.icon(
                        onPressed: () async {
                          await provider.signInWithGoogle();
                        },
                        icon: const Icon(Icons.login, size: 24),
                        label: const Text(
                          'Sign in with Google',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (!provider.isLoading)
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
            );
          }),
        ],
      ),
    );
  }
}
