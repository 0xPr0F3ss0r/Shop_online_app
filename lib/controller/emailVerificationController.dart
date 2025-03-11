import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:live_app/constant/route.dart';

class SendEmailVerificationController extends GetxController {
 Future<void> checkEmailVerified(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    bool signup = false;
    if (user != null) {
      await user.reload(); // Reload the user's data from Firebase
      if (user.emailVerified) {
        Get.snackbar(
          "Email Verified",
          "Your email has been successfully verified!",
          colorText: Colors.green,
        );
          Get.snackbar(
        "Success",
        "Sign up successful",
        duration: Duration(seconds: 20),
        colorText: Colors.blue,
      );
      signup= true;
       signup == true
          ? QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Sign up Completed Successfully!',
              autoCloseDuration: const Duration(seconds: 5),
              showConfirmBtn: false,
            )
          : QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'Sign up Failed!',
              autoCloseDuration: const Duration(seconds: 5),
              showConfirmBtn: false,
            );
        // You can navigate the user to the home page or allow further access
        Get.offAllNamed(AppRoute.Login); // Example: Navigate to home page
      } else {
        signup = false;
        Get.snackbar(
          "Email Not Verified",
          "Please check your inbox and verify your email.",
          colorText: Colors.red,
        );
      }
    }
  }
  @override
  void onInit() async {
    super.onInit();
    
  }
}
