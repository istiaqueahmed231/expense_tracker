import 'package:get/get.dart';

class BalanceExpenseController extends GetxController {
  // Observable variables
  RxDouble balance = 400.0.obs;
  RxDouble expense = 500.0.obs;

  // Optional: Add methods to update values
  void updateBalance(double newBalance) {
    balance.value = newBalance;
  }

  void updateExpense(double newExpense) {
    expense.value = newExpense;
  }

  void addExpense(double amount) {
    expense.value += amount;
    balance.value -= amount;
  }

  void addIncome(double amount) {
    balance.value += amount;
  }

  // Computed property example
  double get total => balance.value + expense.value;

  // Reset method
  void reset() {
    balance.value = 400.0;
    expense.value = 500.0;
  }

  @override
  void onInit() {
    // Called immediately after the controller is created
    super.onInit();
    print('BalanceExpenseController initialized');
  }

  @override
  void onClose() {
    // Called just before the controller is deleted
    super.onClose();
    print('BalanceExpenseController closed');
  }
}