// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/widgets.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService{
  late SharedPreferences sharedpreferences;
  // instance of shared preferences
  Future<MyServices> init() async{
    print("My services has been initialazed");
    //await Firebase.initializeApp();
    sharedpreferences = await SharedPreferences.getInstance();
    return this;
  }
}
// inject shared preferences when function called
initialServices() async{
 await Get.putAsync(() => MyServices().init());
}