import 'package:flutter/material.dart';

class FloorsheetScreen extends StatelessWidget {
  static const String floorsheetScreenRoute = '/floorsheet';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Floorsheet')),
      body: Center(child: Text('Floorsheet Screen')),
    );
  }
}