import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/core/services/services.dart';

class ChosepageforsellerController extends GetxController {
  bool? valuetshirts = false;
  bool? valuejeans = false;
  bool? valuebasket = false;
  bool? valueaccessoir = false;
  MyServices services = Get.find();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String userId = FirebaseAuth.instance.currentUser!.uid;
  void oncheckBoxtchirts(bool? newValue) {
    valuetshirts = newValue;
    update();
  }

  void oncheckBoxjeans(bool? newValue) {
    valuejeans = newValue;
    update();
  }

  void oncheckboxbasket(bool? newvalue) {
    valuebasket = newvalue;
    update();
  }

  void oncheckBoxaccessoir(bool? newValue) {
    valueaccessoir = newValue;
    update();
  }

  void onclick() async {
    DocumentReference docRef = users.doc(userId);

    try {
      // Check if the document exists
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        // Update existing document
        await docRef.update({
          "type of products": {
            "jeans": valuejeans,
             "t-shirts": valuetshirts,
             "basket" : valuebasket,
             "accessoir": valueaccessoir,
             }
             
        });
        Get.snackbar("Success", "type of Products added successfully",
          colorText: Colors.blue);
          services.sharedpreferences.setString("step","3");
          Get.offAllNamed(AppRoute.navigation);
          
      } else {
        // Document does not exist, create a new one
        Get.snackbar("fails", "try again , no data found for this user", colorText: Colors.red);
      }
      // Show success message
      Get.snackbar("Success", "type of Products added successfully",
          colorText: Colors.blue);
      Get.back(); // Navigate back to the profile page
    } catch (e) {
      Get.snackbar("fail", "fails to add type of products $e",
          colorText: Colors.red);
    }
  }
}
