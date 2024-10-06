import 'package:flutter/material.dart';

class ShareCalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Calculator'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: 150, // Set a fixed height for the horizontal list
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              width: 150,
              margin: EdgeInsets.all(8.0),
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Item $index',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
