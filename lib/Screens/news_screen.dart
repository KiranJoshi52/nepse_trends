// Placeholder screens for navigation
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  static const String newsScreenRoute = '/news';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: Center(child: Text('News Screen')),
    );
  }
}
