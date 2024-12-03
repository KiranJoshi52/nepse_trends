import 'package:flutter/material.dart';

class VersusComparisonApp extends StatelessWidget {
  const VersusComparisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const VersusComparisonPage();
  }
}

class VersusComparisonPage extends StatelessWidget {
  const VersusComparisonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Product A',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16),
                Text(
                  'VS',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16),
                Text(
                  'Product B',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Comparison cards
            Expanded(
              child: Row(
                children: [
                  // Left side
                  Expanded(
                    child: ComparisonCard(
                      title: 'Product A',
                      features: {
                        'Price': '\$50',
                        'Speed': '150 Mbps',
                        'Warranty': '1 Year',
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  // Right side
                  Expanded(
                    child: ComparisonCard(
                      title: 'Product B',
                      features: {
                        'Price': '\$60',
                        'Speed': '180 Mbps',
                        'Warranty': '2 Years',
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComparisonCard extends StatelessWidget {
  final String title;
  final Map<String, String> features;

  const ComparisonCard({Key? key, required this.title, required this.features})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            // Features list
            ...features.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      entry.value,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
