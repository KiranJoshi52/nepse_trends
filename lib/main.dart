import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/news': (context) => NewsScreen(),
        '/market': (context) => MarketScreen(),
        '/floorsheet': (context) => FloorsheetScreen(),
        '/todays_price': (context) => TodaysPriceScreen(),
        '/portfolio': (context) => PortfolioScreen(),
        '/share_calculator': (context) => ShareCalculatorScreen(),
        '/newsletter': (context) => NewsletterScreen(),
        '/data_analytics': (context) => DataAnalyticsScreen(),
        '/new_shares': (context) => NewSharesScreen(),
        '/ipo_result': (context) => IpoResultScreen(),
        '/share_training': (context) => ShareTrainingScreen(),
        '/mega_offers': (context) => MegaOffersScreen(),
        '/ai_charts': (context) => AiChartsScreen(),
      },
    );
  }
}

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
            _buildDrawerItem(context, Icons.dashboard, 'Dashboard', '/'),
            _buildDrawerItem(context, Icons.article, 'News', '/news'),
            _buildDrawerItem(context, Icons.show_chart, 'Market', '/market'),
            _buildDrawerItem(context, Icons.table_chart, 'Floorsheet', '/floorsheet'),
            _buildDrawerItem(context, Icons.price_check, "Today's Price", '/todays_price'),
            _buildDrawerItem(context, Icons.calculate, 'Portfolio', '/portfolio'),
            _buildDrawerItem(context, Icons.calculate, 'Share Calculator', '/share_calculator'),
            _buildDrawerItem(context, Icons.mail, 'Newsletter', '/newsletter'),
            _buildDrawerItem(context, Icons.analytics, 'Data Analytics', '/data_analytics'),
            _buildDrawerItem(context, Icons.new_releases, 'New Shares', '/new_shares'),
            _buildDrawerItem(context, Icons.assignment, 'IPO Result', '/ipo_result'),
            _buildDrawerItem(context, Icons.school, 'Share Training', '/share_training'),
            _buildDrawerItem(context, Icons.local_offer, 'Mega Offers', '/mega_offers'),
            _buildDrawerItem(context, Icons.bar_chart, 'AI Charts', '/ai_charts'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: [
            _buildGridItem(Icons.article, 'News'),
            _buildGridItem(Icons.show_chart, 'Market'),
            _buildGridItem(Icons.table_chart, 'Floorsheet'),
            _buildGridItem(Icons.price_check, "Today's Price"),
            _buildGridItem(Icons.calculate, 'Portfolio'),
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

  Widget _buildDrawerItem(BuildContext context, IconData icon, String label, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(label),
      onTap: () {
        Navigator.pushNamed(context, route);
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

// Placeholder screens for navigation
class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: Center(child: Text('News Screen')),
    );
  }
}

class MarketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Market')),
      body: Center(child: Text('Market Screen')),
    );
  }
}

class FloorsheetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Floorsheet')),
      body: Center(child: Text('Floorsheet Screen')),
    );
  }
}

class TodaysPriceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Today's Price")),
      body: Center(child: Text("Today's Price Screen")),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Portfolio')),
      body: Center(child: Text('Portfolio Screen')),
    );
  }
}

class ShareCalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Share Calculator')),
      body: Center(child: Text('Share Calculator Screen')),
    );
  }
}

class NewsletterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Newsletter')),
      body: Center(child: Text('Newsletter Screen')),
    );
  }
}

class DataAnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Analytics')),
      body: Center(child: Text('Data Analytics Screen')),
    );
  }
}

class NewSharesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Shares')),
      body: Center(child: Text('New Shares Screen')),
    );
  }
}

class IpoResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IPO Result')),
      body: Center(child: Text('IPO Result Screen')),
    );
  }
}

class ShareTrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Share Training')),
      body: Center(child: Text('Share Training Screen')),
    );
  }
}

class MegaOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mega Offers')),
      body: Center(child: Text('Mega Offers Screen')),
    );
  }
}

class AiChartsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Charts')),
      body: Center(child: Text('AI Charts Screen')),
    );
  }
}
