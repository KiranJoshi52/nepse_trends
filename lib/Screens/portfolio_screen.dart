import 'package:flutter/material.dart';

class PortfolioScreen extends StatelessWidget {
  static const String portfolioScreenRoute = '/portfolio';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Portfolio')),
      body: Center(child: Text('Portfolio Screen')),
    );
  }
}
