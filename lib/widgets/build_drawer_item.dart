import 'package:flutter/material.dart';

Widget buildDrawerItem(
    BuildContext context, IconData icon, String label, String route) {
  return ListTile(
    leading: Icon(icon, color: Colors.green),
    title: Text(label),
    onTap: () {
      Navigator.pushNamed(context, route);
    },
  );
}
