import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/onboardingcontroller.dart';
import 'package:live_app/view/onboarding/firstpage.dart';
import 'package:live_app/view/onboarding/secondpage.dart';
import 'package:live_app/view/onboarding/thirdpage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageView extends GetView<onboardingContollerImp> {
  const CustomPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Container(
        height: 810,
        child: Column(
          children: [
          Expanded(
            child:  PageView(
                controller: controller.pageController,
                onPageChanged: (val) {
                  controller.onPageChanged(val);
                },
                children: const [
                  FirstPage(),
                  SecondPage(),
                  ThirdPage(),
                ],
              ),
              
            
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SmoothPageIndicator(
                controller: controller.pageController,
                count: 3,
                effect: WormEffect(
                  activeDotColor: Colors.brown,
                  // activeDotDecoration: DotDecoration(
                  //   width: 32,
                  //   height: 12,
                  //   color: Colors.indigo,
                  //   rotationAngle: 180,
                  //   verticalOffset: -10,
                  //   borderRadius: BorderRadius.circular(24),
                  // ),
                  // dotDecoration: DotDecoration(
                  //   width: 24,
                  //   height: 12,
                  //   color: Colors.grey,
                  //   borderRadius: BorderRadius.circular(16),
                  //   verticalOffset: 0,
                  // ),
                  spacing: 6.0,
                ),
              ),
          ),
        
        ),
        SizedBox(width:250),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height:50,
              width: 50,
              decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(40)),
              child: MaterialButton(
                          
                          onPressed: () {
                            controller.next();
                            // Add your button action here
                          },
                          child: Icon(Icons.arrow_forward_ios,color:Colors.white)),
                        ),
            ),
          ),
        
            ],
          )
           
        
        ],
        ),
      ) 
        // Padding(
        //   padding: const EdgeInsets.only(top: 50),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     padding: const EdgeInsets.all(8.0),
            // child: SmoothPageIndicator(
            //   controller: controller.pageController,
            //   count: 3,
            //   effect: CustomizableEffect(
            //     activeDotDecoration: DotDecoration(
            //       width: 32,
            //       height: 12,
            //       color: Colors.indigo,
            //       rotationAngle: 180,
            //       verticalOffset: -10,
            //       borderRadius: BorderRadius.circular(24),
            //     ),
            //     dotDecoration: DotDecoration(
            //       width: 24,
            //       height: 12,
            //       color: Colors.grey,
            //       borderRadius: BorderRadius.circular(16),
            //       verticalOffset: 0,
            //     ),
            //     spacing: 6.0,
            //   ),
            // ),
          //),
        //),
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 30),
        //     child: PageView(
        //       controller: controller.pageController,
        //       onPageChanged: (val) {
        //         controller.onPageChanged(val);
        //       },
        //       children: const [
        //         FirstPage(),
        //         SecondPage(),
        //         ThirdPage(),
        //       ],
        //     ),
        //   ),
        // ),
      //],
    );
  }
}
