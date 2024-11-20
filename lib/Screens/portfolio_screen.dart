import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart';

class PortfolioScreen extends StatefulWidget {
  static const String portfolioScreenRoute = '/portfolio';
  
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
              children: const [
                Center(child: Text('My Portfolio Screen')),
                Center(child: Text('Allocation Screen')),
                Center(child: Text('Add Shares Screen')),
                Center(child: Text('History Screen')),
                Center(child: Text('Profit & Loss Screen')),
                Center(child: Text('Import Screen')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
