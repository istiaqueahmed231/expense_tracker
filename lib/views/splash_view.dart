import 'package:expense_tracker/view_models/controllers/splash_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  final SplashViewController controller = Get.put(SplashViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
