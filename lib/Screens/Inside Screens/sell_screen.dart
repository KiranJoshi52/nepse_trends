import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedBuyType;
  String? _selectedInvestorType;
  String? _selectedTaxRate;

  final TextEditingController _purchasePriceController = TextEditingController();
  final TextEditingController _sellPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final double purchasePrice = double.parse(_purchasePriceController.text);
      final double sellPrice = double.parse(_sellPriceController.text);
      final int quantity = int.parse(_quantityController.text);
      final double capitalGainTax = _selectedTaxRate == '7.5%' ? 7.5 : (_selectedTaxRate == '5%' ? 5.0 : 0.0);

      final double totalPurchase = purchasePrice * quantity;
      final double totalSell = sellPrice * quantity;
      final double profit = totalSell - totalPurchase;
      final double taxAmount = (profit * capitalGainTax) / 100;
      final double finalProfit = profit - taxAmount;

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
  }

  void _reset() {
    _formKey.currentState!.reset();
    setState(() {
      _selectedBuyType = null;
      _selectedInvestorType = null;
      _selectedTaxRate = null;
      _purchasePriceController.clear();
      _sellPriceController.clear();
      _quantityController.clear();
    });
  }

  String? _validateInput(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter the $fieldName';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  Widget _buildRadio(String title, String value, String? groupValue,
      ValueChanged<String?> onChanged) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(title),
      ],
    );
  }

  Widget _buildTaxRadio(String title, String taxRate) {
    return Row(
      children: [
        Radio<String>(
          value: taxRate,
          groupValue: _selectedTaxRate,
          onChanged: (String? value) {
            setState(() {
              _selectedTaxRate = value;
            });
          },
        ),
        Text(title),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Buy Type'),
              Row(
                children: [
                  _buildRadio('Secondary', 'Secondary', _selectedBuyType,
                      (String? value) {
                    setState(() {
                      _selectedBuyType = value;
                    });
                  }),
                  _buildRadio('IPO', 'IPO', _selectedBuyType, (String? value) {
                    setState(() {
                      _selectedBuyType = value;
                    });
                  }),
                ],
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
              const Text('Investor Type'),
              Row(
                children: [
                  _buildRadio('Individual', 'Individual', _selectedInvestorType,
                      (String? value) {
                    setState(() {
                      _selectedInvestorType = value;
                    });
                  }),
                  _buildRadio(
                      'Institutional', 'Institutional', _selectedInvestorType,
                      (String? value) {
                    setState(() {
                      _selectedInvestorType = value;
                    });
                  }),
                ],
              ),
              const Text('Capital Gain Tax'),
              Row(
                children: [
                  // Expanded(
                  //   child: _buildTaxRadio('7.5%', '7.5%'),
                  // ),
                  // Expanded(
                  //   child: _buildTaxRadio('5%', '5%'),
                  // ),
                  _buildTaxRadio('7.5%', '7.5%'),
                  _buildTaxRadio('5%', '5%'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _calculate,
                    child: const Text('Calculate', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: _reset,
                    child: const Text('Reset', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
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
