import 'package:flutter/material.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/buy_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/sell_screen.dart';

class ShareCalculatorScreen extends StatelessWidget {
  const ShareCalculatorScreen({super.key});

  static const String shareCalculatorScreenRoute = '/share_calculator';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Share Calculator',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
      ),
      backgroundColor: Colors.green, 
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
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    // isScrollable: true,
                    tabs: [
                      Tab(text: 'Buy'),
                      Tab(text: 'Sell'),
                      Tab(text: 'Right Share Adjustment'),
                      Tab(text: 'Bonus Share Adjustment'),
                    ],
                    labelColor: Colors.orange,
                    unselectedLabelColor: Colors.white,
                    indicatorColor: Colors.orange,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        BuyScreen(), // Sell Screen for smaller screens
                        SellScreen(), // Sell Screen for smaller screens
                        SellScreen(), // Sell Screen for smaller screens
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
