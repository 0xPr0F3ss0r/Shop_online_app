import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/logincontroller.dart';

class changepasswordcontroller extends GetxController{

  MyLoginController logincontroller = Get.put(MyLoginController());
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController retypeNewPassword = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  bool firstPasswordEqualsSecond = false;
  bool currentPasswordIsTrue = false;
  bool passwordUpdated = false;
   void updatePassword() async{
     try {
      // Reauthenticate the user using the current password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user?.email ?? "",
        password: currentPassword.text,
      );

      await user?.reauthenticateWithCredential(credential);
      currentPasswordIsTrue = true;

      // Check if new passwords match
      if (newPassword.text == retypeNewPassword.text) {
        firstPasswordEqualsSecond = true;
        // Update the password in Firebase
        await user?.updatePassword(newPassword.text);
        passwordUpdated = true;
        Get.snackbar("Success", "Password updated successfully!");
      } else {
        firstPasswordEqualsSecond = false;
        Get.snackbar("Error", "New passwords do not match!");
      }
    } catch (error) {
      currentPasswordIsTrue = false;
      Get.snackbar(
        "Error",
        "current password isn't correct",
        colorText: Colors.red,
        barBlur: 10.0,
        duration: Duration(seconds: 2)
      );
    }
  }
  void onclear() {
    currentPassword.clear();
    newPassword.clear();
    retypeNewPassword.clear();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    onclear();
    currentPassword.dispose();
    newPassword.dispose();
    retypeNewPassword.dispose();
    super.onClose();
  }
 }
   


  