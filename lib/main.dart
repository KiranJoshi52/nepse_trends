import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nepse_trends/Screens/ai_charts_screen.dart';
import 'package:nepse_trends/Screens/check_screen.dart';
import 'package:nepse_trends/Screens/dashboard_screen.dart';
import 'package:nepse_trends/Screens/data_analytics_screen.dart';
import 'package:nepse_trends/Screens/floorsheet_screen.dart';
import 'package:nepse_trends/Screens/ipo_result_screen.dart';
import 'package:nepse_trends/Screens/market_screen.dart';
import 'package:nepse_trends/Screens/mega_offers_screen.dart';
import 'package:nepse_trends/Screens/new_shares_screen.dart';
import 'package:nepse_trends/Screens/news_letter_screen.dart';
import 'package:nepse_trends/Screens/news_screen.dart';
import 'package:nepse_trends/Screens/portfolio_screen.dart';
import 'package:nepse_trends/Screens/share_calculator_screen.dart';
import 'package:nepse_trends/Screens/share_training_screen.dart';
import 'package:nepse_trends/Screens/today_price_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const CheckScreen(),
        '/dashboard_screen': (context) => DashboardScreen(),
        '/news': (context) => NewsScreen(),
        '/market': (context) => MarketScreen(),
        '/floorsheet': (context) => FloorsheetScreen(),
        '/todays_price': (context) => TodaysPriceScreen(),
        '/portfolio': (context) => PortfolioScreen(),
        '/share_calculator': (context) => const ShareCalculatorScreen(),
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

