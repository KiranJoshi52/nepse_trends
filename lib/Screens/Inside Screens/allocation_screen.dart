import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart';

class AllocationScreen extends StatelessWidget {
  const AllocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const jsonData = '''
    [
      {"label": "Category A", "value": 40, "color": "0xff0293ee"},
      {"label": "Category B", "value": 30, "color": "0xfff8b250"},
      {"label": "Category C", "value": 20, "color": "0xff845bef"},
      {"label": "Category D", "value": 10, "color": "0xff13d38e"}
    ]
    ''';

    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // First Card
              AllocationCard(jsonData: jsonData),
              SizedBox(height: 24), // Space between cards
              // Second Card
              AllocationCard(jsonData: jsonData),
            ],
          ),
        ),
      ),
    );
  }
}

class AllocationCard extends StatelessWidget {
  final String jsonData;

  const AllocationCard({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6, // Shadow intensity
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row with Gradient
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: const Center(
              child: Text(
                'Distribution Chart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20), // Increased spacing
          // Doughnut Chart
          DoughnutChart(jsonData: jsonData),
          const SizedBox(height: 24), // Increased spacing
          // Legend
          Legend(jsonData: jsonData),
          const SizedBox(height: 24), // Bottom padding
        ],
      ),
    );
  }
}

class DoughnutChart extends StatelessWidget {
  final String jsonData;

  const DoughnutChart({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    final parsedData = jsonDecode(jsonData) as List<dynamic>;
    final sections = parsedData.map((data) {
      return PieChartSectionData(
        color: Color(int.parse(data['color'])),
        value: data['value'].toDouble(),
        title: '${data['value']}%',
        radius: 60, // Increased for better visuals
        titleStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();

    return Center(
      child: SizedBox(
        height: 220, // Adjusted height
        child: PieChart(
          PieChartData(
            sections: sections,
            centerSpaceRadius: 50,
            borderData: FlBorderData(show: false),
            sectionsSpace: 2, // Space between sections
          ),
        ),
      ),
    );
  }
}

class Legend extends StatelessWidget {
  final String jsonData;

  const Legend({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    final parsedData = jsonDecode(jsonData) as List<dynamic>;

    return Center(
      child: Wrap(
        spacing: 16.0, // Horizontal space between items
        runSpacing: 16.0, // Vertical space between rows
        alignment: WrapAlignment.center, // Center items in rows
        children: parsedData.map((data) {
          return Row(
            mainAxisSize: MainAxisSize.min, // Compact size
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Color(int.parse(data['color'])),
                  borderRadius: BorderRadius.circular(7), // Circular dot
                ),
              ),
              const SizedBox(width: 12), // Adjusted space
              Text(
                data['label'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
