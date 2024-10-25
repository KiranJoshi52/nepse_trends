import 'package:flutter/material.dart';

class IpoResultScreen extends StatelessWidget {
  static const String ipoResultScreenRoute = '/ipo_result';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IPO Result')),
      body: Center(child: Text('IPO Result Screen')),
    );
  }
}