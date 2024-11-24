import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepse_trends/constants/color.dart'; // Add this package in pubspec.yaml

class BuyPortfolioScreen extends StatefulWidget {
  const BuyPortfolioScreen({super.key});

  @override
  _BuyPortfolioScreenState createState() => _BuyPortfolioScreenState();
}

class _BuyPortfolioScreenState extends State<BuyPortfolioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shareholderController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(); // For AD date
  final TextEditingController _nepaliDateController =
      TextEditingController(); // For BS date
  String? _selectedCompany;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dpChargeController = TextEditingController();
  final TextEditingController _costPerShareController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();

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
              _buildTextFormField(
                  'Shareholder', 'Shareholder name', _shareholderController),
              const SizedBox(height: 16),
              _buildDatePicker('Purchase Date (AD)', 'YYYY-MM-DD (AD)',
                  _dateController, _pickDate),
              const SizedBox(height: 16),
              _buildDatePicker('Purchase Date (BS)', 'YYYY-MM-DD (BS)',
                  _nepaliDateController, _pickNepaliDate),
              const SizedBox(height: 16),
              _buildCompanyDropdown(),
              const SizedBox(height: 16),
              _buildTextFormField(
                  'Quantity', 'Enter quantity', _quantityController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextFormField(
                  'Purchase Price', 'Enter purchase price', _priceController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextFormField(
                  'DP Charge', 'Enter DP Charge', _dpChargeController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextFormField(
                  'Cost Per Share', 'Cost Per Share', _costPerShareController,
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
            hintText: 'Search for company',
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
          'Add Share',
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
      // Grouped setState for both fields
      setState(() {
        _dateController.text = picked.toString().split(' ')[0];
        _nepaliDateController.text = NepaliDateFormat("yyyy-MM-dd")
            .format(NepaliDateTime.fromDateTime(picked));
      });
    }
  }

  // Nepali Date picker
  Future<void> _pickNepaliDate() async {
    final NepaliDateTime? picked = await showMaterialDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000, 1, 1),
      lastDate: NepaliDateTime(2090, 12, 30),
    );
    if (picked != null) {
      // Grouped setState for both fields
      setState(() {
        _nepaliDateController.text =
            NepaliDateFormat("yyyy-MM-dd").format(picked);
        _dateController.text = picked.toDateTime().toString().split(' ')[0];
      });
    }
  }

  // Form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Share added successfully!')),
      );
    }
  }
}
