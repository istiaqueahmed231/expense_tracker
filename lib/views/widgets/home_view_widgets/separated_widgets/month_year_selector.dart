import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Ensure these paths match your project structure
import '../../../../res/colors/app_colors.dart';

import '../../../../view_models/controllers/date_selection_controller.dart';

class MonthYearSelector extends StatelessWidget {
  MonthYearSelector({super.key});

  final DateSelectionController controller = Get.put(DateSelectionController());
  final LayerLink _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: controller.overlayController,
        overlayChildBuilder: (context) => _buildSelectionPanel(),
        child: _buildTriggerButton(),
      ),
    );
  }

  // The "This Month" Button using AppColors
  Widget _buildTriggerButton() {
    return InkWell(
      onTap: controller.togglePanel,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          // Use grey for the border as defined in your common colors
          border: Border.all(color: AppColors.darkBackground.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Text(
                "${controller.selectedMonth.value} ${controller.selectedYear.value}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // Adaptive text color based on theme
                  color: Get.isDarkMode
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Accent color used for the dropdown icon
            const Icon(Icons.arrow_drop_down, color: AppColors.info),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionPanel() {
    return CompositedTransformFollower(
      link: _layerLink,
      targetAnchor: Alignment.bottomRight,
      followerAnchor: Alignment.topRight,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Material(
            elevation: 12,
            shadowColor: Colors.black38,
            borderRadius: BorderRadius.circular(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 210,
                height: 240,
                // Adaptive surface color
                color: Get.isDarkMode
                    ? AppColors.darkSurface
                    : AppColors.darkTextSecondary,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildScrollableList(controller.months, true),
                    ),
                    VerticalDivider(
                      width: 1,
                      thickness: 0.5,
                      // Subtle info color for divider
                      color: AppColors.info.withOpacity(0.2),
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildScrollableList(controller.years, false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableList(List<String> items, bool isMonth) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Obx(() {
          final isSelected = isMonth
              ? controller.selectedMonth.value == item
              : controller.selectedYear.value == item;

          return InkWell(
            onTap: () => isMonth
                ? controller.updateMonth(item)
                : controller.updateYear(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                // Use info color for the selection highlight
                color: isSelected
                    ? AppColors.info.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  // Adaptive color selection logic
                  color: isSelected
                      ? AppColors.info
                      : (Get.isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
