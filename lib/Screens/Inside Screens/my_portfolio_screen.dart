import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyPortfolioScreen extends StatefulWidget {
  const MyPortfolioScreen({super.key});

  @override
  State<MyPortfolioScreen> createState() => _MyPortfolioScreenState();
}

class _MyPortfolioScreenState extends State<MyPortfolioScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // NEPSE Info Section
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Container(
              // color: Colors.green[100],
              padding:
                  // const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nepse: 2757.27",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  Text(
                    "(+0.81%)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // PageView with Smooth Indicator
          SizedBox(
            height: 290,
            child: PageView(
              controller: _pageController,
              children: [
                _buildPortfolioCard(),
                _buildOverallPortfolioCard(),
              ],
            ),
          ),
          // const SizedBox(height: 16),
          SmoothPageIndicator(
            controller: _pageController,
            count: 2,
            effect: const WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.green,
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),

          // Your Holdings Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Holdings",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                ),
                const SizedBox(height: 10),
                const HoldingCard("CLI", 10, 678.0, 6780.0, -30.0),
                const HoldingCard("GBIME", 120, 255.0, 30600.0, -120.0),
                const HoldingCard("GCIL", 11, 487.0, 5357.0, 22.0,
                    isPositive: true),
                const HoldingCard("H8020", 100, 10.0, 1000.0, -5.0),
                const HoldingCard("HRL", 20, 865.0, 17300.0, -20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPortfolioCard() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
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
            const PortfolioRow("Current Investment", "Rs. 1,16,641.78"),
            const PortfolioRow("Net Worth", "Rs. 1,87,255.34"),
            const PortfolioRow("Unrealized Gain/loss today", "Rs. 71"),
            const PortfolioRow("Today's Gain", "Rs. 832.0 (+0.72%)"),
            const PortfolioRow("Net-worth", "793.0"),
            const PortfolioRow("Realised gain/loss today", "Rs. 900"),
          ],
        ),
      ),
    ),
  );
}

Widget _buildOverallPortfolioCard() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
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
              "Overall Portfolio",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            const SizedBox(height: 10),
            const PortfolioRow("Overall Purchase", "Rs. 1,16,641.78"),
            const PortfolioRow("Overall sale", "Rs. 1,87,255.34"),
            const PortfolioRow("Taxes & commission on purchase", "Rs. 71"),
            const PortfolioRow("Capital gain tax", "Rs. 832.0 (+0.72%)"),
            const PortfolioRow("Commission on sale", "793.0"),
            const PortfolioRow("Realised gain/loss", "Rs. 600"),
          ],
        ),
      ),
    ),
  );
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
