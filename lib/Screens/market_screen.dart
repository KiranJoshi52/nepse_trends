import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart';

class MarketScreen extends StatelessWidget {
  static const String marketScreenRoute = '/market';

  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Market',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
      ),
      // body: Center(child: Text('Market Screen')),
      body: StockDataTable(),
    );
  }
}

class StockDataTable extends StatefulWidget {
  const StockDataTable({super.key});

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
    {
      'symbol': 'TSLA',
      'ltp': 745.50,
      'pClose': 750.25,
      'change': -0.63,
      'quantity': 5000
    },
    {
      'symbol': 'NFLX',
      'ltp': 525.10,
      'pClose': 530.00,
      'change': -0.92,
      'quantity': 1500
    },
    {
      'symbol': 'NVDA',
      'ltp': 820.75,
      'pClose': 810.00,
      'change': 1.33,
      'quantity': 2800
    },
    {
      'symbol': 'PYPL',
      'ltp': 185.20,
      'pClose': 180.45,
      'change': 2.63,
      'quantity': 1100
    },
    {
      'symbol': 'ADBE',
      'ltp': 560.40,
      'pClose': 565.10,
      'change': -0.83,
      'quantity': 2400
    },
    {
      'symbol': 'TSLA',
      'ltp': 745.50,
      'pClose': 750.25,
      'change': -0.63,
      'quantity': 5000
    },
    {
      'symbol': 'NFLX',
      'ltp': 525.10,
      'pClose': 530.00,
      'change': -0.92,
      'quantity': 1500
    },
    {
      'symbol': 'NVDA',
      'ltp': 820.75,
      'pClose': 810.00,
      'change': 1.33,
      'quantity': 2800
    },
    {
      'symbol': 'PYPL',
      'ltp': 185.20,
      'pClose': 180.45,
      'change': 2.63,
      'quantity': 1100
    },
    {
      'symbol': 'ADBE',
      'ltp': 560.40,
      'pClose': 565.10,
      'change': -0.83,
      'quantity': 2400
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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double fontSize = constraints.maxWidth < 500 ? 12 : 14;
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columnSpacing: 9,
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _isAscending,
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: 50,
                    child: Text('Symbol', style: TextStyle(fontSize: fontSize)),
                  ),
                  onSort: (columnIndex, _) {
                    _sortData(columnIndex, !_isAscending);
                  },
                ),
                DataColumn(
                  label: SizedBox(
                    width: 50,
                    child: Text('LTP', style: TextStyle(fontSize: fontSize)),
                  ),
                  onSort: (columnIndex, _) {
                    _sortData(columnIndex, !_isAscending);
                  },
                ),
                DataColumn(
                  label: SizedBox(
                    width: 50,
                    child:
                        Text('P Close', style: TextStyle(fontSize: fontSize)),
                  ),
                  onSort: (columnIndex, _) {
                    _sortData(columnIndex, !_isAscending);
                  },
                ),
                DataColumn(
                  label: SizedBox(
                    width: 50,
                    child:
                        Text('% Change', style: TextStyle(fontSize: fontSize)),
                  ),
                  onSort: (columnIndex, _) {
                    _sortData(columnIndex, !_isAscending);
                  },
                ),
                DataColumn(
                  label: SizedBox(
                    width: 50,
                    child:
                        Text('Quantity', style: TextStyle(fontSize: fontSize)),
                  ),
                  onSort: (columnIndex, _) {
                    _sortData(columnIndex, !_isAscending);
                  },
                ),
              ],
              rows: stockData.map((data) {
                // Check if change is negative or positive
                bool isNegativeChange = data['change'] < 0;
                return DataRow(
                  color: isNegativeChange
                      ? WidgetStateProperty.all(Colors.red.shade200)
                      : WidgetStateProperty.all(
                          Colors.green.shade200), // Green for positive changes
                  cells: [
                    DataCell(Text(data['symbol'],
                        style: TextStyle(fontSize: fontSize))),
                    DataCell(Text(data['ltp'].toStringAsFixed(2),
                        style: TextStyle(fontSize: fontSize))),
                    DataCell(Text(data['pClose'].toStringAsFixed(2),
                        style: TextStyle(fontSize: fontSize))),
                    DataCell(Text('${data['change']}%',
                        style: TextStyle(fontSize: fontSize))),
                    DataCell(Text(data['quantity'].toString(),
                        style: TextStyle(fontSize: fontSize))),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
