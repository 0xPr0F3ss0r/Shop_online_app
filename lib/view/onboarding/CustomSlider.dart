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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(8.0),
            child: SmoothPageIndicator(
              controller: controller.pageController,
              count: 3,
              effect: CustomizableEffect(
                activeDotDecoration: DotDecoration(
                  width: 32,
                  height: 12,
                  color: Colors.indigo,
                  rotationAngle: 180,
                  verticalOffset: -10,
                  borderRadius: BorderRadius.circular(24),
                ),
                dotDecoration: DotDecoration(
                  width: 24,
                  height: 12,
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                  verticalOffset: 0,
                ),
                spacing: 6.0,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: PageView(
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
        ),
      ],
    );
  }
}
