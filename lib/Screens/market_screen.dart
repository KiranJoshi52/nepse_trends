import 'package:flutter/material.dart';

class MarketScreen extends StatelessWidget {
  static const String marketScreenRoute = '/market';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Market')),
      body: Center(child: Text('Market Screen')),
    );
  }
}
