import 'package:flutter/material.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String _totalPrice = '';

  void _calculate() {
    if (_formKey.currentState?.validate() ?? false) {
      double price = double.parse(_priceController.text);
      int quantity = int.parse(_quantityController.text);
      double purchaseValue = price * quantity;
      double total = (price * quantity) + 16.56 + 0.69 + 25;
      
      setState(() {
        _totalPrice = "Purchase Value: ${purchaseValue}\n" +
            "Broker Commission: 16.56\n" +
            "SEBON Commission: 0.69\n" +
            "DP Charge: 25" +
            "Total Amount: ${total.toStringAsFixed(2)}";
      });
    }
  }

  void _reset() {
    _formKey.currentState?.reset(); // Reset form and validation state
    _priceController.clear(); // Clear the input fields
    _quantityController.clear();
    setState(() {
      _totalPrice = ''; // Reset the total price display
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Buy Price / Per Share',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Enter a valid integer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the radius for slight rounding
                      ),
                    ),
                    child: const Text(
                      'Calculate',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _reset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Slight rounding for the border radius
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_totalPrice.isNotEmpty)
                Text(
                  _totalPrice,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
