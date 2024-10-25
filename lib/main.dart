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
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization failed: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define routes as constants for better maintainability
  static const String checkScreenRoute = '/';
  static const String dashboardScreenRoute = '/dashboard_screen';
  static const String newsScreenRoute = '/news';
  static const String marketScreenRoute = '/market';
  static const String floorsheetScreenRoute = '/floorsheet';
  static const String todaysPriceScreenRoute = '/todays_price';
  static const String portfolioScreenRoute = '/portfolio';
  static const String shareCalculatorScreenRoute = '/share_calculator';
  static const String newsletterScreenRoute = '/newsletter';
  static const String dataAnalyticsScreenRoute = '/data_analytics';
  static const String newSharesScreenRoute = '/new_shares';
  static const String ipoResultScreenRoute = '/ipo_result';
  static const String shareTrainingScreenRoute = '/share_training';
  static const String megaOffersScreenRoute = '/mega_offers';
  static const String aiChartsScreenRoute = '/ai_charts';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: checkScreenRoute,
      routes: {
        checkScreenRoute: (context) => const CheckScreen(),
        dashboardScreenRoute: (context) => DashboardScreen(),
        newsScreenRoute: (context) => NewsScreen(),
        marketScreenRoute: (context) => MarketScreen(),
        floorsheetScreenRoute: (context) => FloorsheetScreen(),
        todaysPriceScreenRoute: (context) => TodaysPriceScreen(),
        portfolioScreenRoute: (context) => PortfolioScreen(),
        shareCalculatorScreenRoute: (context) => const ShareCalculatorScreen(),
        newsletterScreenRoute: (context) => NewsletterScreen(),
        dataAnalyticsScreenRoute: (context) => DataAnalyticsScreen(),
        newSharesScreenRoute: (context) => NewSharesScreen(),
        ipoResultScreenRoute: (context) => IpoResultScreen(),
        shareTrainingScreenRoute: (context) => ShareTrainingScreen(),
        megaOffersScreenRoute: (context) => MegaOffersScreen(),
        aiChartsScreenRoute: (context) => AiChartsScreen(),
      },
    );
  }
}
