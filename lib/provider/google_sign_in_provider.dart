import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  User? _user;
  bool _isLoading = false; // New loading state
  User? get user => _user;
  bool get isLoading => _isLoading; // Getter for loading state

  Future<void> signInWithGoogle() async {
    _isLoading = true; // Start loading
    notifyListeners(); // Notify listeners about the change

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      
      _user = userCredential.user;
    } catch (error) {
      print('Error during Google sign-in: $error');
    } finally {
      _isLoading = false; // Stop loading
      notifyListeners(); // Notify listeners about the change
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners(); // Notify listeners about the change
  }
}
