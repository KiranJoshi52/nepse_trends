import 'package:flutter/material.dart';

class BuyTransactionScreen extends StatefulWidget {
  const BuyTransactionScreen({super.key});

  @override
  _BuyTransactionScreenState createState() => _BuyTransactionScreenState();
}

class _BuyTransactionScreenState extends State<BuyTransactionScreen> {
  final TextEditingController shareholderController = TextEditingController();
  final TextEditingController purchaseDateADController =
      TextEditingController();
  final TextEditingController purchaseDateBSController =
      TextEditingController();
  List<TransactionRow> rows = [TransactionRow()];

  void addRow() {
    setState(() {
      rows.add(TransactionRow());
    });
  }

  void removeRow(int index) {
    setState(() {
      rows.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Buy Transaction"),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shareholder Name
            TextField(
              controller: shareholderController,
              decoration: const InputDecoration(
                labelText: "Shareholder Name",
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              ),
            ),
            const SizedBox(height: 16.0),

            // Purchase Date (AD) and Purchase Date (BS)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: purchaseDateADController,
                    decoration: const InputDecoration(
                      labelText: "Purchase Date (AD)",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                    ),
                    readOnly: true,
                    onTap: () {
                      // Add date picker logic
                    },
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: TextField(
                    controller: purchaseDateBSController,
                    decoration: const InputDecoration(
                      labelText: "Purchase Date (BS)",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                    ),
                    readOnly: true,
                    onTap: () {
                      // Add date picker logic
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Dynamic Rows
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rows.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(child: rows[index]),
                    if (rows.length > 1)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeRow(index),
                      ),
                  ],
                );
              },
            ),

            // Add More Button
            ElevatedButton.icon(
              onPressed: addRow,
              icon: const Icon(Icons.add),
              label: const Text("Add More"),
            ),
            const SizedBox(height: 16.0),

            // Save Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Save logic
                },
                icon: const Icon(Icons.save),
                label: const Text("Save Buy Transaction"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionRow extends StatelessWidget {
  final TextEditingController companyController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController dpChargeController = TextEditingController();
  final TextEditingController costPerShareController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();

  TransactionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Company",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                items: const [
                  DropdownMenuItem(
                      value: "Company A", child: Text("Company A")),
                  DropdownMenuItem(
                      value: "Company B", child: Text("Company B")),
                ],
                onChanged: (value) {},
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: "Quantity",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: rateController,
                decoration: const InputDecoration(
                  labelText: "Rate",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                controller: dpChargeController,
                decoration: const InputDecoration(
                  labelText: "DP Charge",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: costPerShareController,
                decoration: const InputDecoration(
                  labelText: "Cost Per Share",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                controller: totalAmountController,
                decoration: const InputDecoration(
                  labelText: "Total Amount",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
