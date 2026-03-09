import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_models/controllers/pie_chart_controller.dart';

Widget pieChartCategories() {
  final PieChartController controller = Get.find<PieChartController>();

  return Obx(() {
    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              // Handle Taps
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    controller.touchedIndex.value = -1;
                    return;
                  }
                  controller.touchedIndex.value =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                },
              ),
              centerSpaceRadius: 70,
              sectionsSpace: 4,
              sections: _buildSections(controller),
            ),
          ),
          // Center text adapts when a section is touched
          _buildCenterText(controller),
        ],
      ),
    );
  });
}

List<PieChartSectionData> _buildSections(PieChartController controller) {
  return List.generate(controller.categoryData.length, (i) {
    final isTouched = i == controller.touchedIndex.value;
    final data = controller.categoryData[i];

    // Calculate percentage
    final double percentage = (data['value'] / controller.totalAmount) * 100;

    return PieChartSectionData(
      color: data['color'],
      value: data['value'],
      // Only show title/details on the part that is bigger
      title: isTouched
          ? '${data['title']}\n${percentage.toStringAsFixed(1)}%'
          : '',
      radius: isTouched ? 35 : 25, // Section gets bigger on tap
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  });
}

Widget _buildCenterText(PieChartController controller) {
  return Obx(() {
    // If a section is touched, show that section's amount, otherwise show total
    bool hasTouch = controller.touchedIndex.value != -1;
    String amount = hasTouch
        ? controller.categoryData[controller.touchedIndex.value]['value'].toString()
        : controller.totalAmount.toStringAsFixed(0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "BDT $amount",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          hasTouch ? "Selected Category" : "Total Expense",
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  });
}