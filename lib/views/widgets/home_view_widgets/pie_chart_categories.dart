import 'package:expense_tracker/res/colors/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget pieChartCategories() {
  return SizedBox(
    height: 200,
    width: 150,
    child: PieChart(
      PieChartData(
        // Center space configuration
        centerSpaceRadius: 40,

        // Section spacing
        sectionsSpace: 2,
        sections: [
          // Salary - Largest portion
          PieChartSectionData(
            title: 'Salary',
            value: 40,
            color: AppColors.brown,
            radius: 60,
            titleStyle: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          // Rent
          PieChartSectionData(
            title: 'Rent',
            value: 25,
            color: AppColors.blue ?? Colors.blue,
            radius: 60,
            titleStyle: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          // Groceries
          PieChartSectionData(
            title: 'Groceries',
            value: 15,
            color: AppColors.green ?? Colors.green,
            radius: 60,
            titleStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          // Entertainment
          PieChartSectionData(
            title: 'Entertainment',
            value: 10,
            color: AppColors.orange ?? Colors.orange,
            radius: 60,
            titleStyle: TextStyle(
              fontSize: 5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          // Savings
          PieChartSectionData(
            title: 'Savings',
            value: 10,
            color: AppColors.purple ?? Colors.purple,
            radius: 60,
            titleStyle: TextStyle(
              fontSize: 6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
