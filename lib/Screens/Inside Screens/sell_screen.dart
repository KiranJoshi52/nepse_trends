import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isSecondary = false;
  bool _isIPO = false;
  bool _isIndividual = false;
  bool _isInstitutional = false;
  bool _isTax75 = false;
  bool _isTax5 = false;

  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _sellPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      double purchasePrice = double.parse(_purchasePriceController.text);
      double sellPrice = double.parse(_sellPriceController.text);
      int quantity = int.parse(_quantityController.text);
      double capitalGainTax = _isTax75 ? 7.5 : (_isTax5 ? 5.0 : 0.0);

      double totalPurchase = purchasePrice * quantity;
      double totalSell = sellPrice * quantity;
      double profit = totalSell - totalPurchase;
      double taxAmount = (profit * capitalGainTax) / 100;
      double finalProfit = profit - taxAmount;

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
    setState(() {
      _formKey.currentState!.reset();
      _isSecondary = false;
      _isIPO = false;
      _isIndividual = false;
      _isInstitutional = false;
      _isTax75 = false;
      _isTax5 = false;
      _purchasePriceController.clear();
      _sellPriceController.clear();
      _quantityController.clear();
    });
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
              // Buy Type (Horizontal Checkboxes)
              const Text('Buy Type'),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _isSecondary,
                        shape: const CircleBorder(), // Makes checkbox round
                        onChanged: (bool? value) {
                          setState(() {
                            _isSecondary = value ?? false;
                          });
                        },
                      ),
                      const Text('Secondary'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _isIPO,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            _isIPO = value ?? false;
                          });
                        },
                      ),
                      const Text('IPO'),
                    ],
                  ),
                ],
              ),
              // Purchased Price
              TextFormField(
                controller: _purchasePriceController,
                decoration: const InputDecoration(
                  labelText: 'Purchased Price / Per Share',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the purchased price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              // Sell Price
              TextFormField(
                controller: _sellPriceController,
                decoration: const InputDecoration(
                  labelText: 'Sell Price / Per Share',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the sell price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              // Quantity
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              // Investor Type (Horizontal Checkboxes)
              const Text('Investor Type'),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _isIndividual,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            _isIndividual = value ?? false;
                          });
                        },
                      ),
                      const Text('Individual'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _isInstitutional,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            _isInstitutional = value ?? false;
                          });
                        },
                      ),
                      const Text('Institutional'),
                    ],
                  ),
                ],
              ),
              // Capital Gain Tax (Horizontal Checkboxes)
              const Text('Capital Gain Tax'),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _isTax75,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            _isTax75 = value ?? false;
                            if (_isTax75) _isTax5 = false;
                          });
                        },
                      ),
                      const Text('7.5%'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _isTax5,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            _isTax5 = value ?? false;
                            if (_isTax5) _isTax75 = false;
                          });
                        },
                      ),
                      const Text('5%'),
                    ],
                  ),
                ],
              ),
              // Calculate and Reset Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _calculate,
                    child: const Text(
                      'Calculate',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the radius here
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: _reset,
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the radius here
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
