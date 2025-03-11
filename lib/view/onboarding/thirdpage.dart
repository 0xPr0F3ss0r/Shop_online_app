import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:live_app/controller/onboardingcontroller.dart';

class ThirdPage extends GetView<onboardingContollerImp> {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color:Color.fromARGB(255, 35, 94, 220),
          child:
              Stack(
                children:[
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(245, 82, 82, 84),
                      image: DecorationImage(
                        image: AssetImage("assets/onboarding/onb3.PNG"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                bottom: 120, // Position the button 50 pixels from the bottom
                left: 0,
                right: 5,
                child: Center(
                  child: OutlinedButton(
                    style: ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(200,50))),
                    onPressed: () {
                      controller.next();
                      // Add your button action here
                    },
                    child: Text('Get Started',style: TextStyle(fontSize: 40,color:Colors.deepPurple),),
                  ),
                ),
              ),
                ] 
              ),
              
              
            
        ),
      
    );
  }
}
