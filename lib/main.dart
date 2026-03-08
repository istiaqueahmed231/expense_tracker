import 'package:expense_tracker/res/themes/app_themes.dart';
import 'package:expense_tracker/services/local_db_service.dart';
import 'package:expense_tracker/utils/app_routes/app_routes.dart';
import 'package:expense_tracker/utils/route_names/route_names.dart';
import 'package:expense_tracker/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => LocalDbService().initDb()); // Initialize DB
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Expense Manager",
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes(),
      initialRoute: RouteNames.homeView,
    );
  }
}
