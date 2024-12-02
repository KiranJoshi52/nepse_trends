import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart'; // Add this package in pubspec.yaml

class IPOPortfolioScreen extends StatefulWidget {
  const IPOPortfolioScreen({super.key});

  @override
  _IPOPortfolioScreenState createState() => _IPOPortfolioScreenState();
}

class _IPOPortfolioScreenState extends State<IPOPortfolioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shareholderController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(); // For AD date
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
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
              _buildDatePicker('Date (AD)', 'YYYY-MM-DD (AD)', _dateController),
              const SizedBox(height: 16),
              _buildCompanyDropdown(),
              const SizedBox(height: 16),
              _buildTextFormField(
                  'Quantity', 'Enter Quantity', _quantityController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextFormField('Rate', 'Enter Rate', _priceController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextFormField(
                  'Total Amount', 'Enter Total Amount', _totalAmountController,
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

  // Helper widget to build the TextFormFields
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

  // Helper widget to build the Date Picker
  Widget _buildDatePicker(
      String label, String hintText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickDate,
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

  // Helper widget for Company Dropdown
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
          hint: const Text('Select company'),
          value: _selectedCompany,
          items: _companies.map((String company) {
            return DropdownMenuItem<String>(
              value: company,
              child: Text(
                company,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, size: 20),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            isDense: true,
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(fontSize: 14, color: Colors.black),
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

  // Submit button widget
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
        onPressed: _submitForm,
        child: const Text(
          'Save IPO Transaction',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
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
        _dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  // Form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('IPO saved successfully!')),
      );
    }
  }
}
