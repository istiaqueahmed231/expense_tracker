import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:path/path.dart';

import '../../../res/colors/app_colors.dart';
import '../../../view_models/controllers/add_entry_controller.dart';

Widget addPanel() {
  final AddEntryController c = Get.put(AddEntryController());

  return SizedBox(
    height: 500, // Slightly taller to fit the form
    width: double.maxFinite,
    child: Column(
      children: [
        // FIXED HEADER
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'NEW ENTRY',
            style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        // SCROLLABLE FORM
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Title Input
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'e.g. Office Lunch',
                  ),
                ),
                const SizedBox(height: 20),

                // 2. Income/Expense Toggle
                Obx(
                  () => Row(
                    children: [
                      ChoiceChip(
                        label: const Text("Income"),
                        selected: c.isIncome.value,
                        onSelected: (val) => c.toggleType(true),
                        selectedColor: AppColors.success.withOpacity(0.2),
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text("Expense"),
                        selected: !c.isIncome.value,
                        onSelected: (val) => c.toggleType(false),
                        selectedColor: AppColors.lightError.withOpacity(0.2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 3. Date Picker
                Obx(
                  () => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Date: ${c.selectedDate.value.day}/${c.selectedDate.value.month}/${c.selectedDate.value.year}",
                    ),
                    trailing: const Icon(
                      Icons.calendar_month,
                      color: AppColors.info,
                    ),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: Get.context!,
                        initialDate: c.selectedDate.value,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) c.updateDate(picked);
                    },
                  ),
                ),

                // 4. Categories & Add New
                const Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    children: [
                      ...c.categories.map(
                        (cat) => ActionChip(
                          label: Text(cat),
                          onPressed: () => c.selectedCategory.value = cat,
                          backgroundColor: c.selectedCategory.value == cat
                              ? AppColors.info.withOpacity(0.3)
                              : null,
                        ),
                      ),
                      ActionChip(
                        avatar: const Icon(Icons.add, size: 16),
                        label: const Text("New"),
                        onPressed: () => _showNewCategoryDialog(c),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 5. Amount Input
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixText: 'BDT ',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "SAVE ENTRY",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void _showNewCategoryDialog(AddEntryController c) {
  TextEditingController textC = TextEditingController();
  Get.defaultDialog(
    title: "New Category",
    content: TextField(controller: textC),
    onConfirm: () {
      c.addCategory(textC.text);
      Get.back();
    },
  );
}
