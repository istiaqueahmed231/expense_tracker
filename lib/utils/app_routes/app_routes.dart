import 'package:get/get.dart';

import '../../views/home_view.dart';
import '../../views/splash_view.dart';
import '../route_names/route_names.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteNames.splashView,
      page: () =>  SplashView(),
      transition: Transition.fadeIn, // Adds a smooth feel
    ),
    GetPage(
      name: RouteNames.homeView,
      page: () => HomeView(),
      transition: Transition.rightToLeftWithFade,
    ),


  ];
}

