  import 'package:flutter/material.dart';

Widget buildGridItem(
      BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.green, size: 50),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }