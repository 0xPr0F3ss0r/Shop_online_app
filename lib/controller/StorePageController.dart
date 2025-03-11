import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/view/productinfo/productInfo.dart';

class Storepagecontroller extends GetxController {
  List<Map<String, dynamic>> UsersWithProducts = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void GoToProductPage(Map<String, dynamic>? data) {
    if (data != null && data.isNotEmpty) {
      try {
        Get.to(() => Productinfo(), arguments: data);
      } catch (e) {
        Get.snackbar("Error", "Error no data ,please try again!",colorText: Colors.red);
      }
    } else {
      Get.snackbar("Error", "Error no data ,please try again!",colorText: Colors.red);
    }
  }

  Future<List<Map<String, dynamic>>> fetchUsersWithProducts() async {
    try {
      final snapshot = await _firestore.collection("users").get();
      UsersWithProducts.clear(); // Clear the list before adding new data

      for (var doc in snapshot.docs) {
        Map<String, dynamic> userData = doc.data();

        String? username = userData['FullName'] ?? "";
        String? email = userData['Email'] ?? "unknown";
        String? profileimage = userData['avatar'] ?? "unknown";

        // Extract all products dynamically
        List<Map<String, dynamic>> products = [];
        userData.forEach((key, value) {
          if (key.startsWith("product of user") && value is Map<String, dynamic>) {
            products.add({
              "productImage": value["productImage"] ?? "",
              "productBrand": value["productBrand"] ?? "",
              "productType": value["productType"] ?? "",
              "productBrandSize": value["productBrandSize"] ?? "",
              "productPrice": value["productPrice"] ?? "",
              "productColor": value["productBrandColor"] ?? "",
            });
          }
        });
        // Add user and products to the list
        UsersWithProducts.add({
          "userName": username,
          "profileImage": profileimage,
          "email": email,
          "products": products,
        });
      }
      update(); // Notify listeners that the data has changed
      return UsersWithProducts;
    } catch (e) {
      Get.snackbar("error", "error please try again");
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchUsersWithProducts();
  }
}
