import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nepse_trends/Screens/ai_charts_screen.dart';
import 'package:nepse_trends/Screens/login_screen.dart';
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
import 'package:nepse_trends/provider/google_sign_in_provider.dart';
import 'package:nepse_trends/provider/sell_provider.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Set up Firebase Messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permissions for iOS
  await messaging.requestPermission();

  // Get the FCM token
  String? token = await messaging.getToken();
  print("Firebase Messaging Token: $token");

  //check

  // Handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Message received: ${message.notification?.title}");
    // Handle foreground notification (show alert, etc.)
  });

  // Handle when the app is opened from a notification
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Message clicked: ${message.notification?.title}");
    // Handle navigation if needed
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SellProvider()),
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.loginScreenRoute,
      routes: {
        LoginScreen.loginScreenRoute: (context) => const LoginScreen(),
        DashboardScreen.dashboardScreenRoute: (context) => const DashboardScreen(),
        NewsScreen.newsScreenRoute: (context) => NewsScreen(),
        MarketScreen.marketScreenRoute: (context) => MarketScreen(),
        FloorsheetScreen.floorsheetScreenRoute: (context) => FloorsheetScreen(),
        TodaysPriceScreen.todaysPriceScreenRoute: (context) => TodaysPriceScreen(),
        PortfolioScreen.portfolioScreenRoute: (context) => PortfolioScreen(),
        ShareCalculatorScreen.shareCalculatorScreenRoute: (context) => const ShareCalculatorScreen(),
        NewsletterScreen.newsletterScreenRoute: (context) => NewsletterScreen(),
        DataAnalyticsScreen.dataAnalyticsScreenRoute: (context) => DataAnalyticsScreen(),
        NewSharesScreen.newSharesScreenRoute: (context) => NewSharesScreen(),
        IpoResultScreen.ipoResultScreenRoute: (context) => IpoResultScreen(),
        ShareTrainingScreen.shareTrainingScreenRoute: (context) => ShareTrainingScreen(),
        MegaOffersScreen.megaOffersScreenRoute: (context) => MegaOffersScreen(),
        AiChartsScreen.aiChartsScreenRoute: (context) => AiChartsScreen(),
      },
    );
  }
}
