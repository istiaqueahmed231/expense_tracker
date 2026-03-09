import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/res/colors/app_colors.dart';

class PieChartController extends GetxController {
  // -1 means no section is currently touched
  var touchedIndex = (-1).obs;

  var categoryData = <Map<String, dynamic>>[
    {'title': 'Travel', 'value': 2500.0, 'color': Colors.orange},
    {'title': 'Shopping', 'value': 1500.0, 'color': Colors.redAccent},
    {'title': 'Entertainment', 'value': 2000.0, 'color': Colors.greenAccent},
    {'title': 'Grocery', 'value': 1500.0, 'color': Colors.cyan},
    {'title': 'Food & Drink', 'value': 2500.0, 'color': Colors.purpleAccent},
  ].obs;

  double get totalAmount => categoryData.fold(0, (sum, item) => sum + item['value']);
}