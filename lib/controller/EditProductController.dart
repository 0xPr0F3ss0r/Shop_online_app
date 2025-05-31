import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class EditProductController extends GetxController {
  final User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Text Controllers
  final TextEditingController BrandNameUpdate = TextEditingController();
  final TextEditingController BrandSizeUpdate = TextEditingController();
  final TextEditingController BrandColorUpdate = TextEditingController();
  final TextEditingController BrandPriceUpdate = TextEditingController();

  String? productPriceUpdate = '';
  String productTypeUpdate = "T-Cheart";
  String? productImageUpdate = '';
  String? productColorUpdate = '';
  String? productNameUpdate = '';
  String? productSizeUpdate = '';
  String? newproductImage = '';
  String? ProductTypeUpdate = "";
  String? ProductImageUpdate = "";
  String? productIDUpdate = "";
  bool isLoding = false;
  String? downloadUrl;

  void onclear() {
    // Dispose controllers when not needed
    BrandNameUpdate.clear();
    BrandSizeUpdate.clear();
    BrandColorUpdate.clear();
    productImageUpdate = '';
    productTypeUpdate = "T-Cheart";
    update();
  }

  void changeValueDropDown(String value) {
    productTypeUpdate =
        value; // Make sure this is declared as a variable in your controller
    update(); // Triggers UI rebuild
  }

  @override
  void onClose() {
    BrandNameUpdate.dispose();
    BrandSizeUpdate.dispose();
    BrandColorUpdate.dispose();
    BrandPriceUpdate.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    resetFields();
  }

  void resetFields() {
    productImageUpdate = null;
    productColorUpdate = null;
    productNameUpdate = null;
    productSizeUpdate = null;
    productPriceUpdate = null;
    productTypeUpdate = "T-Cheart";
  }

  void setProductDetails(
      {required String name,
      required String price,
      required String size,
      required String type,
      required String image,
      required String color,
      required String productID}) {
    productNameUpdate = name;
    productPriceUpdate = price;
    productSizeUpdate = size;
    productTypeUpdate = type;
    productImageUpdate = image;
    productColorUpdate = color;
    productIDUpdate = productID;
    update();
  }

  Future<void> pickImage(ImageSource source, BuildContext context) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        productImageUpdate = pickedFile.path;
        await uploadImageToFirebase(context);
        update();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: ${e.toString()}");
    }
  }

  Future<void> uploadImageToFirebase(BuildContext context) async {
    if (productImageUpdate == null) {
      Get.snackbar("Error", "No image selected.",
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          "product_pictures/{$productIDUpdate/${FirebaseAuth.instance.currentUser!.uid}.jpg");
      TaskSnapshot snapshot =
          await storageRef.putFile(File(productImageUpdate!));
      downloadUrl = await snapshot.ref.getDownloadURL();
      print("downloaded url is $downloadUrl");
    } catch (e) {
      Get.snackbar("Error", "Error uploading image ,please try again!",
          colorText: Colors.red);
    }
  }

  Future<void> updateProduct(BuildContext context) async {
    if (user == null) {
      Get.snackbar("Error", "User not logged in.");
      return;
    }

    isLoding = true;
    update();

    try {
      final userDoc =
          FirebaseFirestore.instance.collection("users").doc(user!.uid);
      final snapshot = await userDoc.get();

      // 1. Verify document exists
      if (!snapshot.exists) {
        Get.snackbar("Error", "User document not found");
        return;
      }

      // 2. Get data and verify structure
      final userData = snapshot.data() as Map<String, dynamic>;

      // Check if product_of_user exists (EXACT field name match)
      if (!userData.containsKey('product_of_user ')) {
        Get.snackbar("Error", "User has no products collection");
        return;
      }

      // 3. Verify the product exists
      final productOfUser =
          userData['product_of_user '] as Map<String, dynamic>;
      if (!productOfUser.containsKey(productIDUpdate)) {
        Get.snackbar("Error", "Product not found");
        return;
      }
      print("before $downloadUrl");
      // 4. Perform update (using EXACT field name)
      String field = "product_of_user ";
      await userDoc.update({
        '$field.$productIDUpdate': {
          // ← Consistent field name
          'productBrand': BrandNameUpdate.text.isEmpty
              ? productNameUpdate
              : BrandNameUpdate.text,
          'productImage':
              downloadUrl!.isEmpty ? productImageUpdate : downloadUrl,
          'productPrice': BrandPriceUpdate.text.isEmpty
              ? productPriceUpdate
              : BrandPriceUpdate.text,
          'productType': productTypeUpdate,
          'productBrandColor': BrandColorUpdate.text.isEmpty
              ? productColorUpdate
              : BrandColorUpdate.text,
          'productBrandSize': BrandSizeUpdate.text.isEmpty
              ? productSizeUpdate
              : BrandSizeUpdate.text,
        }
      });
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Product updated successfully!',
      );
    } catch (e) {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Something wrong happened. Please try again!',
      );
    } finally {
      isLoding = false;
      update();
    }
  }
}
