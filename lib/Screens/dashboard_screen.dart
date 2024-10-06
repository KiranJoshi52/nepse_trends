import 'package:flutter/material.dart';
import 'package:nepse_trends/widgets/build_drawer_item.dart';
import 'package:nepse_trends/widgets/build_grid_item.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
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
            buildDrawerItem(context, Icons.dashboard, 'Dashboard', '/'),
            buildDrawerItem(context, Icons.article, 'News', '/news'),
            buildDrawerItem(context, Icons.show_chart, 'Market', '/market'),
            buildDrawerItem(
                context, Icons.table_chart, 'Floorsheet', '/floorsheet'),
            buildDrawerItem(
                context, Icons.price_check, "Today's Price", '/todays_price'),
            buildDrawerItem(
                context, Icons.calculate, 'Portfolio', '/portfolio'),
            buildDrawerItem(context, Icons.calculate, 'Share Calculator',
                '/share_calculator'),
            buildDrawerItem(context, Icons.mail, 'Newsletter', '/newsletter'),
            buildDrawerItem(
                context, Icons.analytics, 'Data Analytics', '/data_analytics'),
            buildDrawerItem(
                context, Icons.new_releases, 'New Shares', '/new_shares'),
            buildDrawerItem(
                context, Icons.assignment, 'IPO Result', '/ipo_result'),
            buildDrawerItem(
                context, Icons.school, 'Share Training', '/share_training'),
            buildDrawerItem(
                context, Icons.local_offer, 'Mega Offers', '/mega_offers'),
            buildDrawerItem(
                context, Icons.bar_chart, 'AI Charts', '/ai_charts'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: [
            buildGridItem(context, Icons.article, 'News', '/news'),
            buildGridItem(context, Icons.show_chart, 'Market', '/market'),
            buildGridItem(
                context, Icons.table_chart, 'Floorsheet', '/floorsheet'),
            buildGridItem(
                context, Icons.price_check, "Today's Price", '/todays_price'),
            buildGridItem(context, Icons.calculate, 'Portfolio', '/portfolio'),
            buildGridItem(context, Icons.calculate, 'Share Calculator',
                '/share_calculator'),
            buildGridItem(context, Icons.mail, 'Newsletter', '/newsletter'),
            buildGridItem(
                context, Icons.analytics, 'Data Analytics', '/data_analytics'),
            buildGridItem(
                context, Icons.new_releases, 'New Shares', '/new_shares'),
            buildGridItem(
                context, Icons.assignment, 'IPO Result', '/ipo_result'),
            buildGridItem(
                context, Icons.school, 'Share Training', '/share_training'),
            buildGridItem(
                context, Icons.local_offer, 'Mega Offers', '/mega_offers'),
            buildGridItem(context, Icons.bar_chart, 'AI Charts', '/ai_charts'),
          ],
        ),
      ),
    );
  }
}
