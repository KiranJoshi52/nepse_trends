import 'package:flutter/material.dart';

class DataAnalyticsScreen extends StatelessWidget {
  static const String dataAnalyticsScreenRoute = '/data_analytics';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Analytics')),
      body: Center(child: Text('Data Analytics Screen')),
    );
  }
}