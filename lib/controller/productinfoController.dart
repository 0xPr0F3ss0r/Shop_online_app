import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:live_app/view/profile/profileOfProductUser.dart';

class Productinfocontroller extends GetxController {
  TextEditingController ShippingAddress = TextEditingController();
  String? Shippingaddress;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> UserWithProduct = {};
  RxInt quantity = 0.obs;
  RxInt index = 0.obs;
  String color = '';
  void selectedIndex(int myindex, String mycolor) {
    index.value = myindex;
    color = mycolor;
    update();
  }

  void decreasequantity() {
    if (quantity.value == 0) {
      quantity.value = 0;
    } else {
      quantity.value -= 1;
    }
  }

  void incresequantity() {
    quantity.value += 1;
  }

  void Onsave() {
    Shippingaddress = ShippingAddress.text;
    update();
    // Get.back();
  }

  @override
  void onClose() {
    quantity.value = 0;
    ShippingAddress.clear();
    Shippingaddress = null;
    super.onClose();
  }

  void GoToProfileProductInfo(String email) async {
    await fetchUserWithProducts(email);
    Get.to(profileOfProductUser(), arguments: UserWithProduct);
  }

  Future<Map<String, dynamic>?> fetchUserWithProducts(String? email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> UserData = await _firestore
          .collection("users")
          .where("Email", isEqualTo: email)
          .get();
      UserWithProduct.clear();
      if (UserData.docs.isNotEmpty) {
        final doc = UserData.docs.first;
        String USERNAME = doc['FullName'] ?? "";
        int followers = doc['followers'] ?? 0;
        String PHone = doc['Phone'] ?? '';
        String Website = doc['Website'] ?? '';
        String Location = doc['Location'] ?? '';
        String Firstname = doc['FirstName'] ?? '';
        String Lastname = doc['secondName'] ?? '';
        String Avatar = doc['avatar'] ?? '';
        List<Map<String, dynamic>> Products = [];
        doc.data().forEach((key, value) {
          if (key.startsWith("product of user") &&
              value is Map<String, dynamic>) {
            Products.add({
              "productImage": value["productImage"] ?? "",
              "productBrand": value["productBrand"] ?? "",
              "productType": value["productType"] ?? "",
              "productBrandSize": value["productBrandSize"] ?? "",
              "productPrice": value["productPrice"] ?? "",
            });
          }
        });
        UserWithProduct.addAll({
          "userName": USERNAME,
          "email": email,
          "followers": followers,
          "phone": PHone,
          "website": Website,
          "location": Location,
          "firstname": Firstname,
          "secondname": Lastname,
          "avatar": Avatar,
          "all products": Products,
        });
        update();
        return UserWithProduct;
      } else {
        Get.snackbar(
            "eror", "problem occurred with this user , please try again",
            colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar("eror", "try again later", colorText: Colors.red);
      ;
      return {};
    }
    return null;
  }
}
