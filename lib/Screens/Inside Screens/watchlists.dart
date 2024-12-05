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
    _loadDefaultWatchlists();
  }

  // Simulating an API call to get companies
  Future<void> _fetchCompanies() async {
    // Simulate network delay
    setState(() {
      availableCompanies = List.generate(5, (index) {
        return {
          'id': index + 1,
          'symbol': 'SYM${index + 1}',
        };
      });
    });
  }

  // Load some default watchlists
  void _loadDefaultWatchlists() {
    setState(() {
      watchlist = List.generate(3, (index) {
        return {
          'id': index + 1,
          'symbol': 'SYM${index + 1}',
          'tradeType': 'Buy',
          'buyRange': '100-150',
          'tp1': '200',
          'buyingPattern': 'Breakout',
          'period': 'Short-term',
          'stopLoss': '90',
          'riskReward': '1:2',
          'multiBagger': true,
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
          title: const Text('Add to Watchlist',
              style: TextStyle(fontWeight: FontWeight.bold)),
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
            ElevatedButton(
              onPressed: _addToWatchlist,
              child: const Text('Add'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor, // Custom text color
              ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 9.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'System given watchlist',
                    style: TextStyle(
                      fontSize: 16, // Smaller font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black color
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
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
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Nabil',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              // color: Colors.blue[700],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 16,
                                          // ),
                                          // Text(
                                          //   'Buy range: 100 - 150 ',
                                          //   style: TextStyle(
                                          //     fontSize: 12,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Buy, ',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'TP1: 200',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        _deleteCompany(company['id']),
                                  ),
                                ],
                              ),
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      12.0, 0.0, 12.0, 9.0),
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildInfoRow('ID', '${company['id']}'),
                                      _buildInfoRow(
                                          'Trade Type', company['tradeType']),
                                      _buildInfoRow(
                                          'Buy Range', company['buyRange']),
                                      _buildInfoRow('TP1', company['tp1']),
                                      _buildInfoRow('Buying Pattern',
                                          company['buyingPattern']),
                                      _buildInfoRow(
                                          'Period', company['period']),
                                      _buildInfoRow(
                                          'Stop Loss', company['stopLoss']),
                                      _buildInfoRow(
                                          'Risk Reward', company['riskReward']),
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
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Own Watchlist',
                    style: TextStyle(
                      fontSize: 16, // Smaller font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black color
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _showAddCompanyPopup,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Add Company',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
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
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Nabil',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              // color: Colors.blue[700],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 16,
                                          // ),
                                          // Text(
                                          //   'Buy range: 100 - 150 ',
                                          //   style: TextStyle(
                                          //     fontSize: 12,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Buy, ',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'TP1: 200',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        _deleteCompany(company['id']),
                                  ),
                                ],
                              ),
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      12.0, 0.0, 12.0, 9.0),
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildInfoRow('ID', '${company['id']}'),
                                      _buildInfoRow(
                                          'Trade Type', company['tradeType']),
                                      _buildInfoRow(
                                          'Buy Range', company['buyRange']),
                                      _buildInfoRow('TP1', company['tp1']),
                                      _buildInfoRow('Buying Pattern',
                                          company['buyingPattern']),
                                      _buildInfoRow(
                                          'Period', company['period']),
                                      _buildInfoRow(
                                          'Stop Loss', company['stopLoss']),
                                      _buildInfoRow(
                                          'Risk Reward', company['riskReward']),
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
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the info row
  Widget _buildInfoRow(String label, String value,
      {Color? color, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: color ?? Colors.black,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
