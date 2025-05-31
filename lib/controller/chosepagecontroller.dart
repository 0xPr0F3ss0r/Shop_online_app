import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/core/services/services.dart';

class chosePageController extends GetxController {
  MyServices services = Get.find();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String userId = FirebaseAuth.instance.currentUser!.uid;
  OnClickAsSeller() async {
    DocumentReference docRef = users.doc(userId);
    try {
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Update existing document
        await docRef.update({"type of user": "seller"});
        Get.snackbar(
            "Welcome", "Welcome to shoponlineapp ,you are now a -SELLER- ",
            colorText: Colors.blue);
        services.sharedpreferences.setString("step", "4");
        Get.offAllNamed(AppRoute.chosepageforseller);
      } else {
        // Document does not exist, create a new one
        Get.snackbar("fails", "try again , no data found for this user",
            colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar("fail", "fails to login as -SELLER-  $e",
          colorText: Colors.red);
    }
  }

  OnClickAsBuyer() async {
    DocumentReference docRef = users.doc(userId);

    try {
      // docRef.
      // Check if the document exists
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Update existing document
        await docRef.update({"type of user": "buyer"});
        Get.snackbar(
            "Welcome", "Welcome to shoponlineapp ,you are now a -BUYER- ",
            colorText: Colors.blue);
        services.sharedpreferences.setString("step", "5");
        Get.offAllNamed(AppRoute.navigation);
      } else {
        // Document does not exist, create a new one
        Get.snackbar("fails", "try again, no data found for this user",
            colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar("fail", "fails to login as -SELLER-  $e",
          colorText: Colors.red);
    }
  }
}
