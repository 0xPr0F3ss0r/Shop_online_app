import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:live_app/controller/onboardingcontroller.dart';

class FirstPage extends GetView<onboardingContollerImp> {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    String text = "Seamless shopping experience from\n you favorite brands;access special\n       discounts and early sales";
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height:double.infinity,
          color:Colors.white,
          child:
          Column(
            children: [
              Column(
                children: [
                   ClipRRect(borderRadius: BorderRadius.circular(5),
                   child: const Image(image: AssetImage("assets/onboarding/onboarding1.jpg")
                   )
                   ),
                   const SizedBox(height: 40,),
                   const Text("Shop Effortlessly",style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize:30)),
                   const SizedBox(height: 10,),
                   Align(
                    alignment: Alignment.center,
                     child: Padding(
                       padding: const EdgeInsets.only(left: 20,right:10),
                       child: Text(text,),
                     ),
                   )
                   ]
                   )
            ],
          ) 
        ),
      
    );
  }
}
