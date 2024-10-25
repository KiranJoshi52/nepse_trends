import 'package:flutter/material.dart';

class ShareTrainingScreen extends StatelessWidget {
  static const String shareTrainingScreenRoute = '/share_training';
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Share Training')),
      body: Center(child: Text('Share Training Screen')),
    );
  }
}