import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool showTransactions = true;
  String? selectedShareholder;
  TextEditingController messageController = TextEditingController();
  List<Map<String, String>> transactions = [
    {
      'no': '1',
      'symbol': 'IBM',
      'action': 'BUY',
      'date': '2023-07-01',
      'quantity': '100',
      'rate': '100',
      'total': 'Rs.10,000',
    },
    {
      'no': '2',
      'symbol': 'JBBL',
      'action': 'SELL',
      'date': '2023-09-01',
      'quantity': '60',
      'rate': '100',
      'total': 'Rs.6,000',
    },
  ];

  TextEditingController symbolController = TextEditingController();
  TextEditingController actionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  Map<String, String>? currentEditingTransaction;

  @override
  void initState() {
    super.initState();
    messageController.text =
        'Sample Message: BNo.XX Purchased on 2023-07-05 (MKHC 50 kitta @ 227) - BAmt.11,422.10';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shareholder Dropdown
              const Text(
                'Shareholder:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8.0),
              DropdownButtonFormField<String>(
                hint: const Text('Select a shareholder'),
                value: selectedShareholder,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: ['Shareholder 1', 'Shareholder 2']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedShareholder = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Message Field
              const Text(
                'Message:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: messageController,
                maxLines: 3,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'Enter your message here...',
                ),
              ),
              const SizedBox(height: 16.0),

              // Toggle Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      showTransactions = !showTransactions;
                    });
                  },
                  icon: Icon(
                    showTransactions ? Icons.visibility : Icons.visibility_off,
                  ),
                  label: Text(
                    showTransactions
                        ? 'Hide Transaction'
                        : 'Preview Transaction',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 9.0, horizontal: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Transaction List
              if (showTransactions)
                Column(
                  children: transactions.map((transaction) {
                    return _buildTransactionCard(
                      transaction['no']!,
                      transaction['symbol']!,
                      transaction['action']!,
                      transaction['date']!,
                      transaction['quantity']!,
                      transaction['rate']!,
                      transaction['total']!,
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: showTransactions
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Save data action
                  print('Saving data...');
                  print('Message: ${messageController.text}');
                  print('Selected Shareholder: $selectedShareholder');
                  // Implement save functionality here
                },
                label: const Text(
                  'Save Data',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildTransactionCard(
    String no,
    String symbol,
    String action,
    String date,
    String quantity,
    String rate,
    String total,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 3.0),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  symbol,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: action == 'BUY' ? Colors.green[50] : Colors.red[50],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    action,
                    style: TextStyle(
                      color: action == 'BUY' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 16),
                const SizedBox(width: 8.0),
                Text(
                  'Date: $date',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.format_list_numbered, size: 16),
                const SizedBox(width: 8.0),
                Text(
                  'Quantity: $quantity',
                  style: const TextStyle(color: Colors.black54),
                ),
                const Spacer(),
                const Icon(Icons.attach_money, size: 16),
                const SizedBox(width: 8.0),
                Text(
                  'Rate: $rate',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            const Divider(thickness: 1.0, height: 24.0),
            Text(
              'Total: $total',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 9.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    _editTransaction(no);
                  },
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  label: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(width: 8.0),
                TextButton.icon(
                  onPressed: () {
                    _deleteTransaction(no);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editTransaction(String no) {
    setState(() {
      currentEditingTransaction =
          transactions.firstWhere((transaction) => transaction['no'] == no);
      symbolController.text = currentEditingTransaction!['symbol']!;
      actionController.text = currentEditingTransaction!['action']!;
      dateController.text = currentEditingTransaction!['date']!;
      quantityController.text = currentEditingTransaction!['quantity']!;
      rateController.text = currentEditingTransaction!['rate']!;
      totalController.text = currentEditingTransaction!['total']!;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Transaction'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: symbolController,
                decoration: const InputDecoration(labelText: 'Symbol'),
              ),
              TextFormField(
                controller: actionController,
                decoration: const InputDecoration(labelText: 'Action'),
              ),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
              ),
              TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: rateController,
                decoration: const InputDecoration(labelText: 'Rate'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: totalController,
                decoration: const InputDecoration(labelText: 'Total'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _saveEditedTransaction();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _saveEditedTransaction() {
    setState(() {
      currentEditingTransaction!['symbol'] = symbolController.text;
      currentEditingTransaction!['action'] = actionController.text;
      currentEditingTransaction!['date'] = dateController.text;
      currentEditingTransaction!['quantity'] = quantityController.text;
      currentEditingTransaction!['rate'] = rateController.text;
      currentEditingTransaction!['total'] = totalController.text;
    });

    currentEditingTransaction = null; // Clear editing state
  }

  void _deleteTransaction(String no) {
    setState(() {
      transactions.removeWhere((transaction) => transaction['no'] == no);
    });
  }
}
