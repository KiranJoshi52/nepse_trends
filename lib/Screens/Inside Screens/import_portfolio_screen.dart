import 'package:flutter/material.dart';
import 'package:nepse_trends/Screens/Inside%20Screens/Inside%20Screens/import_portfolio_steps_screen.dart';

class ImportPortfolioScreen extends StatefulWidget {
  const ImportPortfolioScreen({super.key});

  @override
  _ImportPortfolioScreenState createState() => _ImportPortfolioScreenState();
}

class _ImportPortfolioScreenState extends State<ImportPortfolioScreen> {
  String? selectedPortal = 'TMS'; // Default value for dropdown

  final List<String> portals = ['TMS', 'Mero Share', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Import Portfolio from any other Existing Portfolio Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Portal',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedPortal,
              items: portals
                  .map(
                    (portal) => DropdownMenuItem<String>(
                      value: portal,
                      child: Text(portal),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPortal = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'For Mero Share, upload CSV files directly in the system. For others, only Excel files are supported.',
              style: TextStyle(color: Colors.grey[700]),
            ),
            // const Spacer(),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImportPortfolioStepsScreen(),
                    ),
                  )
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize:
                      const Size(double.infinity, 50), // Full width button
                ),
                child: const Text(
                  'Import',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
