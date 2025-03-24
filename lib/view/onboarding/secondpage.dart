import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:live_app/controller/onboardingcontroller.dart';

class SecondPage extends GetView<onboardingContollerImp> {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    String text = "                Personalized fashion\nrecommendations just for you, daily\n           style tips and outfit ideas";
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
                   child: const Image(image: AssetImage("assets/onboarding/onboarding2.jpg")
                   )
                   ),
                   const SizedBox(height: 40,),
                   const Text("Discover Your Style",style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize:30)),
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
