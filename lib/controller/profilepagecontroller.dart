import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/core/auth_services.dart';
import 'package:live_app/model/user_model.dart';
import 'package:live_app/users/user_repository.dart';

class ProfilePageController extends GetxController {
  TextEditingController BrandName = TextEditingController();
  TextEditingController BrandSize = TextEditingController();
  TextEditingController BrandColor = TextEditingController();
  TextEditingController BrandPrice = TextEditingController();


 
  int? followers;
  String? downloadUrl;
  String? downloadUrlProduct;
  String? nameProfilePage = '';
  String? firstname = '';
  String? secondName = '';
  String? emailText = '';
  String? phone = '';
  String? website = '';
  String? location = '';
  String? Image;
  String? productImage = '';
  String? productBrand = '';
  String? productPrice = '';
  String productType = "T-Cheart";
  String? productBrandSize = '';
  String? productBrandColor = '';
  String? type;
 

  int Products = 1;
  bool isLoding = false;
  File? selectedImageForProduct;
  XFile? myimage;
  int first = 1;
  int ProductsNumber= 0;
  String avatarDefault =
      "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg";
  final AuthService _authRepo = Get.put(AuthService());
  final UserRepository _userRepo = Get.put(UserRepository());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> products = [];
  @override
  void onInit() async{
    super.onInit();
    await fetchUserData(); // Fetch user data when the controller is initialized
    await fetchUserProducts();
    //fetchProductDetails();
  }

  void onclear() {
    // Dispose controllers when not needed
    BrandName.clear();
    BrandSize.clear();
    BrandColor.clear();
    productImage = '';
    productType = "T-Cheart";
    update();
  }
  
 
  //fetchUserProducts
  Future<List<Map<String, dynamic>>> fetchUserProducts() async {
    
  try {
    String uid = user!.uid;
    // Fetch the user document
    final snapshot = await _firestore.collection("users").doc(uid).get();

    // Clear the list before adding new data
    products.clear();

    // Check if the document exists
    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      // Iterate over the user data to find product-related fields
      userData.forEach((key, value) {
        if (key.startsWith("product of user") && value is Map<String, dynamic>) {
          products.add({
            "productImage": value["productImage"] ?? "",
            "productBrand": value["productBrand"] ?? "",
            "productType": value["productType"] ?? "",
            "productBrandSize": value["productBrandSize"] ?? "",
            "productPrice": value["productPrice"] ?? "",
            "productColor":  value["productBrandColor"] ?? "",
          });
        }
      });
    }
    update(); // Notify listeners that the data has changed
    return products;
  } catch (e) {
    Get.snackbar("Error", "Error fetching users with products: $e");
    return [];
  }
}
//   Future<void> DeleteProductFromFirebase() async {
//   try {
//     String UID = user!.uid; // Get current user's UID
//     DocumentReference<Map<String, dynamic>> docRef = _firestore.collection("users").doc(UID);
    
