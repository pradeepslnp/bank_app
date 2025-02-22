import 'package:flutter/material.dart';

class PanFormBusiness extends ChangeNotifier {
  TextEditingController panController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  String _pan = "";
  String _day = "";
  String _month = "";
  String _year = "";
  bool _isValid = false;

  String _errorMessage = "invalid details";
  bool isHidePanFeild = false;

  bool get isValid => _isValid;
  String get errorMessage => _errorMessage;

  void setPAN(String value) {
    _pan = value;
    _validateForm();
  }

  void setDay(String value) {
    _day = value;
    _validateForm();
  }

  void setMonth(String value) {
    _month = value;
    _validateForm();
  }

  void setYear(String value) {
    _year = value;
    _validateForm();
  }

  void _validateForm() {
    bool isValidPAN =
        RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}').hasMatch(_pan.toUpperCase());
    bool isValidDate = _validateDate();

    if (!isValidPAN) {
      _errorMessage = "Invalid PAN format. It should be in AAAAA9999A format.";
    } else if (!isValidDate) {
      _errorMessage = "Invalid date. Please enter a valid date.";
    } else {
      _errorMessage = "";
    }

    _isValid = isValidPAN && isValidDate;
    notifyListeners();
  }

  bool _validateDate() {
    if (_day.isEmpty || _month.isEmpty || _year.isEmpty) return false;
    int? d = int.tryParse(_day);
    int? m = int.tryParse(_month);
    int? y = int.tryParse(_year);
    if (d == null || m == null || y == null) return false;
    try {
      DateTime date = DateTime(y, m, d);
      return date.day == d && date.month == m && date.year == y;
    } catch (_) {
      return false;
    }
  }

  void resetForm() {
    panController.clear();
    dayController.clear();
    monthController.clear();
    yearController.clear();

    _isValid = false;
    _pan = "";
    _day = "";
    _month = "";
    _year = "";
    _isValid = false;
    _errorMessage = "invalid details";
    notifyListeners();
  }
}
