import 'package:flutter/material.dart';

class NewSharesScreen extends StatelessWidget {
  static const String newSharesScreenRoute = '/new_shares';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Shares')),
      body: Center(child: Text('New Shares Screen')),
    );
  }
}