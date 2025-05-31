import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/view/productinfo/productInfo.dart';

class searchpagecontroller extends GetxController {
  List<Map<String, dynamic>> UsersWithProducts = [];
  TextEditingController search = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? word = '';

  void onChanged(var value) {
    word = value;
    update();
  }

  void GoToProductPage(Map<String, dynamic>? data) {
    if (data != null && data.isNotEmpty) {
      try {
        Get.to(() => Productinfo(), arguments: data);
      } catch (e) {
        Get.snackbar("Error", "server is busy , please try again later.",
            colorText: Colors.red, backgroundColor: Colors.black);
      }
    } else {
      Get.snackbar("Error", "no data found , please try again later.",
          colorText: Colors.red, backgroundColor: Colors.black);
    }
  }

  Future<List<Map<String, dynamic>>> fetchUsersWithProducts() async {
    try {
      final snapshot = await _firestore.collection("users").get();
      // Clear the list before adding new data
      UsersWithProducts.clear();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> userData = doc.data();

        String username = userData['FullName'] ?? "";
        String email = userData['Email'] ?? "unknown";
        String profileimage = userData['avatar'] ?? "unknown";

        // Extract all products dynamically
        List<Map<String, dynamic>> products = [];
        userData.forEach((key, value) {
          if (key.startsWith("product_of_user ")) {
            Map<String, dynamic> myvalue = value as Map<String, dynamic>;
            myvalue.forEach((key_product, value_product) {
              products.add({
                "productImage": value_product["productImage"] ?? "",
                "productBrand": value_product["productBrand"] ?? "",
                "productType": value_product["productType"] ?? "",
                "productBrandSize": value_product["productBrandSize"] ?? "",
                "productPrice": value_product["productPrice"] ?? "",
                "productColor": value_product["productBrandColor"] ?? "",
                "productID": key_product,
              });
            });
          } else {
            Get.snackbar("error", "product not found ,try again later");
          }
        });
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
      Get.snackbar("Error", "Error fetching users with products: $e");
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchUsersWithProducts();
  }
}
