import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart'; // Ensure this is added in pubspec.yaml

class FpoPortfolioScreen extends StatefulWidget {
  const FpoPortfolioScreen({super.key});

  @override
  _FpoPortfolioScreenState createState() => _FpoPortfolioScreenState();
}

class _FpoPortfolioScreenState extends State<FpoPortfolioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shareholderController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(); // For AD date
  String? _selectedCompany;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();

  final List<String> _companies = ['Company X', 'Company Y', 'Company Z'];

  // Focus nodes for each field
  final FocusNode _shareholderFocusNode = FocusNode();
  final FocusNode _quantityFocusNode = FocusNode();
  final FocusNode _rateFocusNode = FocusNode();
  final FocusNode _totalAmountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setupFocusListeners();
  }

  @override
  void dispose() {
    _shareholderController.dispose();
    _dateController.dispose();
    _quantityController.dispose();
    _rateController.dispose();
    _totalAmountController.dispose();
    _shareholderFocusNode.dispose();
    _quantityFocusNode.dispose();
    _rateFocusNode.dispose();
    _totalAmountFocusNode.dispose();
    super.dispose();
  }

  void _setupFocusListeners() {
    _shareholderFocusNode.addListener(() {
      if (!_shareholderFocusNode.hasFocus) _formKey.currentState!.validate();
    });
    _quantityFocusNode.addListener(() {
      if (!_quantityFocusNode.hasFocus) _formKey.currentState!.validate();
    });
    _rateFocusNode.addListener(() {
      if (!_rateFocusNode.hasFocus) _formKey.currentState!.validate();
    });
    _totalAmountFocusNode.addListener(() {
      if (!_totalAmountFocusNode.hasFocus) _formKey.currentState!.validate();
    });
  }

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
                  _shareholderController,
                  focusNode: _shareholderFocusNode),
              const SizedBox(height: 16),
              _buildCompanyDropdown(),
              const SizedBox(height: 16),
              _buildDatePicker(
                  'Date (AD)', 'YYYY-MM-DD (AD)', _dateController, _pickDate),
              const SizedBox(height: 16),
              _buildTextFormField(
                  'Quantity', 'Enter quantity', _quantityController,
                  focusNode: _quantityFocusNode,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextFormField('Rate', 'Enter rate', _rateController,
                  focusNode: _rateFocusNode,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextFormField(
                  'Total Amount', 'Enter total amount', _totalAmountController,
                  focusNode: _totalAmountFocusNode,
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

  Widget _buildTextFormField(
      String label, String hintText, TextEditingController controller,
      {FocusNode? focusNode, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          focusNode: focusNode,
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
            prefixIcon: Icon(Icons.business, size: 20),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            isDense: true,
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(fontSize: 14, color: Colors.black),
          onChanged: (value) {
            setState(() {
              _selectedCompany = value;
            });
            // Remove validation message when a value is selected
            _formKey.currentState!.validate();
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

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
        onPressed: _submitForm,
        child: const Text(
          'Save FPO Transaction',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
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
      _formKey.currentState!.validate();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('FPO transaction saved successfully!')),
      );
    }
  }
}
