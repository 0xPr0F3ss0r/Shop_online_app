import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/core/auth_services.dart';
import 'package:live_app/core/services/services.dart';
import 'package:live_app/users/user_repository.dart';

class Mycontroller extends GetxController {
  UserRepository userrepo = Get.put(UserRepository());
  void onlogin(BuildContext context) {}
  void Ongooglelogin() {}
  void clear() {}
}

class MyLoginController extends Mycontroller {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int logintime = 5;
  final auth = AuthService();
  MyServices myservices = Get.find();
  String? Email;
  Map<String, dynamic>? userdata;
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String? name;
  String? emailuser;
  String? uid;

  var type;
  void onstart() {
    userdata = auth.MyuserData;
    update();
  }

  // @override
  // void clear() {
  //   email.clear();
  //   password.clear();
  // }

  void getInformationUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      name = auth.name;
      emailuser = auth.email;
      update();

      // Check if user's email is verified
      //final emailVerified = user.emailVerified;

      // The user's ID, unique to the Firebase project. Do NOT use this value to
      // authenticate with your backend server, if you have one. Use
      // User.getIdToken() instead.
      uid = user.uid;
    }
  }

  Future<void> checkEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        Get.snackbar(
          "Email Verified",
          "Your email has been successfully verified!",
          colorText: Colors.green,
        );
        QuerySnapshot querySnapshot = await _firestore
            .collection("users")
            .where("Email", isEqualTo: Email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          String documentId = querySnapshot.docs.first.id;
          DocumentSnapshot documentSnapshot =
              await _firestore.collection('users').doc(documentId).get();

          if (documentSnapshot.exists) {
            try {
              // Cast documentSnapshot.data() to a Map
              var data = documentSnapshot.data() as Map<String, dynamic>?;

              if (data != null && data.containsKey('type of user')) {
                var type = data['type of user'];
                if (type == null || type.isEmpty) {
                  Get.snackbar("Success", "Login successfully",
                      colorText: Colors.blue);
                  myservices.sharedpreferences.setString("step", "2");
                  Get.offAllNamed(AppRoute.chosepage);
                } else {
                  Get.snackbar("Success", "Login successfully",
                      colorText: Colors.blue);
                  myservices.sharedpreferences.setString("step", "5");
                  Get.offAllNamed(AppRoute.navigation);
                }
              } else {
                Get.snackbar("Success", "Login successfully",
                    colorText: Colors.blue);
                myservices.sharedpreferences.setString("step", "2");
                Get.offAllNamed(AppRoute.chosepage);
              }
            } catch (e) {
              Get.snackbar("Error", "$e", colorText: Colors.red);
            }
          } else {
            Get.snackbar("fails", "ERROR login , please try again");
          }
        } else {
          Get.snackbar("Fails", "Error Login Try re-login again or register",
              colorText: Colors.red);
        }
      } else {
        Get.snackbar(
          "Email Not Verified",
          "Please check your inbox and verify your email.",
          colorText: Colors.red,
        );
      }
    }
  }

  @override
  void onlogin(BuildContext context) async {
    Email = email.text;
    update();

    if (email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar("Error", "Email and Password cannot be empty",
          colorText: Colors.red, barBlur: 10.0, duration: Duration(seconds: 2));
      return;
    }
    bool success =
        await auth.loginUserWithEmailAndPassword(email.text, password.text);
    if (success == true && logintime != 0) {
      checkEmailVerified();
      clear(); //
    } else {
      logintime == 0 ? logintime = 0 : logintime -= 1;
      update();
      if (logintime == 0) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Login failed",
          text: 'try after 4 minuter',
          autoCloseDuration: const Duration(seconds: 4),
          showConfirmBtn: false,
        );
        await Future.delayed(Duration(minutes: 4));
        logintime = 5;
        update();
      }

      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Login failed",
        text: '$logintime remaining',
        autoCloseDuration: const Duration(seconds: 3),
        showConfirmBtn: false,
      );
      await Get.snackbar(
          "Error", "Login failed , check your email or your password",
          colorText: Colors.red, duration: Duration(seconds: 2));
    }
    super.onlogin(context);
  }

  @override
  void Ongooglelogin() async {
    auth.OngoogleSignUpfunc();
    super.Ongooglelogin();
  }

  @override
  void onInit() async {
    await initialServices();
    super.onInit();
  }

  @override
  void onClose() {
    Future.delayed(Duration(seconds: 4));
    // Dispose controllers when not needed
    firstName.clear();
    secondName.clear();
    email.clear();
    password.clear();
    Email = null;
    update();
    super.clear();
  }
}
