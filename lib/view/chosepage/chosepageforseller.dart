import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/chosepageforseller.dart';
import 'package:live_app/view/widget/button.dart';

class Chosepageforseller extends StatelessWidget {
  final ChosepageforsellerController controller =
      Get.put(ChosepageforsellerController());
  Chosepageforseller({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: GetBuilder<ChosepageforsellerController>(
            builder: (controller)=>
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Chose Type of Products Do You Have:",
                    style: TextStyle(
                      color: Color.fromARGB(255, 128, 10, 247),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30),
                    Text("T-Cheart",style: TextStyle(color: Colors.blue),),
                    SizedBox(width: 5),
                    Checkbox(
                        value: controller.valuetshirts,
                        tristate: true,
                        onChanged: (bool? newValue) =>
                            controller.oncheckBoxtchirts(newValue)),
                            SizedBox(width: 5),
                             Text("Jeans",style: TextStyle(color: Colors.blue)),
                             SizedBox(width: 20),
                    Checkbox(
                        value: controller.valuejeans,
                        tristate: true,
                        onChanged: (bool? newValue) =>
                            controller.oncheckBoxjeans(newValue)),
            
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30),
                    Text("basket",style: TextStyle(color: Colors.blue)),
                    SizedBox(width: 20),
                    Checkbox(
                        value: controller.valuebasket,
                        tristate: true,
                        onChanged: (bool? newValue) =>
                            controller.oncheckboxbasket(newValue)),
                            SizedBox(width: 5),
                             Text("accessoir",style: TextStyle(color: Colors.blue)),
                    Checkbox(
                        value: controller.valueaccessoir,
                        tristate: true,
                        onChanged: (bool? newValue) =>
                            controller.oncheckBoxaccessoir(newValue)),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: Button(onPressed: () { controller.onclick(); }, text: 'Continue',))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