//     // Use dot notation to delete the entire map for a specific product
//     final updates = <String, dynamic>{
//       "product of user ${Products-1}": FieldValue.delete(),
//     };
//     await docRef.update(updates);
//     Get.snackbar("Success", "Products deleted successfully",
//           colorText: Colors.blue);
//     Products = Products==1 ? Products:Products-1 ;
//   } catch (e) {
//     Get.snackbar("Error", "No information found for this email.",
//           snackPosition: SnackPosition.BOTTOM);
//   }
// }

 // ignore: non_constant_identifier_names
 Future<void> UploadProductToFirestoreAndFirebase(BuildContext context)async{
  await uploadProductImageTofirebase(context);
  await uploadProductTofirebase(context);
 }
  Future<void> uploadProductTofirebase(BuildContext context) async {
    productBrand = BrandName.text;
    productBrandSize = BrandSize.text;
    productBrandColor = BrandColor.text;
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .where("Email", isEqualTo: emailText)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      isLoding = true;
      update();
      String UID = user!.uid;
      // Update the user's document in Firestore with the new avatar URL
      await _firestore.collection('users').doc(UID).update({
        "product of user ${Products}": {
          "productImage": productImage,
          "productBrand": productBrand,
          "productType": productType,
          "productBrandSize": productBrandSize,
          "productBrandColor": productBrandColor,
          "first":first,
          "productPrice": productPrice
        }
      });
      
      isLoding = false;
      update();
      Get.snackbar("Success", "Products added successfully",
          colorText: Colors.blue);
      Products += 1;
      first +=1;
    } else {
      Get.snackbar("Error", "No information found for this email.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void changeValueDropDown(String value) {
    productType = value;
    update();
  }

  Future<void> fetchUserData() async {
    Image = null;
    Image = avatarDefault;
    productImage = null;
    final userData = await getUserData();
    if (userData != null) {
      updateUserData(userData);
      await fetchselectedImage(userData.email!);
    }
    update(); // Notify the UI to refresh
  }

  void updateUserData(UserModel userData) {
    nameProfilePage = userData.fullName ?? 'No Name';
    firstname = userData.firstName ?? 'No Name';
    secondName = userData.secondName ?? 'No Name';
    emailText = userData.email ?? 'No Email';
    phone = userData.phone ?? 'No Phone';
    website = userData.website ?? 'No Website';
    location = userData.location ?? 'No Location';
    Image = userData.avatar ?? avatarDefault;
    type = userData.type ?? '';
  }

  void updateUserProduct(UserModel userData) {
    productImage = userData.productImage ?? '';
    productBrand = userData.productBrand ?? '';
    productBrandSize = userData.productSize ?? '';
    productType = userData.productType ?? '';
    productBrandColor = userData.productBrandColor ?? '';
    productPrice  = userData.prouctPrice ?? '';
  }


  Future<void> fetchselectedImage(String email) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String UID = user!.uid;
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(UID).get();

      if (documentSnapshot.exists) {
        Image = documentSnapshot['avatar'] ?? avatarDefault;
      }
    }
  }

  Future<UserModel?> getUserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      try {
        final userDetails = await _userRepo.getUserDetails(email);
        if (userDetails != null) {
          return userDetails;
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to fetch user data: $e");
      }
    } else {
      Get.snackbar("Error", "Login to continue");
    }
    return null;
  }

  Future<List<dynamic>?> getUserProduct() async {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      try {
        final userDetails = await _userRepo.getUserProducts(email);
        if (userDetails.isNotEmpty) {
          return userDetails;
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to fetch user product: $e");
      }
    } else {
      Get.snackbar("Error", "Login to continue");
    }
    return null;
  }

  Future<void> pickImageFromGallery(String type, BuildContext context) async {
    type == "profile"
        ? await _pickImage(ImageSource.gallery, context)
        : _pickImageForProduct(ImageSource.gallery, context);
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    await _pickImage(ImageSource.camera, context);
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    Image = returnImage.path;
    await uploadImageToStorageAndFirestore(context);
    Get.back();
  }

  Future<void> _pickImageForProduct(
      ImageSource source, BuildContext context) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    productImage = returnImage.path;
    Get.back();
  }
  Future<void> uploadImageToStorageAndFirestore(BuildContext context) async {
    if (Image == null) {
      Get.snackbar("Error", "No image selected.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          "profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg");
      try {
        TaskSnapshot snapshot = await storageRef.putFile(File(Image!));
        downloadUrl = await snapshot.ref.getDownloadURL();
      } catch (e) {
        Get.snackbar("Error", "Error uploading image ,please try again!",colorText: Colors.red);
      }

      Image = downloadUrl; // Assign the download URL to selectedImage
      await updateUserAvatarInFirestore();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: "Image uploaded successfully!",
        title: 'Success',
        autoCloseDuration: const Duration(seconds: 5),
        showConfirmBtn: false,
      );
    } catch (e) {
      Get.snackbar("Error", "Error uploading image ,please try again!",colorText: Colors.red);
    }
  }
  Future<void> uploadProductImageTofirebase(BuildContext context)async {
    if (productImage == null) {
      Get.snackbar("Error", "No image selected.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          "product_pictures/{$Products/${FirebaseAuth.instance.currentUser!.uid}.jpg");
      TaskSnapshot snapshot = await storageRef.putFile(File(productImage!));
      downloadUrl = await snapshot.ref.getDownloadURL();
      productImage = downloadUrl;
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: "Product Image uploaded successfully!",
        title: 'Success',
        autoCloseDuration: const Duration(seconds: 5),
        showConfirmBtn: false,
      );
    } catch (e) {
      Get.snackbar("Error", "Error uploading image ,please try again!",colorText: Colors.red);
    }
  }
  

  Future<void> updateUserAvatarInFirestore() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .where("Email", isEqualTo: emailText)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String UID = user!.uid;

      // Update the user's document in Firestore with the new avatar URL
      await _firestore
          .collection('users')
          .doc(UID)
          .update({'avatar': Image}); // Save download URL to Firestore
    } else {
      Get.snackbar("Error", "No information found for this email.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> removePictureOfProduct() async {
    if (productImage == null) {
      Get.snackbar("Error", "there is no image to remove!",colorText: Colors.red);
      return;
    }
    productImage = null;
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .where("Email", isEqualTo: emailText)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String UID = user!.uid;
      // Update the user's document in Firestore with the new avatar URL
      await _firestore.collection('users').doc(UID).update({
        'product of user ${Products}': {'Product Image': null}
      }); // Save download URL to Firestore
      update();
    } else {
      Get.snackbar("Error", "No information found for this user.",
          snackPosition: SnackPosition.TOP,colorText: Colors.red);
    }
    update();
  }

  Future<void> removePicture() async {
    if (Image == null) {
      Get.snackbar("Error", "there is no image to remove!",colorText: Colors.red);
      return; 
    }
    Image = null;
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .where("Email", isEqualTo: emailText)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String UID = user!.uid;
      // Update the user's document in Firestore with the new avatar URL
      await _firestore.collection('users').doc(UID).update({'avatar': null});
      update(); // Save download URL to Firestore
    } else {
      Get.snackbar("Error", "No information found for this email.",
          snackPosition: SnackPosition.BOTTOM);
      try {
        Reference storageRef = FirebaseStorage.instance.refFromURL(Image!);
        storageRef.delete();
      } catch (e) {
        Get.snackbar("Error", "can't remove image ,please try again!",colorText: Colors.red);
      }
    }
    update();
  }

  Future<void> signOut() async {
    Image = avatarDefault;
    Image = null;
    await FirebaseAuth.instance.signOut();
    Get.toNamed(AppRoute.Login);
  }
}
