import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MarketScreen extends StatelessWidget {
  static const String marketScreenRoute = '/market';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Market')),
      body: Column(
        children: [
          Expanded(
            flex: 4, // Adjust the space for the chart (2 parts of 3)
            child: NepseChartPage(),
          ),
          Divider(thickness: 1),
          Expanded(
            flex: 1, // Adjust the space for the stock data table (3 parts of 3)
            child: StockDataTable(),
          ),
        ],
      ),
    );
  }
}

class NepseChartPage extends StatefulWidget {
  const NepseChartPage({Key? key}) : super(key: key);

  @override
  _NepseChartPageState createState() => _NepseChartPageState();
}

class _NepseChartPageState extends State<NepseChartPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://nepsealpha.com/trading/chart"));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}

class StockDataTable extends StatefulWidget {
  @override
  _StockDataTableState createState() => _StockDataTableState();
}

class _StockDataTableState extends State<StockDataTable> {
  final List<Map<String, dynamic>> stockData = [
    {
      'symbol': 'AAPL',
      'ltp': 149.80,
      'pClose': 150.55,
      'change': -0.5,
      'quantity': 3000
    },
    {
      'symbol': 'MSFT',
      'ltp': 330.55,
      'pClose': 329.00,
      'change': 0.47,
      'quantity': 2500
    },
    {
      'symbol': 'META',
      'ltp': 320.12,
      'pClose': 318.00,
      'change': 0.67,
      'quantity': 4200
    },
    {
      'symbol': 'AMZN',
      'ltp': 3500.35,
      'pClose': 3450.60,
      'change': 1.44,
      'quantity': 1800
    },
    {
      'symbol': 'GOOGL',
      'ltp': 2805.25,
      'pClose': 2820.15,
      'change': -0.53,
      'quantity': 3200
    },
  ];

  bool _isAscending = true;
  int _sortColumnIndex = 0;

  void _sortData(int columnIndex, bool ascending) {
    stockData.sort((a, b) {
      if (columnIndex == 0) {
        return ascending
            ? a['symbol'].compareTo(b['symbol'])
            : b['symbol'].compareTo(a['symbol']);
      } else if (columnIndex == 1) {
        return ascending
            ? a['ltp'].compareTo(b['ltp'])
            : b['ltp'].compareTo(a['ltp']);
      } else if (columnIndex == 2) {
        return ascending
            ? a['pClose'].compareTo(b['pClose'])
            : b['pClose'].compareTo(a['pClose']);
      } else if (columnIndex == 3) {
        return ascending
            ? a['change'].compareTo(b['change'])
            : b['change'].compareTo(a['change']);
      } else {
        return ascending
            ? a['quantity'].compareTo(b['quantity'])
            : b['quantity'].compareTo(a['quantity']);
      }
    });
    setState(() {
      _isAscending = ascending;
      _sortColumnIndex = columnIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Wrap the DataTable with SingleChildScrollView for horizontal scrolling
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 12,
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _isAscending,
              columns: [
                DataColumn(
                  label: Text('Symbol'),
                  onSort: (columnIndex, _) {
                    _sortData(columnIndex, !_isAscending);
                  },
                ),
                DataColumn(
                  label: Text('LTP'),
                  onSort: (columnIndex, _) {
                    _sortData(columnIndex, !_isAscending);
                  },
                ),
                DataColumn(
                  label: Text('P Close'),
                  onSort: (columnIndex, _) {
                    _sortData(columnIndex, !_isAscending);
                  },
                ),
                DataColumn(
                  label: Text('% Change'),
                  onSort: (columnIndex, _) {
                    _sortData(columnIndex, !_isAscending);
                  },
                ),
                DataColumn(
                  label: Text('Quantity'),
                  onSort: (columnIndex, _) {
                    _sortData(columnIndex, !_isAscending);
                  },
                ),
              ],
              rows: stockData.map((data) {
                bool isNegativeChange = data['change'] < 0;
                return DataRow(
                  cells: [
                    DataCell(Text(data['symbol'])),
                    DataCell(Text(data['ltp'].toStringAsFixed(2))),
                    DataCell(Text(data['pClose'].toStringAsFixed(2))),
                    DataCell(Text('${data['change']}%')),
                    DataCell(Text(data['quantity'].toString())),
                  ],
                  color: MaterialStateProperty.resolveWith(
                    (states) => isNegativeChange
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
