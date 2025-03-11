import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/model/user_model.dart';
class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final _db =  FirebaseFirestore.instance;

  createUser(UserModel user,String uid) async{
    await _db.collection("users").doc(uid).set(user.toJson()).whenComplete(
      () =>     
       Get.snackbar("Success", "Your account has been created.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:Colors.green.withOpacity(0.1),
      colorText: Colors.green
      ),
    )
    .catchError((error, stackTrace){
      Get.snackbar("Error","Something went wrong . Try again",
      snackPosition:SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.red
      );
    });
  } 
 


Future<List<dynamic>> getUserProducts(String email) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .limit(1) 
        .get();

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> userData = snapshot.docs.first.data() as Map<String, dynamic>;

      List<dynamic> products = [];

      userData.forEach((key, value) {
        if (key.startsWith("product of user")) {
          products.add(value);
        }
      });


      return products;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

 Future<UserModel?> getUserDetails(String email) async {
  try {
    final snapshot = await _db.collection("users")
        .where("Email", isEqualTo: email)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return UserModel.fromSnapshot(snapshot.docs.first);
    } else {
      return null; 
    }
  } catch (e) {
    return null;
  }
}


Future<List<UserModel>> AllUser() async {
  final snapshot = await _db.collection("users").get();
  final UserData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  return UserData;
}
}

