import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart';

class Watchlists extends StatefulWidget {
  const Watchlists({super.key});

  @override
  _WatchlistsState createState() => _WatchlistsState();
}

class _WatchlistsState extends State<Watchlists> {
  List<Map<String, dynamic>> watchlist = [];
  List<Map<String, dynamic>> availableCompanies = [];
  String? selectedCompany;

  @override
  void initState() {
    super.initState();
    _fetchCompanies();
  }

  // Simulating an API call to get companies
  Future<void> _fetchCompanies() async {
    // Simulate network delay

    // Simulating available companies for the dropdown
    setState(() {
      availableCompanies = List.generate(5, (index) {
        return {
          'id': index + 1,
          'symbol': 'SYM${index + 1}',
        };
      });
    });
  }

  // Add selected company to watchlist
  void _addToWatchlist() {
    if (selectedCompany != null) {
      final company = availableCompanies.firstWhere(
        (company) => company['symbol'] == selectedCompany,
      );
      setState(() {
        watchlist.add({
          'id': company['id'],
          'symbol': company['symbol'],
          'tradeType': 'Buy',
          'buyRange': '100-150',
          'tp1': '200',
          'buyingPattern': 'Breakout',
          'period': 'Short-term',
          'stopLoss': '90',
          'riskReward': '1:2',
          'multiBagger': true,
        });
      });
    }
    Navigator.of(context).pop(); // Close the dialog
  }

  // Show the add company popup
  void _showAddCompanyPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Watchlist'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                hint: const Text('Select a company'),
                value: selectedCompany,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCompany = newValue;
                  });
                },
                items: availableCompanies.map((company) {
                  return DropdownMenuItem<String>(
                    value: company['symbol'],
                    child: Text(company['symbol']),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: _addToWatchlist,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Delete company from the watchlist
  void _deleteCompany(int id) {
    setState(() {
      watchlist.removeWhere((company) => company['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: watchlist.isEmpty
            ? Center(
                child: Text(
                  'No companies in the watchlist. Please add some!',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              )
            : ListView.builder(
                itemCount: watchlist.length,
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 80, // Adds padding to avoid overlap with FAB
                ),
                itemBuilder: (context, index) {
                  final company = watchlist[index];
                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    company['symbol'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteCompany(company['id']),
                              ),
                            ],
                          ),
                          const Divider(),
                          _buildInfoRow('ID', '${company['id']}'),
                          _buildInfoRow('Trade Type', company['tradeType']),
                          _buildInfoRow('Buy Range', company['buyRange']),
                          _buildInfoRow('TP1', company['tp1']),
                          _buildInfoRow(
                              'Buying Pattern', company['buyingPattern']),
                          _buildInfoRow('Period', company['period']),
                          _buildInfoRow('Stop Loss', company['stopLoss']),
                          _buildInfoRow('Risk Reward', company['riskReward']),
                          _buildInfoRow(
                            'Multi Bagger',
                            company['multiBagger'] ? 'Yes' : 'No',
                            color: company['multiBagger']
                                ? Colors.green
                                : Colors.red,
                            bold: true,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCompanyPopup,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Add Company',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  // Widget to build the info row
  Widget _buildInfoRow(String label, String value,
      {Color? color, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: color ?? Colors.black,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
