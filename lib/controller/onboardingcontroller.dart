import 'package:flutter/material.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/core/services/services.dart';
import 'package:get/get.dart';

abstract class Onboardingconroller extends GetxController{
  next();
  onPageChanged(int index);
}

class onboardingContollerImp extends Onboardingconroller{
  MyServices myservices = Get.find();
  late PageController pageController;
  int curruentPage = 0;
  @override
  next() {
    curruentPage++ ;
    if(curruentPage == 3) {
      myservices.sharedpreferences.setString("step", '1');
      Get.offAllNamed(AppRoute.Login);
    }else{
      if(pageController.hasClients){
        pageController.animateToPage(curruentPage, duration: const Duration(milliseconds: 900), curve: Curves.fastOutSlowIn);
      }
      
    }
    
  }
  // change value currentPage variable until page changed
  @override
  onPageChanged(int index) {
    curruentPage = index;
    update();
  }

  //initialize the page controller object when page started
  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
  
}