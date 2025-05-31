import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:live_app/view/LiveStreamPage/LiveStreamPage.dart';
import 'package:live_app/view/profile/profileOfProductUser.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/controller/profilepagecontroller.dart';
import 'package:live_app/core/auth_services.dart';
import 'package:live_app/core/services/services.dart';
import 'package:live_app/model/user_model.dart';
import 'package:live_app/users/user_repository.dart';
import 'dart:math';

class HomeController extends GetxController {
  Map<String, dynamic>? followersOfUser = {};
  Map<String, dynamic>? isFollowMap = {};
  RxBool isfollower = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxInt Followers = 0.obs;
  MyServices services = Get.find();
  final _authRepo = Get.put(AuthService());
  final _userRepo = Get.put(UserRepository());
  ProfilePageController profilePagecontroller =
      Get.put(ProfilePageController());
  ProfilePageController profileController = Get.put(ProfilePageController());
  final User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> ListLiveStream = [];
  String? avaterpicture =
      "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg";
  String? firstname = 'name not found';
  String? secondname = 'name not found';
  String? nameProfilePage = 'No Name';
  String? emailText = 'No Email';
  String? phone = 'No Phone';
  String? website = 'No Website';
  String? location = 'No Location';
  String? uid = '';
  String? email = '';
  String? username = '';
  String? emailCurrentUser = '';
  RxBool isLive = false.obs;
  RxString Liveid = ''.obs;
  RxBool isHost = false.obs;
  String randomId = '';
  List followers = [];
  Map<String, dynamic> UserWithProduct = {};
  List<Map<String, dynamic>> UsersWithProducts = [];
  String generateRandomString(int length) {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(
      List.generate(
          length, (index) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  Future<void> updateUserLiveStatus(
      String uid, String liveid, bool isLive, bool isHost) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).update(
          {"isLive": isLive, "Liveid": randomId, "isHost": isHost, "uid": uid});
    } catch (e) {
      Get.snackbar("Live Status", "Error start Live,try again later please",
          colorText: Colors.red, borderColor: Colors.white);
    }
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
          if (key.startsWith("product of user ") &&
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
        Get.snackbar("error", "user not found,try again later",
            colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar("error", "try again later", colorText: Colors.red);
      return {};
    }
    return null;
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
        int followers = userData['followers'] ?? 0;
        String? phone = userData['Phone'] ?? "unknown";
        String? website = userData['Website'] ?? "unknown";
        String? location = userData['Location'] ?? "unknown";
        // Extract all products dynamically
        List<Map<String, dynamic>> products = [];
        userData.forEach((key, value) {
          if (key.startsWith("product of user ") &&
              value is Map<String, dynamic>) {
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
          }
        });
        // Add user and products to the list
        UsersWithProducts.add({
          "userName": username,
          "profileImage": profileimage,
          "email": email,
          "followers": followers,
          "phone": phone,
          "website": website,
          "location": location,
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

  void GoToProfileProductInfo(Map<String, dynamic>? data) {
    Get.to(() => profileOfProductUser(), arguments: data);
  }

  void startLiveStream() {
    randomId = '';
    randomId = generateRandomString(10);
    isLive.value = true;
    Liveid.value = randomId;
    isHost.value = true;
    uid = user!.uid;
    username = nameProfilePage ?? 'UNKNOWN';
    Get.to(Livestreampage(
        liveID: Liveid.value,
        isHost: isHost.value,
        userID: uid ?? '11111',
        userName: username!));
    update();
  }

  void joinLiveStream(String liveID) {
    // Ensure the liveID is valid and the stream exists
    if (liveID.isNotEmpty) {
      Get.to(Livestreampage(
        liveID: liveID,
        isHost: false,
        userID: uid ?? '1111',
        userName: nameProfilePage ?? 'Unknown',
      ));
    } else {
      Get.snackbar("Error", "Live not found , check and try again",
          colorText: Colors.red, duration: Duration(seconds: 2));
    }
  }

  void stopLiveStream() {
    isLive.value = false;
    Liveid.value = randomId;
    isHost.value = false;
    uid = user!.uid;
    updateUserLiveStatus(
        uid ?? '1111', Liveid.value, isLive.value, isHost.value);
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    final userdataa = await getUserData();
    if (userdataa != null) {
    } else {}
    fetchUserData();
    fetchUsersWithProducts();
    listenToLiveUpdates();
    fetchLiveStream();
    emailCurrentUser = profileController.emailText;
    checkLiveFollower();
    GetNumberOfFollowers();
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
          if (isFollowMap!.containsKey(emailCurrentUser)) {
            if (email != emailCurrentUser) {
              isFollowMap![emailCurrentUser!] =
                  !isFollowMap![emailCurrentUser]!;
              isfollower.value = !isfollower.value;
              Followers.value = isFollowMap![emailCurrentUser]
                  ? Followers.value + 1
                  : Followers.value - 1;
              await doc.reference.update({"followers": Followers.value});
              update();
            }
          } else {
            if (email != emailCurrentUser) {
              isFollowMap![emailCurrentUser!] = true;
              isfollower.value = true;
              await doc.reference.update({"followers": Followers.value});
              update();
            }
          }
          if (email != emailCurrentUser) {
            await doc.reference.update({
              'isFollow': isFollowMap,
            });
            update();
          }
        } else {
          if (email != emailCurrentUser) {
            Map<String, dynamic> mymap = {emailCurrentUser!: true};
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
    int length = ListLiveStream.length;
    for (int i = 0; i < length; i++) {
      Map<String, dynamic> userFollowers = {
        ListLiveStream[i]['Email']: ListLiveStream[i]['followers']
      };
      followers.add(userFollowers);
      update();
    }
  }

  Future<void> getEmailOfCurrentUser() async {
    String uid = user!.uid;
    final snapshot = await _firestore.collection("users").doc(uid).get();
    if (snapshot.exists) {
      DocumentSnapshot<Map<String, dynamic>> DataUser =
          await _firestore.collection('users').doc(uid).get();
      emailCurrentUser = DataUser['Email'];
    }
  }

  void checkLiveFollower() {
    if (ListLiveStream.isNotEmpty) {
      for (var user in ListLiveStream) {
        Map<String, dynamic> followersMAP = user['isFollow'];
        followersMAP.forEach((key, value) {
          if (key == emailCurrentUser) {
            followersOfUser![key] = value;
          }
        });
      }
    }
  }

  Future<void> fetchLiveStream() async {
    ListLiveStream.clear();
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("users")
          .where("isLive", isEqualTo: true)
          .get();
      for (var doc in snapshot.docs) {
        ListLiveStream.add(doc.data());
      }
    } catch (e) {
      Get.snackbar("Error", "Error ,try again $e",
          colorText: Colors.red, borderColor: Colors.white);
    }
  }

  Future<void> fetchUserData() async {
    final userData = await getUserData();
    if (userData != null) {
      nameProfilePage = userData.fullName ?? 'No Name';
      firstname = userData.firstName ?? 'No Name';
      secondname = userData.secondName ?? 'No Name';
      emailText = userData.email ?? 'No Email';
      phone = userData.phone ?? 'No Phone';
      website = userData.website ?? 'No Website';
      location = userData.location ?? 'No Location';
      isLive.value = userData.isLive ?? false;
      Liveid.value = userData.liveID ?? '';
      uid = user!.uid;

      // Fetch the user's avatar URL
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("Email", isEqualTo: userData.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String documentId = querySnapshot.docs.first.id;
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .get();

        if (documentSnapshot.exists) {
          avaterpicture = documentSnapshot['avatar'] ?? '';
        } else {
          Get.snackbar("Error",
              "data of this user doesn't exist , please try again later",
              colorText: Colors.red);
        }
      } else {
        Get.snackbar("Error", "no matching data for this email",
            colorText: Colors.red);
      }
    } else {
      Get.snackbar("Error", "no data found , try again later",
          colorText: Colors.red);
    }
    update();
  }

  //Listen to Live Stream Updates in Firestore
  void listenToLiveUpdates() {
    if (user == null) return;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        Liveid.value = snapshot.get('Liveid') ?? '';
        isLive.value = Liveid.value.isNotEmpty;
      }
    });
  }

  Future<UserModel?> getUserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      try {
        final userDetails = await _userRepo.getUserDetails(email);
        return userDetails;
      } catch (e) {
        Get.snackbar("Error", "Failed to fetch user data: $e");
        return null;
      }
    } else {
      Get.snackbar("Error", "Login to continue");
      return null;
    }
  }

  void onExit(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      text: 'You want to sign out?',
      showCancelBtn: true,
      showConfirmBtn: true,
      onConfirmBtnTap: () async {
        await _authRepo.signout();
        await FirebaseAuth.instance.signOut();
        Get.toNamed(AppRoute.Login);
        Get.snackbar(
          "Alert Account",
          "You have been signed out",
          duration: Duration(seconds: 20),
          colorText: Colors.red,
        );
        services.sharedpreferences.setString("step", "1");
        Get.offAllNamed(AppRoute.Login);
      },
    );
  }
}
