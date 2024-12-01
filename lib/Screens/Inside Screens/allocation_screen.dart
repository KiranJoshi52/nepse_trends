import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart';

class AllocationScreen extends StatefulWidget {
  const AllocationScreen({super.key});

  @override
  State<AllocationScreen> createState() => _AllocationScreenState();
}

class _AllocationScreenState extends State<AllocationScreen> {
  // Dropdown values
  String selectedSector = 'Finance';
  String selectedCompany = 'Company A';

  // Dummy data for dropdowns
  final sectors = ['Finance', 'Technology', 'Healthcare'];
  final companies = {
    'Finance': ['Company A', 'Company B', 'Company C'],
    'Technology': ['Company D', 'Company E'],
    'Healthcare': ['Company F', 'Company G']
  };

  // Sample JSON data for pie charts
  static const jsonData = '''
    [
      {"label": "Category A", "value": 40, "color": "0xff0293ee"},
      {"label": "Category B", "value": 30, "color": "0xfff8b250"},
      {"label": "Category C", "value": 20, "color": "0xff845bef"},
      {"label": "Category D", "value": 10, "color": "0xff13d38e"}
    ]
  ''';

  static const jsonData2 = '''
    [
      {"label": "Investment", "value": 40, "color": "0xff336699"},
      {"label": "Market Value", "value": 30, "color": "0xff800080"}
    ]
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              // Sector Dropdown
              DropdownButtonFormField<String>(
                value: selectedSector,
                decoration: const InputDecoration(
                  labelText: 'Select Sector',
                  border: OutlineInputBorder(),
                ),
                items: sectors
                    .map((sector) => DropdownMenuItem(
                          value: sector,
                          child: Text(sector),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSector = value!;
                    selectedCompany = companies[selectedSector]!.first;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Company Dropdown
              DropdownButtonFormField<String>(
                value: selectedCompany,
                decoration: const InputDecoration(
                  labelText: 'Select Company',
                  border: OutlineInputBorder(),
                ),
                items: companies[selectedSector]!
                    .map((company) => DropdownMenuItem(
                          value: company,
                          child: Text(company),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCompany = value!;
                  });
                },
              ),
              const SizedBox(height: 3),
              // Cards
              const AllocationCard(
                title: 'Investment',
                jsonData: jsonData,
              ),
              const SizedBox(height: 4),
              const AllocationCard(
                title: 'Market Value',
                jsonData: jsonData2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllocationCard extends StatelessWidget {
  final String title;
  final String jsonData;

  const AllocationCard(
      {super.key, required this.title, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 9.0),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          DoughnutChart(jsonData: jsonData),
          const SizedBox(height: 24),
          Legend(jsonData: jsonData),
          const SizedBox(height: 24),
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
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();

    return Center(
      child: SizedBox(
        height: 220,
        child: PieChart(
          PieChartData(
            sections: sections,
            centerSpaceRadius: 50,
            borderData: FlBorderData(show: false),
            sectionsSpace: 2,
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
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: parsedData.map((data) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Color(int.parse(data['color'])),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              const SizedBox(width: 12),
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
