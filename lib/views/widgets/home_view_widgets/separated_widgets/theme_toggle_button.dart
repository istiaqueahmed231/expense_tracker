import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

// 1. Move the variable outside so it doesn't reset on every build
final RxBool isDark = Get.isDarkMode.obs;

Widget themeToggleButton() {
  return Obx(
    () => IconButton(
      // 2. Wrap with Obx to listen for changes
      onPressed: () {
        // 3. Toggle the value properly
        isDark.value = !isDark.value;

        Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
      },
      icon: Icon(
        isDark.value ? Icons.wb_sunny_rounded : Icons.nightlight_round,
        color: isDark.value ? Colors.amber : Colors.blueGrey,
      ),
      tooltip: 'Toggle Theme',
    ),
  );
}
