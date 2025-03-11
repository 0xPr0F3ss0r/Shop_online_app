import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/profilepagecontroller.dart';

class Paypalcontroller extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ProfilePageController profileController = Get.put(ProfilePageController());
  List orderdetails = [];
  Map params = {};
  int detailsNumber = 0;
  void Getparams(
      Map myparams,
      String email,
      String productsize,
      String productcolor,
      String productimage,
      String shippingaddress,
      String profileImage) {
    params = myparams;
    addOrder(params, email, productcolor, productimage, shippingaddress,
        profileImage, productsize);
  }

  Future<void> addOrder(
  Map params,
  String email,
  String productcolor,
  String productimage,
  String shippingaddress,
  String profileImage,
  String productsize,
) async {
  // Initialize orderdetails locally
  List<Map<String, dynamic>> orderdetails = [];

  // Extract details from params
  Map<String, dynamic> details =
      params['data']['transactions'][0]['item_list']['items'][0];
  details.addAll({
    "Productcolor": productcolor,
    "Productimage": productimage,
    "Productsize": productsize,
  });

  // Add order details to the list
  orderdetails.add({
    "details": details,
    "shipping Address": shippingaddress,
    "profile image": profileImage,
    "name of user": profileController.nameProfilePage,
    "email user": profileController.emailText,
  });

  // Fetch the user document from Firestore
  QuerySnapshot querySnapshot = await _firestore
      .collection("users")
      .where("Email", isEqualTo: email)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    DocumentSnapshot userDoc = querySnapshot.docs.first;
    Map<String, dynamic> userInfo = userDoc.data() as Map<String, dynamic>;

    // Get the existing orderDetails or initialize an empty list
    List<dynamic> userdoc = userInfo['orderDetails'] ?? [];

    if (userdoc.isEmpty) {
      // If orderDetails is empty, set it to the new order
      await userDoc.reference.update({
        'orderDetails': orderdetails,
      });
    } else {
      // If orderDetails is not empty, append the new order
      await userDoc.reference.update({
        'orderDetails': FieldValue.arrayUnion(orderdetails),
      });
    }

    Get.snackbar("Success", "Order added successfully", colorText: Colors.blue);
  } else {
    Get.snackbar("Error", "There is no user with this email", colorText: Colors.red);
  }
}
}
