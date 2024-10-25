import 'package:flutter/material.dart';

class TodaysPriceScreen extends StatelessWidget {
  static const String todaysPriceScreenRoute = '/todays_price';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Today's Price")),
      body: Center(child: Text("Today's Price Screen")),
    );
  }
}
