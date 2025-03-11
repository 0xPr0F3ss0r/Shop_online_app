import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Showorderscontroller extends GetxController{
   void onInit() async{
    super.onInit();// Fetch user data when the controller is initialized
    await fetchUserOrders();
  }
   List<Map<String, dynamic>> orders = [];
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final User? user = FirebaseAuth.instance.currentUser;
   Future<List<Map<String, dynamic>>> fetchUserOrders() async{
    try{
      String uid = user!.uid;
    // Fetch the user document
      final snapshot = await _firestore.collection("users").doc(uid).get();
      orders.clear();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        List<dynamic> userdoc =userData['orderDetails'] ?? [];
        for(int i = 0;i<userdoc.length;i++){
          orders.add(userdoc[i]);
        }
    }else{
      Get.snackbar("Error", "data doesn't exist!, try again later please");
    }
    update();
    return orders;
    }catch (e) {
    Get.snackbar("Error", "Error fetching orders: $e");
    return [];
  }
  }
}