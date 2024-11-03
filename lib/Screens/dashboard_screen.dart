import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nepse_trends/provider/google_sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:nepse_trends/constants/color.dart';
import 'package:nepse_trends/widgets/build_drawer_item.dart';
import 'package:nepse_trends/widgets/build_grid_item.dart';

class DashboardScreen extends StatelessWidget {
  static const String dashboardScreenRoute = '/dashboard_screen';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Implement notifications functionality
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // Navigate to user profile or settings
                },
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: primaryColor),
              accountName: Text(
                user?.displayName ?? 'User Name',
                style: const TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                user?.email ?? 'user@example.com',
                style: const TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                child: user?.photoURL == null
                    ? const Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 50,
                      )
                    : null,
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  buildDrawerItem(context, Icons.dashboard, 'Dashboard', '/'),
                  const Divider(),
                  buildDrawerItem(context, Icons.article, 'News', '/news'),
                  buildDrawerItem(context, Icons.show_chart, 'Market', '/market'),
                  buildDrawerItem(context, Icons.table_chart, 'Floorsheet', '/floorsheet'),
                  buildDrawerItem(context, Icons.price_check, "Today's Price", '/todays_price'),
                  buildDrawerItem(context, Icons.business_center, 'Portfolio', '/portfolio'),
                  buildDrawerItem(context, Icons.calculate, 'Share Calculator', '/share_calculator'),
                  buildDrawerItem(context, Icons.mail, 'Newsletter', '/newsletter'),
                  buildDrawerItem(context, Icons.analytics, 'Data Analytics', '/data_analytics'),
                  buildDrawerItem(context, Icons.new_releases, 'New Shares', '/new_shares'),
                  buildDrawerItem(context, Icons.assignment, 'IPO Result', '/ipo_result'),
                  buildDrawerItem(context, Icons.school, 'Share Training', '/share_training'),
                  buildDrawerItem(context, Icons.local_offer, 'Mega Offers', '/mega_offers'),
                  buildDrawerItem(context, Icons.bar_chart, 'AI Charts', '/ai_charts'),
                  const Divider(),
                  // Add logout button in the drawer
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () async {
                      // Show confirmation dialog
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Logout'),
                            content:
                                const Text('Are you sure you want to logout?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pop(false), // User pressed "No"
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pop(true), // User pressed "Yes"
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );

                      // Check the user's response
                      if (shouldLogout == true) {
                        await googleSignInProvider.signOut();
                        Navigator.of(context).pushReplacementNamed(
                            '/login'); // Adjust this route as necessary
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 13,
          itemBuilder: (context, index) {
            final List<Map<String, dynamic>> gridItems = [
              {'icon': Icons.article, 'label': 'News', 'route': '/news'},
              {'icon': Icons.show_chart, 'label': 'Market', 'route': '/market'},
              {'icon': Icons.table_chart, 'label': 'Floorsheet', 'route': '/floorsheet'},
              {'icon': Icons.price_check, 'label': "Today's Price", 'route': '/todays_price'},
              {'icon': Icons.business_center, 'label': 'Portfolio', 'route': '/portfolio'},
              {'icon': Icons.calculate, 'label': 'Share Calculator', 'route': '/share_calculator'},
              {'icon': Icons.mail, 'label': 'Newsletter', 'route': '/newsletter'},
              {'icon': Icons.analytics, 'label': 'Data Analytics', 'route': '/data_analytics'},
              {'icon': Icons.new_releases, 'label': 'New Shares', 'route': '/new_shares'},
              {'icon': Icons.assignment, 'label': 'IPO Result', 'route': '/ipo_result'},
              {'icon': Icons.school, 'label': 'Share Training', 'route': '/share_training'},
              {'icon': Icons.local_offer, 'label': 'Mega Offers', 'route': '/mega_offers'},
              {'icon': Icons.bar_chart, 'label': 'AI Charts', 'route': '/ai_charts'},
            ];

            final item = gridItems[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, item['route']);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 40, color: primaryColor),
                    const SizedBox(height: 8),
                    Text(
                      item['label'],
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
