import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/profilepagecontroller.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Viewproductscontroller extends GetxController {
  bool isLoding = false;
  final ProfilePageController controller = Get.put(ProfilePageController());
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() async {
    await controller.fetchUserProducts();
    super.onInit();
  }

  Future<void> deleteProduct(
      BuildContext context, String productIDUpdate) async {
    if (user == null) {
      Get.snackbar("Error", "User not logged in.");
      return;
    }

    isLoding = true;
    update();

    try {
      final userDoc =
          FirebaseFirestore.instance.collection("users").doc(user!.uid);
      final snapshot = await userDoc.get();

      // 1. Verify document exists
      if (!snapshot.exists) {
        Get.snackbar("Error", "User document not found");
        return;
      }

      //  Get data
      final userData = snapshot.data() as Map<String, dynamic>;

      // Check if product_of_user exists (EXACT field name match)
      if (!userData.containsKey('product_of_user ')) {
        Get.snackbar("Error", "User has no products collection");
        return;
      }

      // 3. Verify the product exists
      final productOfUser =
          userData['product_of_user '] as Map<String, dynamic>;
      if (!productOfUser.containsKey(productIDUpdate)) {
        Get.snackbar("Error", "Product not found");
        return;
      }

      // 4. Perform delete (using EXACT field name)
      String field = "product_of_user ";
      await userDoc.update({'$field.$productIDUpdate': FieldValue.delete()});
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Product deleted successfully!',
      );
      controller.Products = controller.Products - 1;
      update();
    } catch (e) {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Something wrong happened. Please try again!',
      );
    } finally {
      isLoding = false;
      update();
    }
  }
}
