import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/model/user_model.dart';
import 'package:live_app/users/user_repository.dart';
import 'package:live_app/view/login/send_email_verification.dart';

class Mycontroller extends GetxController {
  void Onsignup(BuildContext context) {
    // This method can be used for any additional logic needed for signup
  }

  void Ongooglelogin() {}
}

class MySignupController extends Mycontroller {
  bool signup = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final userRepo = Get.put(UserRepository());
  String? uid;
  void sendemailverification() async{
     User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null && !firebaseUser.emailVerified) {
        await firebaseUser.sendEmailVerification();
        Get.snackbar("Verification Email", "A verification email has been sent to ${email.text}",
            duration: Duration(seconds: 20), colorText: Colors.green);

        // Navigate to the email verification page
        Get.to(() => SendEmailVerification(), arguments: {
          'email': email.text, // Passing email as argument
        });
      }

  }
  @override
  void Onsignup(BuildContext context) async {
    // Check if email and password fields are not empty
    if (email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar("Error", "Email and Password cannot be empty",
          colorText: Colors.red, barBlur: 10.0);
      return;
    }

    try {
      // Firebase signup
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      signup = true;
      update();
      uid = FirebaseAuth.instance.currentUser!.uid;
      // Create user in your app's database
      String fullName = '${firstName.text.trim()} ${secondName.text.trim()}';
      final user = UserModel(
        email: email.text.trim(),
        fullName: fullName,
        firstName: firstName.text.trim(),
        secondName: secondName.text.trim(),
      );
      await createUser(user,uid);

    

     sendemailverification();
     
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Error", 'The password provided is too weak.',
            colorText: Colors.red, duration: Duration(seconds: 20));
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", 'The account already exists for that email.',
            colorText: Colors.red, duration: Duration(seconds: 20));
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred. Please try again.",
          colorText: Colors.red, duration: Duration(seconds: 20));
    }

    super.Onsignup(context);
  }

  Future<void> createUser(UserModel user, String? uid) async {
    await userRepo.createUser(user,uid!);
  }
}
