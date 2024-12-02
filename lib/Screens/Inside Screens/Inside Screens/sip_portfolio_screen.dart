import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart'; // Add this package in pubspec.yaml

class SipPortfolioScreen extends StatefulWidget {
  const SipPortfolioScreen({super.key});

  @override
  _SipPortfolioScreenState createState() => _SipPortfolioScreenState();
}

class _SipPortfolioScreenState extends State<SipPortfolioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shareholderController = TextEditingController();
  final TextEditingController _receivedDateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String? _selectedMutualFund;
  String? _selectedAction;

  final List<String> _mutualFunds = ['Fund A', 'Fund B', 'Fund C'];
  final List<String> _actions = ['Buy', 'Sell', 'Hold'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField('Shareholder', 'Enter shareholder name',
                  _shareholderController),
              const SizedBox(height: 16),
              _buildDatePicker('Received Date (AD)', 'YYYY-MM-DD',
                  _receivedDateController, _pickDate),
              const SizedBox(height: 16),
              _buildDropdown('Mutual Fund', 'Select Mutual Fund', _mutualFunds,
                  _selectedMutualFund, (value) {
                setState(() {
                  _selectedMutualFund = value;
                });
              }),
              const SizedBox(height: 16),
              _buildDropdown(
                  'Action', 'Select Action', _actions, _selectedAction,
                  (value) {
                setState(() {
                  _selectedAction = value;
                });
              }),
              const SizedBox(height: 16),
              _buildTextFormField(
                  'Share Quantity', 'Enter quantity', _quantityController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 24),
              _buildSubmitButton(),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build TextFormFields
  Widget _buildTextFormField(
      String label, String hintText, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            isDense: true,
            border: const OutlineInputBorder(),
          ),
          style: const TextStyle(fontSize: 14),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Helper widget for dropdowns
  Widget _buildDropdown(String label, String hintText, List<String> items,
      String? selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          hint: Text(hintText),
          value: selectedValue,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          decoration: const InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            isDense: true,
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(fontSize: 14, color: Colors.black),
          onChanged: onChanged,
          validator: (value) {
            if (value == null) {
              return 'Please select $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Helper widget to build Date Picker
  Widget _buildDatePicker(String label, String hintText,
      TextEditingController controller, Function() onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: const Icon(Icons.calendar_today, size: 20),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                isDense: true,
                border: const OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 14),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a date';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  // Date picker for AD
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _receivedDateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  // Submit button widget
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
        onPressed: _submitForm,
        child: const Text(
          'Save SIP Transaction',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SIP Transaction saved successfully!')),
      );
    }
  }
}
