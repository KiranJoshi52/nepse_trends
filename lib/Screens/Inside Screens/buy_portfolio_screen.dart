import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart'; // Add this package in pubspec.yaml

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
              const Text(
                'Shareholder',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _shareholderController,
                decoration: const InputDecoration(
                  hintText: 'Shareholder name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 14),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the shareholder name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Purchase Date (AD)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'YYYY-MM-DD (AD)',
                      prefixIcon: const Icon(Icons.calendar_today, size: 20),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
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
              const SizedBox(height: 16),
              const Text(
                'Purchase Date (BS)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickNepaliDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _nepaliDateController,
                    decoration: InputDecoration(
                      hintText: 'YYYY-MM-DD (BS)',
                      prefixIcon: const Icon(Icons.calendar_today, size: 20),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      isDense: true,
                      border: const OutlineInputBorder(),
                    ),
                    style: const TextStyle(fontSize: 14),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a Nepali date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                  prefixIcon: Icon(Icons.search, size: 20),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 14),
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
              const SizedBox(height: 16),
              const Text(
                'Quantity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter quantity',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 14),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Purchase Price',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter purchase price',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 14),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the purchase price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: _submitForm,
                  child: const Text(
                    'Add Share',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
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
        _nepaliDateController.text = NepaliDateFormat("yyyy-MM-dd")
            .format(NepaliDateTime.fromDateTime(picked));
      });
    }
  }

  Future<void> _pickNepaliDate() async {
    final NepaliDateTime? picked = await showMaterialDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000, 1, 1),
      lastDate: NepaliDateTime(2090, 12, 30),
    );
    if (picked != null) {
      setState(() {
        _nepaliDateController.text =
            NepaliDateFormat("yyyy-MM-dd").format(picked);
        _dateController.text = picked.toDateTime().toString().split(' ')[0];
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Share added successfully!')),
      );
    }
  }
}
