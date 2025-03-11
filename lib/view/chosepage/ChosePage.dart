import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_app/controller/chosepagecontroller.dart';
import 'package:live_app/core/services/services.dart';
import 'package:live_app/view/widget/button.dart';

// ignore: must_be_immutable
class Chosepage extends StatelessWidget {
  chosePageController controller = Get.put(chosePageController());
  MyServices services = Get.find();
  Chosepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Chose Who You Are",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            Button(onPressed: () {services.sharedpreferences.setString("type", "seller");controller.OnClickAsSeller();}, text: 'Im A Seller',),
            const SizedBox(height: 10),
            Button(onPressed: () {services.sharedpreferences.setString("type", "buyer");controller.OnClickAsBuyer();}, text: 'Im A Buyer',)
          ],
        ),
      ),
    );
  }
}