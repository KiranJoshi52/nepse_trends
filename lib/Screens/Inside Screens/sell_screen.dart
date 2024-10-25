import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();

  // Default values for the radio buttons
  String _selectedBuyType = 'Secondary';  
  String _selectedInvestorType = 'Individual';  
  String _selectedTaxRate = '7.5%';

  final TextEditingController _purchasePriceController = TextEditingController();
  final TextEditingController _sellPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  // Calculation logic
  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final purchasePrice = double.parse(_purchasePriceController.text);
      final sellPrice = double.parse(_sellPriceController.text);
      final quantity = int.parse(_quantityController.text);
      final taxRate = double.parse(_selectedTaxRate.replaceAll('%', ''));

      final totalPurchase = purchasePrice * quantity;
      final totalSell = sellPrice * quantity;
      final profit = totalSell - totalPurchase;
      final taxAmount = (profit * taxRate) / 100;
      final finalProfit = profit - taxAmount;

      _showResult(finalProfit);
    }
  }

  // Result dialog
  void _showResult(double finalProfit) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Calculation Result'),
          content: Text('Final Profit: \$${finalProfit.toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Reset fields
  void _reset() {
    _formKey.currentState!.reset();
    setState(() {
      _selectedBuyType = 'Secondary';
      _selectedInvestorType = 'Individual';
      _selectedTaxRate = '7.5%';
      _purchasePriceController.clear();
      _sellPriceController.clear();
      _quantityController.clear();
    });
  }

  // Input validation
  String? _validateInput(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter the $fieldName';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  // Reusable radio button builder
  Widget _buildRadioGroup({
    required String title,
    required List<String> options,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Row(
          children: options.map((option) {
            return Row(
              children: [
                Radio<String>(
                  value: option,
                  groupValue: groupValue,
                  onChanged: onChanged,
                  activeColor: Colors.green,
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Sell Screen'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildRadioGroup(
                title: 'Buy Type',
                options: ['Secondary', 'IPO'],
                groupValue: _selectedBuyType,
                onChanged: (value) => setState(() {
                  _selectedBuyType = value!;
                }),
              ),
              TextFormField(
                controller: _purchasePriceController,
                decoration: const InputDecoration(
                  labelText: 'Purchased Price / Per Share',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => _validateInput(value, 'purchased price'),
              ),
              TextFormField(
                controller: _sellPriceController,
                decoration: const InputDecoration(
                  labelText: 'Sell Price / Per Share',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => _validateInput(value, 'sell price'),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => _validateInput(value, 'quantity'),
              ),
              _buildRadioGroup(
                title: 'Investor Type',
                options: ['Individual', 'Institutional'],
                groupValue: _selectedInvestorType,
                onChanged: (value) => setState(() {
                  _selectedInvestorType = value!;
                }),
              ),
              _buildRadioGroup(
                title: 'Capital Gain Tax',
                options: ['7.5%', '5%'],
                groupValue: _selectedTaxRate,
                onChanged: (value) => setState(() {
                  _selectedTaxRate = value!;
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Calculate',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: _reset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Reset',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
