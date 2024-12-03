import 'package:flutter/material.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/my_portfolio_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/add_shares_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/allocation_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/import_portfolio_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/versus_comparison_app.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/watchlists.dart';
import 'package:nepse_trends/constants/color.dart';

class PortfolioScreen extends StatefulWidget {
  static const String portfolioScreenRoute = '/portfolio';

  const PortfolioScreen({super.key});

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this); // 6 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Portfolio',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // TabBar with scrolling functionality
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(
                child: Text(
                  'My Portfolio',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Allocation',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Watchlists',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Add Shares',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'History',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Profit & Loss',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Import',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                MyPortfolioScreen(),
                AllocationScreen(),
                Watchlists(),
                AddSharesScreen(),
                // Center(child: Text('History Screen')),
                Center(child: VersusComparisonApp()),
                Center(child: Text('Profit & Loss Screen')),
                Center(child: ImportPortfolioScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PortfolioRow extends StatelessWidget {
  final String title;
  final String value;

  const PortfolioRow(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.green[800]),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class HoldingCard extends StatelessWidget {
  final String symbol;
  final int units;
  final double ltp;
  final double value;
  final double change;
  final bool isPositive;

  const HoldingCard(this.symbol, this.units, this.ltp, this.value, this.change,
      {super.key, this.isPositive = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("Units: $units, LTP: Rs. $ltp"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Rs. ${value.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Rs. ${change.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
