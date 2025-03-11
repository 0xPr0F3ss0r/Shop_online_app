import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Viewproductscontroller extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Future<void> deleteProduct(String productNameUpdate,
      String productPriceUpdate, String productTypeUpdate,BuildContext context) async {
    bool isLoding = false;
    String uid = user!.uid;
    try {
      final DocumentReference userDoc =
          await _firestore.collection("users").doc(uid);
      final snapshot = await _firestore.collection("users").doc(uid).get();
      if (!snapshot.exists) {
        Get.snackbar("Error", "User not found , try again later",
            colorText: Colors.red);
      }
      Map<String, dynamic>? UserData = snapshot.data() as Map<String, dynamic>;
      UserData.forEach((key, value) async {
        if (key.startsWith("product of user") &&
            value is Map<String, dynamic>) {
          String? productName = value['productBrand'] ?? '';
          String? productPrice = value['productPrice'] ?? '';
          String? productType = value['productType'] ?? '';
          // String? productImage = value['productImage'] ?? '';
          if (productNameUpdate == productName &&
              productPriceUpdate == productPrice &&
              productTypeUpdate == productType) {
            isLoding = true;
            final updates = <String, dynamic>{
              key: FieldValue.delete(),
            };
            userDoc.update(updates);
            isLoding = false;
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: "Product deleted successfully!",
              title: 'Success',
              autoCloseDuration: const Duration(seconds: 5),
              showConfirmBtn: false,
            );
          }
        } else {
          Get.snackbar("Error", "no product found for this user.",
              colorText: Colors.red, backgroundColor: Colors.black);
        }
      });
    } catch (e) {
      Get.snackbar("Error", "please try again later.",
          colorText: Colors.red, backgroundColor: Colors.black);
    }
  }
}
