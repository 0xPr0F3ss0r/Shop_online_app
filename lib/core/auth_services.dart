import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/core/services/services.dart';
import 'package:live_app/model/user_model.dart';
import 'package:live_app/users/user_repository.dart';

class AuthService extends GetxController {
  Map<String, dynamic>? MyuserData;

  //AccessToken? MyaccessToken;
  final _auth = FirebaseAuth.instance;
  final Rx<User?> firebaseUser = Rx<User?>(FirebaseAuth.instance.currentUser);
  var verificationId = ''.obs;
  bool checking = true;
  bool login = false;
  MyServices myservice = Get.put(MyServices());
  final auth = FirebaseAuth.instance;
  String? email;
  String? name;
  String? FirstName;
  String? SecondName;
  String? uid;
  final userRepo = Get.put(UserRepository());
  @override
  void onInit() {
    super.onInit();
    // Binding the firebaseUser stream to listen to auth changes
    firebaseUser.bindStream(FirebaseAuth.instance.userChanges());
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<void> checkEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload(); // Reload the user's data from Firebase
      if (user.emailVerified) {
        Get.snackbar("Success", "Successfully signed in with Google",
            colorText: Colors.blue, duration: Duration(seconds: 2));
        uid = FirebaseAuth.instance.currentUser!.uid;
        // Create user in your app's database
        final user = UserModel(
          email: email,
          fullName: name,
          firstName: FirstName,
          secondName: SecondName,
        );
        await createUser(user, uid);
        print("step before ${myservice.sharedpreferences.getString("step")}");
        myservice.sharedpreferences.setString("step", '2');
        print("step after ${myservice.sharedpreferences.getString("step")}");
        Get.offAllNamed(AppRoute.chosepage);
        print("here we go");
      } else {
        Get.snackbar(
          "Email Not Verified",
          "Please check your inbox and verify your email.",
          colorText: Colors.red,
        );
      }
    }
  }

  void OngoogleSignUpfunc() async {
    try {
      await GoogleSignIn().signOut(); // Force account chooser
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Get.back(); // Dismiss loading indicator
        Get.snackbar("Error", "Google Sign-In was cancelled",
            colorText: Colors.red, duration: Duration(seconds: 2));
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.back(); // Dismiss loading indicator
      email = googleUser.email;
      name = googleUser.displayName;

      // Split the full name into first and last names
      if (name != null) {
        List<String> nameParts = name!.split(' ');
        FirstName = nameParts.isNotEmpty ? nameParts[0] : '';
        SecondName = nameParts.length > 1
            ? nameParts.sublist(1).join(' ')
            : ''; // Join remaining parts as last name
        //uid = FirebaseAuth.instance.currentUser!.uid;
      }
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("Email", isEqualTo: email)
          .limit(1)
          .get();
      for (var doc in snapshot.docs) {
        print('user found ${doc.data()}');
      }
      if (snapshot.docs.isNotEmpty) {
        print("step before ${myservice.sharedpreferences.getString("step")}");
        myservice.sharedpreferences.setString("step", "5");
        myservice.sharedpreferences.setBool("user found", true);
        print("step after ${myservice.sharedpreferences.getString("step")}");
        print("go to navigation bar");
        //print(myservice.sharedpreferences.getString("step"));
        Get.offAllNamed(AppRoute.navigation);
        print("to navigation bar");
        update();
      } else {
        print("area unauthorized");
        update();
        checkEmailVerified();
      }
      print("get out the if statement");
    } catch (e) {
      print("error $e");
      Get.back(); // Dismiss loading on error
      // Get.snackbar("Error", "Error during Google Sign-In: ${e.toString()}",
      //     colorText: Colors.red, duration: Duration(seconds: 2));
    }
    print(myservice.sharedpreferences.getString("step"));
  }

  Future<bool> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      login = true;
      update();
      return true;
    } catch (e) {
      Get.snackbar("Error", "Email or Password incorrect",
          colorText: Colors.red, barBlur: 10.0);
      return false;
    }
  }

  Future<void> unlinkGoogleAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.unlink(GoogleAuthProvider.PROVIDER_ID);
        Get.snackbar("Success", "Successfully unlinked Google account",
            colorText: Colors.green, duration: Duration(seconds: 20));
      } else {
        Get.snackbar("Error", "No user is currently signed in",
            colorText: Colors.red, duration: Duration(seconds: 20));
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to unlink Google account: $e",
          colorText: Colors.red, duration: Duration(seconds: 20));
    }
  }

  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      ;
    } else {
      Get.snackbar("Error", "Error user is not verified or is not login!",
          colorText: Colors.red);
    }
  }

  Future<void> signout() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar("Error", "ERROR occurred, please try again",
          colorText: Colors.red, barBlur: 10.0);
    }
  }

  Future<void> createUser(UserModel user, String? uid) async {
    print("sure entered here");
    await userRepo.createUser(user, uid!);
  }
}
