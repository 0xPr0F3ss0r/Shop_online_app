import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/searchpagecontroller.dart';
import 'package:live_app/view/widget/TextFormField.dart';

// ignore: must_be_immutable
class Searchpage extends StatelessWidget {
  Searchpage({super.key});
  final searchpagecontroller controller = Get.put(searchpagecontroller());
  List<Map<String, dynamic>> ListOFAllProductUser = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => controller.fetchUsersWithProducts(),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Search bar row
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: TextFormEmail(
                          hint: "Search for product type: ex Jeans, T-Shirt ..",
                          controller: controller.search,
                          prefixIcon: Icons.shopping_bag,
                          PrefixMycolor: Colors.blue,
                          suffixIcon: Icons.search,
                          SuffixMycolor: Colors.black,
                          Prefixiconbutton: false,
                          Suffixiconbutton: true,
                          sufixIconOfButton: Icons.search,
                          onChanged: (val) {
                            controller.onChanged(val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GetBuilder<searchpagecontroller>(
                    builder: (context) {
                      // Filter products based on search term
                      List AllProductsWithProfiles =
                          controller.UsersWithProducts.expand((user) {
                        return user['products'].map((product) {
                          return {
                            'userProduct': user['products'],
                            'productImage': product['productImage'],
                            'productType': product['productType'],
                            'profileImage': user['profileImage'],
                            'profileName': user['userName'],
                            'profileFirstName': user['FirstName'],
                            'profileEmail': user['email'],
                            'profilePhone': user['Phone'],
                            'Location': user['Location'],
                            'profileWebsite': user['Website'],
                            'profileFollowers': user['followers'],
                            'productBrand': product['productBrand'],
                            'productBrandSize': product['productBrandSize'],
                            'productColor': product['productColor'],
                            'productPrice': product['productPrice'],
                          };
                        }).toList();
                      }).toList();
                      // Apply search filter
                      if (controller.word!.isNotEmpty) {
                        AllProductsWithProfiles =
                            AllProductsWithProfiles.where((product) {
                          return product['productType']
                              .toString()
                              .toLowerCase()
                              .startsWith(controller.word!.toLowerCase());
                        }).toList();
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.0,
                          crossAxisSpacing: 12.0,
                          mainAxisExtent: 280,
                        ),
                        itemCount: AllProductsWithProfiles.length,
                        itemBuilder: (_, index) {
                          var product = AllProductsWithProfiles[index];
                          String imagePath = product['productImage'] ?? '';
                          String price = product['productPrice'] ?? '0';
                          return GestureDetector(
                            onTap: () {
                              if (controller.UsersWithProducts.isNotEmpty) {
                                try {
                                  controller.GoToProductPage({
                                    "email": AllProductsWithProfiles[index]
                                            ['profileEmail'] ??
                                        'N/A',
                                    "profile image":
                                        AllProductsWithProfiles[index]
                                                ['profileImage'] ??
                                            'N/A',
                                    "profile name":
                                        AllProductsWithProfiles[index]
                                                ['profileName'] ??
                                            'N/A',
                                    "active since":
                                        AllProductsWithProfiles[index]
                                                ['active since'] ??
                                            'N/A',
                                    "followers": AllProductsWithProfiles[index]
                                            ['profileFollowers'] ??
                                        'N/A',
                                    'phone': AllProductsWithProfiles[index]
                                            ['profilePhone'] ??
                                        'N/A',
                                    "website": AllProductsWithProfiles[index]
                                            ['profileWebsite'] ??
                                        'N/A',
                                    "location": AllProductsWithProfiles[index]
                                            ['Location'] ??
                                        'N/A',
                                    "productsBrand":
                                        product['productBrand'] ?? 'N/A',
                                    "productSize":
                                        product['productBrandSize'] ?? 'N/A',
                                    "productPrice":
                                        product['productPrice'] ?? 'N/A',
                                    "productColor":
                                        product['productColor'] ?? 'N/A',
                                    "productType":
                                        product['productType'] ?? 'N/A',
                                    "productImage":
                                        product['productImage'] ?? 'N/A',
                                    "products": product ?? 'N/A',
                                    "all products":
                                        AllProductsWithProfiles[index]
                                                ['userProduct'] ??
                                            'N/A',
                                  });
                                } catch (Exception) {
                                  Get.snackbar(
                                      "Error", "please try again later.",
                                      colorText: Colors.red,
                                      backgroundColor: Colors.black);
                                }
                              } else {
                                Get.snackbar("Error", "no data found.",
                                    colorText: Colors.red,
                                    backgroundColor: Colors.black);
                              }
                            },
                            child: FutureBuilder<bool>(
                              future: File(imagePath).exists(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (imagePath.startsWith("http")) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 5),
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Image.network(
                                                    imagePath,
                                                    fit: BoxFit.fitHeight,
                                                    height: 200,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            right: 90,
                                            child: Text(
                                              "\$\ $price",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            right: 5,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.green,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.greenAccent[100],
                                                child: CircleAvatar(
                                                  backgroundImage: AllProductsWithProfiles[
                                                                  index]
                                                              ['profileImage']
                                                          .isNotEmpty
                                                      ? (AllProductsWithProfiles[
                                                                      index][
                                                                  'profileImage']
                                                              .startsWith(
                                                                  'http')
                                                          ? NetworkImage(
                                                                  AllProductsWithProfiles[
                                                                          index]
                                                                      [
                                                                      'profileImage'])
                                                              as ImageProvider<
                                                                  Object>
                                                          : (() {
                                                              final file = File(
                                                                  AllProductsWithProfiles[
                                                                          index]
                                                                      [
                                                                      'profileImage']);
                                                              return file
                                                                      .existsSync()
                                                                  ? FileImage(
                                                                          file)
                                                                      as ImageProvider<
                                                                          Object>
                                                                  : const AssetImage(
                                                                          "assets/images/error_image.jpg")
                                                                      as ImageProvider<
                                                                          Object>;
                                                            })())
                                                      : const NetworkImage(
                                                          "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 10,
                                              right: 95,
                                              child: Text(
                                                product['productBrand'],
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (snapshot.data == true) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 5),
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Image.file(
                                            File(imagePath),
                                            fit: BoxFit.fitHeight,
                                            height: 250,
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            right: 30,
                                            child: Text(
                                              "Price: $price",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Image.network(
                                    "https://i.pinimg.com/736x/c1/ed/c2/c1edc2adb3139877d11bc2da32e7eb85.jpg",
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
