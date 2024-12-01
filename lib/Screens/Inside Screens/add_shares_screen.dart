import 'package:flutter/material.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/Inside%20Screens/auctions_portfolio_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/Inside%20Screens/bonus_dividend_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/Inside%20Screens/cash_dividend_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/Inside%20Screens/fpo_portfolio_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/Inside%20Screens/from_broker_sms.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/Inside%20Screens/ipo_portfolio_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/Inside%20Screens/rights_portfolio_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/Inside%20Screens/sip_portfolio_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/buy_portfolio_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/buy_transactions_screen.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/sell_portfolio_screen.dart';

class AddSharesScreen extends StatelessWidget {
  const AddSharesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 10, // number of tabs
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Buy"),
              Tab(text: "Sell"),
              Tab(text: "Cash Dividend"),
              Tab(text: "Bonus Dividend"),
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
                Center(child: BuyPortfolioScreen()),
                // Center(child: BuyTransactionScreen()),
                // Center(child: Text("Sell Content")),
                Center(child: SellPortfolioScreen()),
                // Center(child: Text("Cash Dividend Content")),
                Center(child: CashDividendPortfolioScreen()),
                Center(child: BonusDividendPortfolioScreen()),
                Center(child: IPOPortfolioScreen()),
                Center(child: SipPortfolioScreen()),
                Center(child: FpoPortfolioScreen()),
                Center(child: AuctionsPortfolioScreen()),
                Center(child: RightsPortfolioScreen()),
                // Center(child: FromBrokerSms()),
                Center(child: FromBrokerSms()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
