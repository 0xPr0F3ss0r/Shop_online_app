import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/controller/resetpasswordcontroller.dart';
import 'package:live_app/core/function/validator.dart';
import 'package:live_app/view/widget/TextFormField.dart';

// ignore: must_be_immutable
class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  rsetpasswordcontroller controller = Get.put(rsetpasswordcontroller());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child:  SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key:formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        IconButton(onPressed: () {
                          Get.toNamed(AppRoute.Login);
                          controller.onclear();
                        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please enter your email account to send the link \nverification to reset your password",
                        style: TextStyle(color: Colors.white30, fontSize: 15),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                TextFormEmail(
                  validator: (val) => validate(val!, 7, 40, "email"),
                  prefixIcon: Icons.email_outlined,
                  hint: "Email",
                  hintcolor: Color.fromARGB(255, 117, 163, 243),
                  controller: controller.email,
                  Prefixiconbutton: false,
                  Suffixiconbutton: false,
                ),
                SizedBox(height: 360),
                Container(
                  width: 400,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 38, 67, 213),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: MaterialButton(onPressed: () {
                      controller.resetPassword(context);
                    },child:Text("RESET PASSWORD",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                      ),),),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
