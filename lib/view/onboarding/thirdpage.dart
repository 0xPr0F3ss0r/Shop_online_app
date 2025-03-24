import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:live_app/controller/onboardingcontroller.dart';

class ThirdPage extends GetView<onboardingContollerImp> {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    String text = "Get the latest trends and exclusive\ncollections, build and organize your\n                 perfect closet";
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
                   child: Image(image: AssetImage("assets/onboarding/onboarding3.jpg")
                   )
                   ),
                   SizedBox(height: 40,),
                   Text("Stay Trendy And slay",style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize:30)),
                   SizedBox(height: 10,),
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
