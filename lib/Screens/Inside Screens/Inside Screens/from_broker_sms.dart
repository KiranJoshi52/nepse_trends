import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool showTransactions = true;

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
                  // Handle value selection
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
                maxLines: 3,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'Enter your message here...',
                ),
                initialValue:
                    'Sample Message: BNo.XX Purchased on 2023-07-05 (MKHC 50 kitta @ 227) - BAmt.11,422.10',
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
                  children: [
                    _buildTransactionCard(
                      '1',
                      'IBM',
                      'BUY',
                      '2023-07-01',
                      '100',
                      '100',
                      '\$10,000',
                    ),
                    _buildTransactionCard(
                      '2',
                      'JBBL',
                      'SELL',
                      '2023-09-01',
                      '60',
                      '100',
                      '\$6,000',
                    ),
                  ],
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
                },
                // icon: const Icon(Icons.save),
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
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // Edit action
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
                    // Delete action
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
}
