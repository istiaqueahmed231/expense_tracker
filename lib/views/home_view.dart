import 'package:expense_tracker/res/colors/app_colors.dart';
import 'package:expense_tracker/view_models/controllers/home_view_controller.dart';
import 'package:expense_tracker/views/widgets/home_view_widgets/add_panel.dart';
import 'package:expense_tracker/views/widgets/home_view_widgets/balance_expense.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 10, left: 8, right: 8),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  headerPart(),
                  balanceExpenseBox(),
                  SizedBox(height: 50),
                  pieChartCategories(),
                  // footerPart(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: addButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget? addButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
           return addPanel();
          },
        );
        //add_panel();
        //Get.to(addPanel(context));
      },
      child: Icon(Icons.add, size: 50, color: AppColors.yellow),
    );
  }
}
