import 'package:expense_tracker/view_models/controllers/home_view_controller.dart';
import 'package:expense_tracker/views/widgets/home_view_widgets/balance_expense.dart';
import 'package:expense_tracker/views/widgets/home_view_widgets/footer_part.dart';
import 'package:expense_tracker/views/widgets/home_view_widgets/header_part.dart';
import 'package:expense_tracker/views/widgets/home_view_widgets/pie_chart_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewController controller = Get.put(HomeViewController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [

              headerPart(),
              balanceExpenseBox(),
              pieChartCategories(),
              footerPart(),
            ],
          ),
        ],
      ),
    );
  }
}
