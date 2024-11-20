import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this); // 6 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          // Making the TabBar scrollable horizontally
          TabBar(
            controller: _tabController,
            isScrollable: true, // Allows horizontal scrolling
            tabs: const [
              Tab(
                  child: Text('My Portfolio',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              Tab(
                  child: Text('Allocation',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              Tab(
                  child: Text('Add Shares',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              Tab(
                  child: Text('History',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              Tab(
                  child: Text('Profit & Loss',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              Tab(
                  child: Text('Import',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.green[100],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Portfolio",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[900],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const PortfolioRow(
                                    "Current Investment", "Rs. 1,16,641.78"),
                                const PortfolioRow(
                                    "Net Worth", "Rs. 1,87,255.34"),
                                const PortfolioRow("Unrealized Gain",
                                    "Rs. 71,773.22 (+61.53%)"),
                                const PortfolioRow(
                                    "Today's Gain", "Rs. 832.0 (+0.72%)"),
                                const PortfolioRow("Units", "793.0"),
                                const PortfolioRow("Best Performer", "SARBTM"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Your Holdings Section
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Holdings",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[900],
                              ),
                            ),
                            SizedBox(height: 10),
                            HoldingCard("CLI", 10, 678.0, 6780.0, -30.0),
                            HoldingCard("GBIME", 120, 255.0, 30600.0, -120.0),
                            HoldingCard("GCIL", 11, 487.0, 5357.0, 22.0,
                                isPositive: true),
                            HoldingCard("H8020", 100, 10.0, 1000.0, -5.0),
                            HoldingCard("HRL", 20, 865.0, 17300.0, -20.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Center(child: Text('Allocation Screen')),
                const Center(child: Text('Add Shares Screen')),
                const Center(child: Text('History Screen')),
                const Center(child: Text('Profit & Loss Screen')),
                const Center(child: Text('Import Screen')),
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
      {this.isPositive = false});

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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("Units: $units, LTP: Rs. $ltp"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Rs. ${value.toStringAsFixed(2)}",
                  style: TextStyle(
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
