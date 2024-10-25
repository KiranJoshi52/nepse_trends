import 'package:flutter/material.dart';
import 'package:nepse_trends/provider/sell_provider.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

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
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: provider.formKey,
          child: ListView(
            children: [
              _buildRadioGroup(
                title: 'Buy Type',
                options: ['Secondary', 'IPO'],
                groupValue: provider.selectedBuyType,
                onChanged: (value) {
                  provider.setSelectedBuyType(
                      value); // Updated to match expected type
                },
              ),
              TextFormField(
                controller: provider.purchasePriceController,
                decoration: const InputDecoration(
                  labelText: 'Purchased Price / Per Share',
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    provider.validateInput(value, 'purchased price'),
              ),
              TextFormField(
                controller: provider.sellPriceController,
                decoration: const InputDecoration(
                  labelText: 'Sell Price / Per Share',
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    provider.validateInput(value, 'sell price'),
              ),
              TextFormField(
                controller: provider.quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => provider.validateInput(value, 'quantity'),
              ),
              _buildRadioGroup(
                title: 'Investor Type',
                options: ['Individual', 'Institutional'],
                groupValue: provider.selectedInvestorType,
                onChanged: (value) {
                  provider.setSelectedInvestorType(value);
                },
              ),
              _buildRadioGroup(
                title: 'Capital Gain Tax',
                options: ['7.5%', '5%'],
                groupValue: provider.selectedTaxRate,
                onChanged: (value) {
                  provider.setSelectedTaxRate(value);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: provider.calculate,
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
                    onPressed: provider.reset,
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
              if (provider.totalAmount != null) ...[
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Total Amount', provider.totalAmount!),
                    const Divider(),
                    _buildDetailRow(
                        'Broker Commission', provider.brokerCommission!),
                    const Divider(),
                    _buildDetailRow(
                        'SEBON Commission', provider.sebonCommission!),
                    const Divider(),
                    _buildDetailRow('DP Charge', provider.dpCharge!),
                    const Divider(),
                    _buildDetailRow('Total Amount Receivable (Rs.)',
                        provider.totalReceivable!),
                    const Divider(),
                    _buildDetailRow(
                      'Capital Gain Tax (${provider.selectedTaxRate}) (Rs.)',
                      provider.capitalGainTax!,
                    ),
                    const Divider(),
                    _buildDetailRow('Purchase Value', provider.purchaseValue!),
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
