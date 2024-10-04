import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.menu),
        title: Text('Dashboard'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Dashboard'),
            _buildDrawerItem(Icons.notifications, 'Notification'),
            _buildDrawerItem(Icons.announcement, 'Announcement'),
            _buildDrawerItem(Icons.announcement, 'Portfolio'),
            _buildDrawerItem(Icons.show_chart, 'Markets'),
            _buildDrawerItem(Icons.info, 'Service Info & Trainings'),
            _buildDrawerItem(Icons.calculate, 'Share Calculator'),
            _buildDrawerItem(Icons.build, 'Tools'),
            _buildDrawerItem(Icons.privacy_tip, 'Privacy/Disclaimers'),
            _buildDrawerItem(Icons.star_rate, 'Rate Us'),
            _buildDrawerItem(Icons.info, 'Info and Feedbacks'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: [
            _buildGridItem(Icons.article, 'Newsbvbb'),
            _buildGridItem(Icons.show_chart, 'Market'),
            _buildGridItem(Icons.table_chart, 'Floorsheet'),
            _buildGridItem(Icons.price_check, "Today's Price"),
            _buildGridItem(Icons.announcement, 'Portfolio'),
            _buildGridItem(Icons.calculate, 'Share Calculator'),
            _buildGridItem(Icons.mail, 'Newsletter'),
            _buildGridItem(Icons.analytics, 'Data Analytics'),
            _buildGridItem(Icons.new_releases, 'New Shares'),
            _buildGridItem(Icons.assignment, 'IPO Result'),
            _buildGridItem(Icons.school, 'Share Training'),
            _buildGridItem(Icons.local_offer, 'Mega Offers'),
            _buildGridItem(Icons.bar_chart, 'AI Charts'),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(label),
      onTap: () {
        // Handle the drawer item tap
      },
    );
  }

  Widget _buildGridItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.green, size: 50),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.green)),
      ],
    );
  }
}
