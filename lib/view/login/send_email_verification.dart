import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/emailVerificationController.dart';
import 'package:live_app/controller/singupcontroller.dart';

class SendEmailVerification extends StatelessWidget {
  final SendEmailVerificationController controller =
      Get.put(SendEmailVerificationController());
  final MySignupController signupController = Get.put(MySignupController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(245, 82, 82, 84),
              image: DecorationImage(
                image: AssetImage("assets/login/emailverif.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned(
            top: 100,
            right: 5,
                child: Center(
                  child: Text(
                    "confirme Your Email now",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              
            
          ),
          Positioned(
            top: 320,
            right: 4,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 150,
                  width: 349,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.blueAccent,
                        width: 2
                      )
                    ),
                  child: const Center(
                    child: Text(
                      "please cheak your email for\n confirmation mail,Click link in email \nto verification your account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 520,
            left: 50,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 38, 67, 213),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: MaterialButton(onPressed: () {
                  controller.checkEmailVerified(context);
                },child:Text("CHECK EMAIL VERIFIED",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                  ),),),
              )
            )),
          const Positioned(
            top: 620,
            left: 50,
            child: Center(
              child: Text("Didn't Get confirmation email?",textAlign: TextAlign.center,style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
                ),),
            )),
             Positioned(
            top: 670,
            left: 20,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 170, 170, 78),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: MaterialButton(onPressed: () {
                  signupController.sendemailverification();
                },child:Text("RESEND EMAIL CONFIRMATION",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                  ),),),
              )
            )),
        ],
      ),
    );
  }
}
