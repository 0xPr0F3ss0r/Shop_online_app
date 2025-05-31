import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_app/controller/EditProductController.dart';
import 'package:live_app/core/function/validator.dart';
import 'package:live_app/view/widget/TextFormField.dart';

// ignore: must_be_immutable
class UpdateProducts extends StatelessWidget {
  String productType = '';
  String productBrand = '';
  String productSize = '';
  String productImage = '';
  String productColor = '';
  String productPrice = '';
  String productID = '';
  EditProductController controller = Get.put(EditProductController());
  final formKey10 = GlobalKey<FormState>();
  final formKey11 = GlobalKey<FormState>();
  final formkey12 = GlobalKey<FormState>();
  final formkey13 = GlobalKey<FormState>();
  bool SavedProduct = false;
  //final int ProductsNumber;
  UpdateProducts();

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments;
    productType = product['product type'] ?? 'no type';
    productBrand = product['product Brand'] ?? 'no brand';
    productSize = product['product size'] ?? 'no size';
    productImage = product['product Image'] ?? 'no image';
    productColor = product['product color'] ?? 'no color';
    productPrice = product['product Price'] ?? "no price";
    productID = product['productID'].toString().isEmpty
        ? 'no id'
        : product['productID'].toString();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Edit Product"),
        backgroundColor: Colors.deepPurpleAccent[400],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<EditProductController>(
            builder: (controller) => Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 140,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.deepPurple, width: 3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Center(
                                          child: Text(productType,
                                              style: TextStyle(
                                                  color: Colors.blue)))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 2,
                      child: Form(
                        key: formKey10,
                        child: TextFormEmail(
                          validator: (val) => validate(val!, 3, 40, "username"),
                          borderWidth: 3,
                          controller: controller.BrandNameUpdate,
                          prefixIcon: null,
                          Prefixiconbutton: false,
                          Suffixiconbutton: false,
                          hint: productBrand,
                          hintcolor: Colors.white,
                          hintsize: 15,
                          maxLength: 15,
                          textAlign: TextAlign.center,
                          bordercolor: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.deepPurple, width: 4),
                      ),
                      child: productImage.isNotEmpty
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      16), // Match container's radius
                                  child: productImage.startsWith('http')
                                      ? Image.network(
                                          productImage,
                                          fit:
                                              BoxFit.cover, // Prevents overflow
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : (() {
                                          final file = File(productImage);
                                          return file.existsSync()
                                              ? Image.file(
                                                  file,
                                                  fit: BoxFit
                                                      .cover, // Prevents overflow
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                )
                                              : Image.asset(
                                                  'assets/images/error_image.jpg',
                                                  fit: BoxFit
                                                      .cover, // Ensures proper scaling
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                );
                                        })(),
                                ),
                                Positioned(
                                  bottom: 10, // Adjust positioning
                                  left: 10, // Adjust positioning
                                  child: IconButton(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        Container(
                                          height: 300,
                                          width: 500,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 28, 89, 180),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              children: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.pickImage(
                                                        ImageSource.gallery,
                                                        context);
                                                  },
                                                  child: const Text(
                                                      "From Pictures"),
                                                ),
                                                const SizedBox(height: 10),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.pickImage(
                                                        ImageSource.camera,
                                                        context);
                                                  },
                                                  child:
                                                      const Text("From Camera"),
                                                ),
                                                const SizedBox(height: 20),
                                                InkWell(
                                                  onTap: Get.back,
                                                  child: const Text(
                                                    "Close",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.blue,
                                      size:
                                          24, // Increased size for better visibility
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "IMAGE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        Container(
                                          height: 300,
                                          width: 500,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 28, 89, 180),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              children: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.pickImage(
                                                        ImageSource.gallery,
                                                        context);
                                                  },
                                                  child: const Text(
                                                      "From Pictures"),
                                                ),
                                                const SizedBox(height: 10),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.pickImage(
                                                        ImageSource.camera,
                                                        context);
                                                  },
                                                  child:
                                                      const Text("From Camera"),
                                                ),
                                                const SizedBox(height: 20),
                                                InkWell(
                                                  onTap: Get.back,
                                                  child: const Text(
                                                    "Close",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("Choose"),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: Form(
                        key: formKey11,
                        child: TextFormEmail(
                          validator: (val) => validate(val!, 1, 999, ''),
                          borderWidth: 3,
                          controller: controller.BrandSizeUpdate,
                          prefixIcon: null,
                          Prefixiconbutton: false,
                          Suffixiconbutton: false,
                          hint: productSize,
                          hintcolor: Colors.white,
                          hintsize: 15,
                          maxLength: 500,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          bordercolor: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Form(
                        key: formkey12,
                        child: TextFormEmail(
                          validator: (val) => validate(val!, 1, 999, ''),
                          borderWidth: 3,
                          controller: controller.BrandColorUpdate,
                          prefixIcon: null,
                          Prefixiconbutton: false,
                          Suffixiconbutton: false,
                          hint: productColor,
                          hintcolor: Colors.white,
                          hintsize: 15,
                          maxLength: 500,
                          textAlign: TextAlign.center,
                          bordercolor: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Form(
                        key: formkey13,
                        child: TextFormEmail(
                          validator: (val) => validate(val!, 1, 999, ''),
                          borderWidth: 3,
                          controller: controller.BrandPriceUpdate,
                          prefixIcon: null,
                          Prefixiconbutton: false,
                          Suffixiconbutton: false,
                          hint: productPrice,
                          hintcolor: Colors.white,
                          hintsize: 12,
                          maxLength: 500,
                          textAlign: TextAlign.center,
                          bordercolor: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.white,
                            )),
                        width: 240,
                        child: MaterialButton(
                          onPressed: () async {
                            controller.setProductDetails(
                                name: productBrand,
                                price: productPrice,
                                size: productSize,
                                type: productType,
                                image: productImage,
                                color: productColor,
                                productID: productID);
                            await controller.updateProduct(context);

                            //controller.SavedProduct.value = true; // Update like this
                          },
                          child: GetBuilder<EditProductController>(
                            builder: (controller) => controller.isLoding
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    IconButton(
                      onPressed: () {
                        controller.onclear();
                      },
                      icon: Icon(Icons.delete, weight: 50),
                      color: Colors.red,
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
