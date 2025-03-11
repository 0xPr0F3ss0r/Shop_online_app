import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/controller/logincontroller.dart';

class rsetpasswordcontroller extends GetxController {
  TextEditingController email = Get.put(TextEditingController());
  MyLoginController logincontroller = Get.put(MyLoginController());
  void showPasswordChangedDialog() {
    Get.defaultDialog(
      title: "Password Changed",
      middleText: "Your password has been changed successfully!",
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); // Close the dialog
      },
    );
  }

  resetPassword(BuildContext context) async {
    if (email.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        // Success: Show the snackbar after the email is sent
        // Get.snackbar(
        //   "Password Reset",
        //   "Password reset email has been sent!",
        //   borderColor: Colors.blue,
        //   snackPosition: SnackPosition.TOP,
        //   backgroundColor: Colors.blueAccent,
        //   colorText: Colors.white,
        //   duration: Duration(seconds: 4),

        // );
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Password reset email has been sent!',
          autoCloseDuration: const Duration(seconds: 5),
          confirmBtnText: "Login",
          onConfirmBtnTap: () => Get.toNamed(AppRoute.Login),
          showConfirmBtn: false,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "too-many-requests") {
          Get.snackbar(
            "reset password", "Too many requests.Please wait a few minutes and try again.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.blue,
            borderRadius: 22,
            duration: Duration(seconds:3),
            colorText: Colors.black
            );
        }
        String errorMessage;
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          default:
            errorMessage = 'Something went wrong. Please try again.';
            break;
        }

        // Error: Show the snackbar for errors
        Get.snackbar(
          "Error",
          errorMessage,
          snackPosition: SnackPosition.TOP,
          borderColor: Colors.red,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } else {
      // Empty email error
      Get.snackbar(
        "Error",
        "Please enter your email address",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void onclear() {
    email.clear();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }
}
