import 'package:flutter/material.dart';

class MegaOffersScreen extends StatelessWidget {
  static const String megaOffersScreenRoute = '/mega_offers';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mega Offers')),
      body: Center(child: Text('Mega Offers Screen')),
    );
  }
}