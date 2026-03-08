import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateSelectionController extends GetxController {
  // Reactive variables for the current selection
  var selectedMonth = 'January'.obs;
  var selectedYear = '2026'.obs;

  // Track if a user has interacted with both in this "session"
  bool monthSelected = false;
  bool yearSelected = false;
  // Track if both have been selected in the current open session
  bool monthPicked = false;
  bool yearPicked = false;

  // Controls the visibility of the overlay
  final overlayController = OverlayPortalController();

  // List of data
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final List<String> years = ['2026', '2025', '2024'];

  void updateMonth(String month) {
    selectedMonth.value = month;
    monthPicked = true;
    _autoClose();
  }

  void updateYear(String year) {
    selectedYear.value = year;
    yearPicked = true;
    _autoClose();
  }

  void _autoClose() {
    if (monthPicked && yearPicked) {
      overlayController.hide();
      monthPicked = false; // Reset for next time
      yearPicked = false;
    }
  }

  void togglePanel() => overlayController.toggle();
}