import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AddEntryController extends GetxController {
  var isIncome = true.obs;
  var selectedDate = DateTime.now().obs;
  var selectedCategory = "".obs;

  // Mock categories (You will eventually fetch these from LocalDbService)
  var categories = ['Salary', 'Food', 'Rent', 'Freelance'].obs;

  void toggleType(bool value) => isIncome.value = value;

  void updateDate(DateTime date) => selectedDate.value = date;

  void addCategory(String name) {
    if (name.isNotEmpty) categories.add(name);
  }
}