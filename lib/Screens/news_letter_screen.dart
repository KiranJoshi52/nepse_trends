import 'package:flutter/material.dart';

class NewsletterScreen extends StatelessWidget {
  static const String newsletterScreenRoute = '/newsletter';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Newsletter')),
      body: Center(child: Text('Newsletter Screen')),
    );
  }
}