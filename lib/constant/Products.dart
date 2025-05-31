import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:live_app/controller/profilepagecontroller.dart';
import 'package:live_app/core/function/validator.dart';
import 'package:live_app/view/widget/TextFormField.dart';

// ignore: must_be_immutable
class Products extends StatelessWidget {
  final formKey10 = GlobalKey<FormState>();
  final formKey11 = GlobalKey<FormState>();
  final formkey12 = GlobalKey<FormState>();
  final formkey13 = GlobalKey<FormState>();
  RxBool is_loading = false.obs;
  ProfilePageController controller = Get.put(ProfilePageController());
  bool SavedProduct = false;
  Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 55,
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple, width: 3),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: GetBuilder<ProfilePageController>(
                                builder: (controller) {
                              return Center(
                                child: DropdownButton<String>(
                                  dropdownColor: Colors.black,
                                  style: const TextStyle(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  value: controller.productType,
                                  onChanged: (String? newvalue) {
                                    controller.changeValueDropDown(newvalue!);
                                  },
                                  underline: const SizedBox.shrink(),
                                  items: const [
                                    DropdownMenuItem(
                                        value: "T-Cheart",
                                        child: Text("T-Cheart")),
                                    DropdownMenuItem(
                                        value: "Jeans", child: Text("Jeans")),
                                    DropdownMenuItem(
                                        value: "basket", child: Text("basket")),
                                    DropdownMenuItem(
                                        value: "accessoir",
                                        child: Text("accessoir"))
                                  ],
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 2,
              child: Form(
                key: formKey10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormEmail(
                    validator: (val) => validate(val!, 3, 40, "productName"),
                    borderWidth: 3,
                    controller: controller.BrandName,
                    prefixIcon: null,
                    Prefixiconbutton: false,
                    Suffixiconbutton: false,
                    hint: "Brand",
                    hintcolor: Colors.white,
                    hintsize: 15,
                    maxLength: 15,
                    textAlign: TextAlign.center,
                    bordercolor: Colors.deepPurple,
                  ),
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
              child: controller.productImage != null &&
                      controller.productImage!.isNotEmpty
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              16), // Match container's radius
                          child: controller.productImage!.startsWith('http')
                              ? Image.network(
                                  controller.productImage!,
                                  fit: BoxFit.cover, // Prevents overflow
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : (() {
                                  final file = File(controller.productImage!);
                                  return file.existsSync()
                                      ? Image.file(
                                          file,
                                          fit:
                                              BoxFit.cover, // Prevents overflow
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
                                    color: Color.fromARGB(255, 28, 89, 180),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.pickImageFromGallery(
                                                "Product", context);
                                          },
                                          child: const Text("From Pictures"),
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () {
                                            controller
                                                .pickImageFromCamera(context);
                                          },
                                          child: const Text("From Camera"),
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.removePictureOfProduct();
                                          },
                                          child: const Text("Remove Picture"),
                                        ),
                                        const SizedBox(height: 20),
                                        InkWell(
                                          onTap: Get.back,
                                          child: const Text(
                                            "Close",
                                            style: TextStyle(color: Colors.red),
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
                              size: 24, // Increased size for better visibility
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
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.pickImageFromGallery(
                                                "Product", context);
                                          },
                                          child: const Text("From Pictures"),
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () {
                                            controller
                                                .pickImageFromCamera(context);
                                          },
                                          child: const Text("From Camera"),
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.removePictureOfProduct();
                                          },
                                          child: const Text("Remove Picture"),
                                        ),
                                        const SizedBox(height: 20),
                                        InkWell(
                                          onTap: Get.back,
                                          child: const Text(
                                            "Close",
                                            style: TextStyle(color: Colors.red),
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
                  controller: controller.BrandSize,
                  prefixIcon: null,
                  Prefixiconbutton: false,
                  Suffixiconbutton: false,
                  hint: "Brand Sizes",
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
                  controller: controller.BrandColor,
                  prefixIcon: null,
                  Prefixiconbutton: false,
                  Suffixiconbutton: false,
                  hint: "Brand Colors",
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
        const SizedBox(
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
                  controller: controller.BrandPrice,
                  prefixIcon: null,
                  Prefixiconbutton: false,
                  Suffixiconbutton: false,
                  hint: "Brand Price",
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
        const SizedBox(height: 10),
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
                  onPressed: () {
                    SavedProduct = true;
                    controller.isLoding
                        ? is_loading.value = true
                        : controller.UploadProductToFirestoreAndFirebase(
                            context);
                  },
                  child: GetBuilder<ProfilePageController>(
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
              icon: const Icon(Icons.delete, weight: 50),
              color: Colors.red,
            )
          ],
        ),
      ],
    );
  }
}
