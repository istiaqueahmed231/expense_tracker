import 'package:expense_tracker/res/colors/app_colors.dart';
import 'package:expense_tracker/view_models/controllers/balance_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget balanceExpenseBox() {
  final BalanceExpenseController controller = Get.put(
    BalanceExpenseController(),
  );

  //num? bal = controller.balance.value;
  //num? exps = controller.expense.value;
  return Card(
    shadowColor: AppColors.grey,
    margin: const EdgeInsets.all(10),
    borderOnForeground: true,
    shape: const ContinuousRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    elevation: 5,

    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [balancePart(controller), verticalLine(), expensePart(controller)],
      ),
    ),
  );
}

Widget verticalLine() {
  return Container(
    width: 2,
    height: 50, // Fixed height
    color: AppColors.black,
    margin: const EdgeInsets.symmetric(horizontal: 10),
  );
}

Widget expensePart(BalanceExpenseController controller) {
  return Column(
    children: [
      Text("TOTAL EXPENSE", style: balanceExpenseTextStyle()),

      Obx(() {
        return Text("BDT ${controller.expense.value}");
      }),
    ],
  );
}

TextStyle? balanceExpenseTextStyle() {
  return const TextStyle(
    color: AppColors.brown,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 3.0,
    fontFamily: 'Playfair Display',
    shadows: [
      Shadow(color: Colors.black12, offset: Offset(3, 3), blurRadius: 6),
    ],
  );
}

Widget balancePart(BalanceExpenseController controller) {
  return Column(
    children: [
      Text("TOTAL BALANCE", style: balanceExpenseTextStyle()),

      Obx(() {
        return Text("BDT ${controller.balance.value}");
      }),
    ],
  );
}
