import 'package:flutter/material.dart';

class AiChartsScreen extends StatelessWidget {
  static const String aiChartsScreenRoute = '/ai_charts';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Charts')),
      body: Center(child: Text('AI Charts Screen')),
    );
  }
}
