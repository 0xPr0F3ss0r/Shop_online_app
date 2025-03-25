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
        body: Container(
          height: 750,
          child: Column(
            children: [
              Expanded(
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
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: SmoothPageIndicator(
                        controller: controller.pageController,
                        count: 3,
                        effect: const WormEffect(
                          activeDotColor: Colors.brown,
                          spacing: 6.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 230),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(40)),
                        child: MaterialButton(
                            onPressed: () {
                              controller.next();
                            },
                            child: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
        );
  }
}
