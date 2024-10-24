import 'package:flutter/material.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/buy_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/sell_screen.dart';

class ShareCalculatorScreen extends StatelessWidget {
  const ShareCalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Calculator'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check if the screen is wide (like in landscape or tablet mode)
          if (constraints.maxWidth > 600) {
            // Show both Buy and Sell screens side by side
            return const Row(
              children: [
                Expanded(child: BuyScreen()), // Buy Screen on the left
                Expanded(child: SellScreen()), // Sell Screen on the right
              ],
            );
          } else {
            // For smaller screens, use tabs
            return const DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Buy'),
                      Tab(text: 'Sell'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        BuyScreen(), // Buy Screen for smaller screens
                        SellScreen(), // Sell Screen for smaller screens
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
