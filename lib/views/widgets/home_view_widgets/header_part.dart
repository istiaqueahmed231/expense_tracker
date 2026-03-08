
import 'package:expense_tracker/views/widgets/home_view_widgets/separated_widgets/month_year_selector.dart';
import 'package:expense_tracker/views/widgets/home_view_widgets/separated_widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';

//contains theme change option and calender

Widget headerPart() {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),

    // height: 100,
    // color: Colors.orange,
    // child: Center(child: Text("header widget")),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        themeToggleButton(),
        MonthYearSelector()
      ],
    ),
  );
}


