import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedBuyType = 'Secondary';
  String _selectedInvestorType = 'Individual';
  String _selectedTaxRate = '7.5%';

  final TextEditingController _purchasePriceController = TextEditingController();
  final TextEditingController _sellPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String? _totalAmount;
  String? _brokerCommission;
  String? _sebonCommission;
  String? _dpCharge;
  String? _totalReceivable;
  String? _capitalGainTax;
  String? _purchaseValue;

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final purchasePrice = double.parse(_purchasePriceController.text);
      final sellPrice = double.parse(_sellPriceController.text);
      final quantity = int.parse(_quantityController.text);
      final taxRate = double.parse(_selectedTaxRate.replaceAll('%', ''));

      final totalPurchase = purchasePrice * quantity;
      final totalSell = sellPrice * quantity;

      // Calculation logic for each field
      final brokerCommission = totalSell * 0.005; // 0.5% broker commission
      final sebonCommission = totalSell * 0.00015; // 0.015% SEBON commission
      final dpCharge = 25.0; // Flat DP charge

      final totalAmountReceivable =
          totalSell - brokerCommission - sebonCommission - dpCharge;
      final profit = totalSell - totalPurchase;
      final capitalGainTax = (profit * taxRate) / 100;

      setState(() {
        _totalAmount = 'Rs. ${totalSell.toStringAsFixed(2)}';
        _brokerCommission = 'Rs. ${brokerCommission.toStringAsFixed(2)}';
        _sebonCommission = 'Rs. ${sebonCommission.toStringAsFixed(2)}';
        _dpCharge = 'Rs. $dpCharge';
        _totalReceivable = 'Rs. ${totalAmountReceivable.toStringAsFixed(2)}';
        _capitalGainTax = 'Rs. ${capitalGainTax.toStringAsFixed(2)}';
        _purchaseValue = 'Rs. ${totalPurchase.toStringAsFixed(2)}';
      });
    }
  }

  void _reset() {
    _formKey.currentState!.reset();
    setState(() {
      _selectedBuyType = 'Secondary';
      _selectedInvestorType = 'Individual';
      _selectedTaxRate = '7.5%';
      _purchasePriceController.clear();
      _sellPriceController.clear();
      _quantityController.clear();
      _totalAmount = null;
      _brokerCommission = null;
      _sebonCommission = null;
      _dpCharge = null;
      _totalReceivable = null;
      _capitalGainTax = null;
      _purchaseValue = null;
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

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              if (_totalAmount != null) ...[
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      'Total Amount',
                      _totalAmount!,
                    ),
                    const Divider(),
                    _buildDetailRow('Broker Commission', _brokerCommission!),
                    const Divider(),
                    _buildDetailRow('SEBON Commission', _sebonCommission!),
                    const Divider(),
                    _buildDetailRow('DP Charge', _dpCharge!),
                    const Divider(),
                    _buildDetailRow(
                        'Total Amount Receivable', _totalReceivable!),
                    const Divider(),
                    _buildDetailRow('Capital Gain Tax ($_selectedTaxRate)',
                        _capitalGainTax!),
                    const Divider(),
                    _buildDetailRow('Purchase Value', _purchaseValue!),
                    const Divider(),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
