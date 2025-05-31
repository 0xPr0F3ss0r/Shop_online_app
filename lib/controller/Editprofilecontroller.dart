import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:live_app/controller/profilepagecontroller.dart';

class EditProfilePageController extends GetxController {
  final ProfilePageController controller = Get.find<ProfilePageController>();
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController location = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void onInit() {
    super.onInit();
    // Initialize fields with current values from ProfilePageController
    name.text = controller.nameProfilePage ?? '';
    firstName.text = controller.firstname ?? '';
    secondName.text = controller.secondName ?? '';
    phone.text = controller.phone ?? '';
    website.text = controller.website ?? '';
    location.text = controller.location ?? '';
  }

  Future<void> updateProfile(BuildContext context) async {
    String first = firstName.text.trim();
    String second = secondName.text.trim();
    String myname = name.text.trim();
    String userId =
        FirebaseAuth.instance.currentUser!.uid; // Get the current user's uid

    if (!GetUtils.isUsername(first) || !GetUtils.isUsername(second)) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Invalid username", "Please enter valid usernames.',
        autoCloseDuration: const Duration(seconds: 5),
        showConfirmBtn: false,
      );
      Get.snackbar("Invalid username", "Please enter valid usernames.",
          colorText: Colors.red);
      return;
    }

    DocumentReference docRef = users.doc(userId);

    try {
      // Check if the document exists
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Update existing document
        await docRef.update({
          'FirstName': first,
          'secondName': second,
          'FullName': myname,
          'Phone': phone.text,
          'Website': website.text,
          'Location': location.text,
        });
      } else {
        // Document does not exist, create a new one
        await docRef.set({
          'FirstName': first,
          'secondName': second,
          'FullName': myname,
          'Phone': phone.text,
          'Website': website.text,
          'Location': location.text,
        });
      }
      // Update email in FirebaseAuth
      await FirebaseAuth.instance.currentUser!
          .updateEmail(controller.emailText!);

      // Update the local controller values
      controller.firstname = first;
      controller.secondName = second;
      controller.nameProfilePage = myname;
      controller.phone = phone.text;
      controller.website = website.text;
      controller.location = location.text;

      // Show success message
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Success, Profile updated successfully.',
        autoCloseDuration: const Duration(seconds: 5),
      );
      //Get.snackbar("Success", "Profile updated successfully.", colorText: Colors.green);
      Get.back(); // Navigate back to the profile page
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Error, Failed to update profile: ${e.toString()}',
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }
}
