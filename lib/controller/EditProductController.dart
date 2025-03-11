import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
//import 'package:path/path.dart' as path;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'dart:math';
Random random = new Random();
class EditProductController extends GetxController {
  String? downloadUrl;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  TextEditingController BrandNameUpdate = TextEditingController();
  TextEditingController BrandSizeUpdate = TextEditingController();
  TextEditingController BrandColorUpdate = TextEditingController();
  TextEditingController BrandPriceUpdate = TextEditingController();
  String? productPriceUpdate = '';
  String productTypeUpdate = "T-Cheart";
  String? productImageUpdate = '';
  String? productColorUpdate = '';
  String? productNameUpdate = '';
  String? productSizeUpdate = '';
  String? newproductImage = '';
  bool isLoding = false;
  Future<void> UpdateProductToFirestoreAndFirebase(BuildContext context) async {
    await UpdateProductTofirebase(context);
  }

  @override
  void onClose() {
    BrandNameUpdate.clear();
    BrandSizeUpdate.clear();
    BrandColorUpdate.clear();
    BrandPriceUpdate.clear();
    productTypeUpdate = "T-Cheart";
    productImageUpdate = '';
    update();
    super.onClose();
  }

  @override
  void onInit() {
    productImageUpdate = '';
    productColorUpdate = '';
    productNameUpdate = '';
    productSizeUpdate = '';
    productPriceUpdate = '';
    super.onInit();
  }

  void changeValueDropDown(String value) {
    productTypeUpdate = value;
    update();
  }

  void getValues(String productName, String productPrice, String productSize,
      String productType, String productImage, String productColor) {
    productNameUpdate = productName;
    productPriceUpdate = productPrice;
    productSizeUpdate = productSize;
    productTypeUpdate = productType;
    productImageUpdate = productImage;
    productColorUpdate = productColor;
  }

  void onclear() {
    // Dispose controllers when not needed
    BrandNameUpdate.clear();
    BrandSizeUpdate.clear();
    BrandColorUpdate.clear();
    productImageUpdate = '';
    productTypeUpdate = "T-Cheart";
    update();
  }

  Future<void> pickImageFromGallery(String type, BuildContext context) async {
    _pickImageForProduct(ImageSource.gallery, context);
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    await _pickImage(ImageSource.camera, context);
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    productImageUpdate = returnImage.path;
    await UpdateProductImageToFirebaseStorage(context);
    Get.back();
  }

  Future<void> _pickImageForProduct(
      ImageSource source, BuildContext context) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    productImageUpdate = returnImage.path;
    await UpdateProductImageToFirebaseStorage(context);
    Get.back();
  }

  Future<void> UpdateProductImageToFirebaseStorage(BuildContext context) async {
    if (productImageUpdate == null) {
      Get.snackbar("Error", "No image selected.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      
      final String productID = Uuid().v4();

  // Get the current user's ID
      final String userID = FirebaseAuth.instance.currentUser!.uid;

  // Define the storage reference with an organized file path
      final Reference storageRef = FirebaseStorage.instance.ref().child(
      "users/$userID/products/product_$productID.jpg");
      TaskSnapshot snapshot =
          await storageRef.putFile(File(productImageUpdate!));
      downloadUrl = await snapshot.ref.getDownloadURL();
      newproductImage = downloadUrl;
      update();
    } catch (e) {
      Get.snackbar("Error", "Failed to update product.",
          colorText: Colors.red, backgroundColor: Colors.black);
    }
  }

  Future<void> UpdateProductTofirebase(context) async {
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
          String? productType = value['productType'] ?? '';
          if (
              productTypeUpdate == productType) {
            productColorUpdate = BrandColorUpdate.text;
            productNameUpdate = BrandNameUpdate.text;
            productSizeUpdate = BrandSizeUpdate.text;
            productPriceUpdate = BrandPriceUpdate.text;
            isLoding = true;
            await UpdateProductImageToFirebaseStorage(context);
            await userDoc.update({
              '$key.productBrand': productNameUpdate,
              '$key.productImage': newproductImage,
              '$key.productPrice': productPriceUpdate,
              '$key.productType': productTypeUpdate,
              '$key.productBrandColor': productColorUpdate,
              '$key.productBrandSize': productSizeUpdate,
            });
            isLoding = false;
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: "Product uploaded successfully!",
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
