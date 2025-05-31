import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/core/services/services.dart';

class Mymidellware extends GetMiddleware {
  MyServices myServices = Get.find();
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final step = myServices.sharedpreferences.getString("step");
    final user_found = myServices.sharedpreferences.getBool("user found");

    // Check the step and current route to avoid redundant navigation
    if (step == null && route != AppRoute.OnboardingPage) {
      return const RouteSettings(name: AppRoute.OnboardingPage);
    }
    if (step == "2" && user_found != true && route != AppRoute.chosepage) {
      return const RouteSettings(name: AppRoute.chosepage);
    }
    if (step == "3" && route != AppRoute.navigation) {
      return const RouteSettings(name: AppRoute.navigation);
    }
    if (step == "1" && route != AppRoute.OnboardingPage) {
      return const RouteSettings(name: AppRoute.OnboardingPage);
    }
    if (step == "4" && route != AppRoute.chosepageforseller) {
      return const RouteSettings(name: AppRoute.chosepageforseller);
    }
    if (step == "5" && user_found == true && route != AppRoute.navigation) {
      return const RouteSettings(name: AppRoute.navigation);
    }
    return null;
  }
}
