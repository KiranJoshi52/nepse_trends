import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart'; // Add this package in pubspec.yaml

class BonusDividendPortfolioScreen extends StatefulWidget {
  const BonusDividendPortfolioScreen({super.key});

  @override
  _BonusDividendPortfolioScreenState createState() =>
      _BonusDividendPortfolioScreenState();
}

class _BonusDividendPortfolioScreenState
    extends State<BonusDividendPortfolioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shareholderController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _bonusShareController = TextEditingController();
  String? _selectedCompany;

  final List<String> _companies = ['Company A', 'Company B', 'Company C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField('Shareholder', 'Enter Shareholder Name',
                  _shareholderController),
              const SizedBox(height: 16),
              _buildCompanyDropdown(),
              const SizedBox(height: 16),
              _buildDatePicker('Received Date (AD)', 'YYYY-MM-DD (AD)',
                  _dateController, _pickDate),
              const SizedBox(height: 16),
              _buildTextFormField(
                'Bonus Share Quantity (Units)',
                'Enter Bonus Share Quantity',
                _bonusShareController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildCompanyDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Company',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCompany,
          items: _companies.map((String company) {
            return DropdownMenuItem<String>(
              value: company,
              child: Text(company),
            );
          }).toList(),
          decoration: const InputDecoration(
            hintText: 'Search for company',
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _selectedCompany = value;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a company';
            }
            return null;
          },
        ),
      ],
    );
  }

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
                prefixIcon: const Icon(Icons.calendar_today),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
        onPressed: _submitForm,
        child: const Text(
          'Save Bonus Dividend',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bonus Dividend Added Successfully!')),
      );
    }
  }
}
