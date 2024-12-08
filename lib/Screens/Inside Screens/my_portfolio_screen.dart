import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyPortfolioScreen extends StatefulWidget {
  const MyPortfolioScreen({super.key});

  @override
  State<MyPortfolioScreen> createState() => _MyPortfolioScreenState();
}

class _MyPortfolioScreenState extends State<MyPortfolioScreen> {
  final PageController _pageController = PageController();

  String? selectedInvestor;
  String? selectedInvestorType;

  final List<String> investors = ["Investor 1", "Investor 2", "Investor 3"];
  final List<String> investorTypes = ["Retail", "Institutional", "HNI"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NEPSE Info Section (Moved to the top)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
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

          // Investor Dropdowns (Reduced height by 40%)
          Padding(
            // padding: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                // Choose Investor Dropdown
                Container(
                  height: 52, // Reduced height by 40% from 80
                  child: DropdownButtonFormField<String>(
                    value: selectedInvestor,
                    onChanged: (newValue) {
                      setState(() {
                        selectedInvestor = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Choose Investor',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: investors.map((String investor) {
                      return DropdownMenuItem<String>(
                        value: investor,
                        child: Text(investor),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                // Investor Type Dropdown
                SizedBox(
                  height: 52, // Reduced height by 40% from 80
                  child: DropdownButtonFormField<String>(
                    value: selectedInvestorType,
                    onChanged: (newValue) {
                      setState(() {
                        selectedInvestorType = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Investor Type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: investorTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          _buildPortfolioCard(),

          const SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Text(
              "Overall Portfolio vs System Given",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
          ),

          // PageView with Smooth Indicator
          SizedBox(
            height: 290,
            child: PageView(
              controller: _pageController,
              children: [
                _buildOverallPortfolioCard(),
                _systemGivenPortfolioCard(),
              ],
            ),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: const WormEffect(
                dotColor: Colors.grey,
                activeDotColor: Colors.green,
                dotHeight: 10,
                dotWidth: 10,
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
                  "My Holdings",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                ),
                const SizedBox(height: 10),
                const HoldingCard("CLI", 10, 678.0, 6780.0, -30.0,
                    wacc: 12.5, totalInvestment: 5000.0, totalReturn: 1780.0),
                const HoldingCard("GBIME", 120, 255.0, 30600.0, -120.0,
                    wacc: 8.0, totalInvestment: 30000.0, totalReturn: 600.0),
                const HoldingCard("GCIL", 11, 487.0, 5357.0, 22.0,
                    isPositive: true,
                    wacc: 10.0,
                    totalInvestment: 5000.0,
                    totalReturn: 357.0),
                const HoldingCard("H8020", 100, 10.0, 1000.0, -5.0,
                    wacc: 5.0, totalInvestment: 950.0, totalReturn: 50.0),
                const HoldingCard("HRL", 20, 865.0, 17300.0, -20.0,
                    wacc: 15.0, totalInvestment: 15000.0, totalReturn: 2300.0),

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

Widget _systemGivenPortfolioCard() {
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
              "System Given",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            const SizedBox(height: 10),
            const PortfolioRow("Total signal given", "30"),
            const PortfolioRow("Win", "Yes"),
            const PortfolioRow("Loss", "No"),
            const PortfolioRow("Catch signals", "-%"),
            const PortfolioRow("Lost signals", "-%"),
            const PortfolioRow("Accuracy", "-%"),
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
  final double wacc; // Weighted Average Cost of Capital
  final double totalInvestment;
  final double totalReturn;
  final bool isPositive;

  const HoldingCard(
    this.symbol,
    this.units,
    this.ltp,
    this.value,
    this.change, {
    super.key,
    this.isPositive = false,
    this.wacc = 0.0,
    this.totalInvestment = 0.0,
    this.totalReturn = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      symbol,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "$units units, LTP: Rs. $ltp",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Rs. ${value.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Rs. ${change.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(12.0, 3.0, 12.0, 12.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("PoV", "Rs. 1,258"),
                  _buildDetailRow(
                      "Market Value", "Rs. ${wacc.toStringAsFixed(2)}"),
                  _buildDetailRow("Daily Gain/Loss",
                      "Rs. ${totalInvestment.toStringAsFixed(2)}"),
                  _buildDetailRow(
                      "Unrealised", "Rs. ${totalReturn.toStringAsFixed(2)}"),
                  _buildDetailRow(
                      "Realised", "Rs. ${totalReturn.toStringAsFixed(2)}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
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
