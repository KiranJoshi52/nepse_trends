import 'package:flutter/material.dart';

class Watchlists extends StatefulWidget {
  const Watchlists({super.key});

  @override
  State<Watchlists> createState() => _WatchlistsState();
}

class _WatchlistsState extends State<Watchlists> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2, // number of tabs
      child: Column(
        children: [
          TabBar(
            // isScrollable: true,
            tabs: [
              Tab(text: "System given"),
              Tab(text: "Own watchlist"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(child: SystemGivenWatchlist()),
                Center(child: OwnWatchlist()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SystemGivenWatchlist extends StatefulWidget {
  const SystemGivenWatchlist({super.key});

  @override
  _SystemGivenWatchlistState createState() => _SystemGivenWatchlistState();
}

class _SystemGivenWatchlistState extends State<SystemGivenWatchlist> {
  List<Map<String, dynamic>> watchlist = [
    {
      "id": 1,
      "symbol": "AAPL",
      "buyRange": "150-155",
      "tp1": "170",
      "buyingPattern": "Aggressive",
      "period": "Short-term",
      "stopLoss": "145",
      "riskReward": "1:3",
      "multiBaggar": false,
      "actions": ["edit", "delete"]
    },
    {
      "id": 2,
      "symbol": "TSLA",
      "buyRange": "700-720",
      "tp1": "800",
      "buyingPattern": "Moderate",
      "period": "Mid-term",
      "stopLoss": "680",
      "riskReward": "1:2",
      "multiBaggar": true,
      "actions": ["edit", "delete"]
    },
    {
      "id": 3,
      "symbol": "AMZN",
      "buyRange": "3200-3300",
      "tp1": "3500",
      "buyingPattern": "Conservative",
      "period": "Long-term",
      "stopLoss": "3100",
      "riskReward": "1:1.5",
      "multiBaggar": false,
      "actions": ["edit", "delete"]
    },
    {
      "id": 4,
      "symbol": "AMZN",
      "buyRange": "3200-3300",
      "tp1": "3500",
      "buyingPattern": "Conservative",
      "period": "Long-term",
      "stopLoss": "3100",
      "riskReward": "1:1.5",
      "multiBaggar": false,
      "actions": ["edit", "delete"]
    },
    {
      "id": 5,
      "symbol": "AMZN",
      "buyRange": "3200-3300",
      "tp1": "3500",
      "buyingPattern": "Conservative",
      "period": "Long-term",
      "stopLoss": "3100",
      "riskReward": "1:1.5",
      "multiBaggar": false,
      "actions": ["edit", "delete"]
    },
  ];

  void _deleteItem(int id) {
    setState(() {
      watchlist.removeWhere((item) => item['id'] == id);
    });
  }

  void _editItem(int id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit feature for item $id is not implemented')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: watchlist.length,
        itemBuilder: (context, index) {
          final item = watchlist[index]; // Adjust index for the list items
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ExpansionTile(
              title: Text(
                '${item["symbol"]} (${item["period"]})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Buy Range: ${item["buyRange"]}'),
                      Text('TP1: ${item["tp1"]}'),
                      Text('Buying Pattern: ${item["buyingPattern"]}'),
                      Text('Stop Loss: ${item["stopLoss"]}'),
                      Text('Risk/Reward: ${item["riskReward"]}'),
                      Text(
                          'Multi Bagger: ${item["multiBaggar"] ? "Yes" : "No"}'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () => _editItem(item["id"]),
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            label: const Text('Edit'),
                          ),
                          TextButton.icon(
                            onPressed: () => _deleteItem(item["id"]),
                            icon: const Icon(Icons.delete, color: Colors.red),
                            label: const Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OwnWatchlist extends StatefulWidget {
  const OwnWatchlist({super.key});

  @override
  _OwnWatchlistState createState() => _OwnWatchlistState();
}

class _OwnWatchlistState extends State<OwnWatchlist> {
  List<Map<String, dynamic>> watchlist = [
    {
      "id": 1,
      "symbol": "GBIME",
      "buyRange": "150-155",
      "tp1": "170",
      "buyingPattern": "Aggressive",
      "period": "Short-term",
      "stopLoss": "145",
      "riskReward": "1:3",
      "multiBaggar": false,
      "actions": ["edit", "delete"]
    },
    {
      "id": 2,
      "symbol": "PHCL",
      "buyRange": "700-720",
      "tp1": "800",
      "buyingPattern": "Moderate",
      "period": "Mid-term",
      "stopLoss": "680",
      "riskReward": "1:2",
      "multiBaggar": true,
      "actions": ["edit", "delete"]
    },
    {
      "id": 3,
      "symbol": "AMZN",
      "buyRange": "3200-3300",
      "tp1": "3500",
      "buyingPattern": "Conservative",
      "period": "Long-term",
      "stopLoss": "3100",
      "riskReward": "1:1.5",
      "multiBaggar": false,
      "actions": ["edit", "delete"]
    },
    {
      "id": 4,
      "symbol": "AMZN",
      "buyRange": "3200-3300",
      "tp1": "3500",
      "buyingPattern": "Conservative",
      "period": "Long-term",
      "stopLoss": "3100",
      "riskReward": "1:1.5",
      "multiBaggar": false,
      "actions": ["edit", "delete"]
    },
    {
      "id": 5,
      "symbol": "AMZN",
      "buyRange": "3200-3300",
      "tp1": "3500",
      "buyingPattern": "Conservative",
      "period": "Long-term",
      "stopLoss": "3100",
      "riskReward": "1:1.5",
      "multiBaggar": false,
      "actions": ["edit", "delete"]
    },
  ];

  void _deleteItem(int id) {
    setState(() {
      watchlist.removeWhere((item) => item['id'] == id);
    });
  }

  void _editItem(int id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit feature for item $id is not implemented')),
    );
  }

  void _addItem(String symbol) {
    setState(() {
      watchlist.add({
        "id": DateTime.now()
            .millisecondsSinceEpoch, // Unique ID based on timestamp
        "symbol": symbol,
        "buyRange": "100-120",
        "tp1": "130",
        "buyingPattern": "Moderate",
        "period": "Mid-term",
        "stopLoss": "95",
        "riskReward": "1:2",
        "multiBaggar": false,
        "actions": ["edit", "delete"]
      });
    });
  }

  void _showAddDialog() {
    final TextEditingController symbolController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add company'),
          content: TextField(
            controller: symbolController,
            decoration: const InputDecoration(hintText: 'Enter Symbol'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (symbolController.text.isNotEmpty) {
                  _addItem(symbolController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: watchlist.length + 1, // Add 1 for SizedBox
        itemBuilder: (context, index) {
          if (index == watchlist.length) {
            return const SizedBox(height: 90); // Add the SizedBox at the end
          }

          final item = watchlist[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ExpansionTile(
              title: Text(
                '${item["symbol"]} (${item["period"]})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Buy Range: ${item["buyRange"]}'),
                      Text('TP1: ${item["tp1"]}'),
                      Text('Buying Pattern: ${item["buyingPattern"]}'),
                      Text('Stop Loss: ${item["stopLoss"]}'),
                      Text('Risk/Reward: ${item["riskReward"]}'),
                      Text(
                          'Multi Bagger: ${item["multiBaggar"] ? "Yes" : "No"}'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () => _editItem(item["id"]),
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            label: const Text('Edit'),
                          ),
                          TextButton.icon(
                            onPressed: () => _deleteItem(item["id"]),
                            icon: const Icon(Icons.delete, color: Colors.red),
                            label: const Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

