import 'package:flutter/material.dart';

class Watchlists extends StatelessWidget {
  const Watchlists({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WatchListScreen(),
    );
  }
}

class WatchListScreen extends StatefulWidget {
  @override
  _WatchListScreenState createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  List<String> watchList = ['AAPL', 'GOOGL', 'AMZN', 'TSLA', 'MSFT'];

  final TextEditingController _addController = TextEditingController();

  void _addItem(String symbol) {
    if (symbol.isNotEmpty && !watchList.contains(symbol.toUpperCase())) {
      setState(() {
        watchList.add(symbol.toUpperCase());
      });
      _addController.clear();
    }
  }

  void _removeItem(String symbol) {
    setState(() {
      watchList.remove(symbol);
    });
  }

  void _showDetails(String symbol) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Details for $symbol'),
          content: Text('This is where you would show details for $symbol.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch List'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addController,
                    decoration: InputDecoration(
                      labelText: 'Add Symbol',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _addItem(_addController.text),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: watchList.length,
              itemBuilder: (context, index) {
                final symbol = watchList[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(symbol),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () => _showDetails(symbol),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeItem(symbol),
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
    );
  }
}
