import 'package:flutter/material.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/buy_portfolio_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/buy_transactions_screen.dart';

class AddSharesScreen extends StatelessWidget {
  const AddSharesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 9, // number of tabs
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Buy"),
              Tab(text: "Sell"),
              Tab(text: "Cash Dividend"),
              Tab(text: "IPO"),
              Tab(text: "SIP"),
              Tab(text: "FPO"),
              Tab(text: "Auctions"),
              Tab(text: "Rights"),
              Tab(text: "From broker SMS"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Add your content for each tab here
                // Center(child: BuyPortfolioScreen()),
                Center(child: BuyTransactionScreen()),
                Center(child: Text("Sell Content")),
                Center(child: Text("Cash Dividend Content")),
                Center(child: Text("IPO Content")),
                Center(child: Text("SIP Content")),
                Center(child: Text("FPO Content")),
                Center(child: Text("Auctions Content")),
                Center(child: Text("Rights Content")),
                Center(child: Text("From broker SMS Content")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
