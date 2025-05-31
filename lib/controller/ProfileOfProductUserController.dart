import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class profileOfProductUserController extends GetxController {
  late final String? email;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> UserData = [];
  RxString emailuser = ''.obs;
  Map<String, dynamic>? isFollowMap = {};
  RxBool isfollower = false.obs;
  Map<String, dynamic> isFollower = {};
  RxInt Followers = 0.obs;
  //String? EmailCurrentUser;

  void getEmail() async {
    emailuser.value = await getEmailOfCurrentUser();
    update();
  }

  Future<String> getEmailOfCurrentUser() async {
    String uid = user!.uid;
    final snapshot = await _firestore.collection("users").doc(uid).get();
    if (snapshot.exists) {
      DocumentSnapshot<Map<String, dynamic>> DataUser =
          await _firestore.collection('users').doc(uid).get();
      emailuser.value = DataUser['Email'];
      update();
      return emailuser.value;
    }
    return emailuser.value;
  }

  void isfollow() async {
    try {
      isFollowMap = {};
      emailuser.value = email!;
      final snapshot = await _firestore
          .collection("users")
          .where("Email", isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final UserData = doc.data() as Map<String, dynamic>;
        isFollowMap = UserData['isFollow'] as Map<String, dynamic>?;
        isFollowMap ??= {};
      } else {
        Get.snackbar("Error", "User not found , check and try again",
            colorText: Colors.red, duration: Duration(seconds: 2));
      }
    } catch (Exception) {
      Get.snackbar("Error", "$Exception",
          colorText: Colors.red, duration: Duration(seconds: 2));
    }
  }

  void checkFollower(String email) {
    fetchUserDataFromEmail(email);
  }

  Future<void> fetchUserDataFromEmail(String email) async {
    try {
      isFollowMap = {};
      final snapshot = await _firestore
          .collection("users")
          .where("Email", isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final UserData = doc.data();
        isFollowMap = UserData['isFollow'] as Map<String, dynamic>?;
        isFollowMap ??= {};
        if (isFollowMap != null) {
          if (isFollowMap!.containsKey(emailuser)) {
            if (email != emailuser) {
              isFollowMap![emailuser.value] = !isFollowMap![emailuser]!;
              isfollower.value = !isfollower.value;
              Followers.value = isFollowMap![emailuser]
                  ? Followers.value + 1
                  : Followers.value - 1;
              await doc.reference.update(
                  {"followers": Followers.value < 0 ? 0 : Followers.value});
              update();
            }
          } else {
            if (email != emailuser) {
              isFollowMap![emailuser.value] = true;
              isfollower.value = true;
              await doc.reference.update({"followers": Followers.value});
              update();
            }
          }
          if (email != emailuser) {
            await doc.reference.update({
              'isFollow': isFollowMap,
            });
            update();
          }
        } else {
          if (email != emailuser) {
            Map<String, dynamic> mymap = {emailuser.value: true};
            isFollowMap = mymap;
            update();
          }
        }
      } else {
        Get.snackbar("Error", "User not found , check and try again",
            colorText: Colors.red, duration: Duration(seconds: 2));
      }
    } catch (Exception) {
      Get.snackbar("Error", "$Exception",
          colorText: Colors.red, duration: Duration(seconds: 2));
    }
  }

  Future<void> GetNumberOfFollowers() async {
    final snapshot = await _firestore
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final UserData = doc.data();
      Followers.value = UserData['followers'] ?? 0;
      update();
    } else {
      Get.snackbar("Error", "User not found , check and try again",
          colorText: Colors.red, duration: Duration(seconds: 2));
    }
  }

  @override
  void onInit() async {
    email = Get.arguments['email'];
    getEmail();
    GetNumberOfFollowers();
    isfollow();
    super.onInit();
  }
}
