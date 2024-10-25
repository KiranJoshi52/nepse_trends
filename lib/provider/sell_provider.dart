import 'package:flutter/material.dart';

class SellProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String selectedBuyType = 'Secondary';
  String selectedInvestorType = 'Individual';
  String selectedTaxRate = '7.5%';

  final purchasePriceController = TextEditingController();
  final sellPriceController = TextEditingController();
  final quantityController = TextEditingController();

  String? totalAmount;
  String? brokerCommission;
  String? sebonCommission;
  String? dpCharge;
  String? totalReceivable;
  String? capitalGainTax;
  String? purchaseValue;

  void setSelectedBuyType(String? value) {
    selectedBuyType = value!;
    notifyListeners();
  }

  void setSelectedInvestorType(String? value) {
    selectedInvestorType = value!;
    notifyListeners();
  }

  void setSelectedTaxRate(String? value) {
    selectedTaxRate = value!;
    notifyListeners();
  }

  void calculate() {
    if (formKey.currentState!.validate()) {
      final purchasePrice = double.parse(purchasePriceController.text);
      final sellPrice = double.parse(sellPriceController.text);
      final quantity = int.parse(quantityController.text);
      final taxRate = double.parse(selectedTaxRate.replaceAll('%', ''));

      final totalPurchase = purchasePrice * quantity;
      final totalSell = sellPrice * quantity;

      final calculatedBrokerCommission = totalSell * 0.005;
      final calculatedSebonCommission = totalSell * 0.00015;
      const calculatedDpCharge = 25.0;

      final totalAmountReceivable = totalSell -
          calculatedBrokerCommission -
          calculatedSebonCommission -
          calculatedDpCharge;
      final profit = totalSell - totalPurchase;
      final calculatedCapitalGainTax = (profit * taxRate) / 100;

      totalAmount = 'Rs. ${totalSell.toStringAsFixed(2)}';
      brokerCommission = 'Rs. ${calculatedBrokerCommission.toStringAsFixed(2)}';
      sebonCommission = 'Rs. ${calculatedSebonCommission.toStringAsFixed(2)}';
      dpCharge = 'Rs. $calculatedDpCharge';
      totalReceivable = 'Rs. ${totalAmountReceivable.toStringAsFixed(2)}';
      capitalGainTax = 'Rs. ${calculatedCapitalGainTax.toStringAsFixed(2)}';
      purchaseValue = 'Rs. ${totalPurchase.toStringAsFixed(2)}';

      notifyListeners();
    }
  }

  void reset() {
    formKey.currentState!.reset();
    selectedBuyType = 'Secondary';
    selectedInvestorType = 'Individual';
    selectedTaxRate = '7.5%';
    purchasePriceController.clear();
    sellPriceController.clear();
    quantityController.clear();
    totalAmount = null;
    brokerCommission = null;
    sebonCommission = null;
    dpCharge = null;
    totalReceivable = null;
    capitalGainTax = null;
    purchaseValue = null;

    notifyListeners();
  }

  String? validateInput(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter the $fieldName';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }
}
