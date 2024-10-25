import 'package:flutter/material.dart';

class BuyProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  String _totalPrice = '';

  String get totalPrice => _totalPrice;

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void calculateTotal() {
    if (validateForm()) {
      double price = double.parse(priceController.text);
      int quantity = int.parse(quantityController.text);

      double total = (price * quantity) + 16.56 + 0.69 + 25;
      _totalPrice = total.toStringAsFixed(2);
      notifyListeners();
    }
  }

  void reset() {
    formKey.currentState?.reset();
    priceController.clear();
    quantityController.clear();
    _totalPrice = '';
    notifyListeners();
  }
}
