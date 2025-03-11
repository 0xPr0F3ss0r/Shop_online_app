import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/EditProductController.dart';
import 'package:live_app/controller/profilepagecontroller.dart';
import 'package:live_app/controller/viewProductsController.dart';
import 'package:live_app/view/profile/EditProductsPage.dart';

class Vviewproductspage extends StatelessWidget {
  final ProfilePageController controller = Get.put(ProfilePageController());
  final Viewproductscontroller viewproductscontroller = Get.put(Viewproductscontroller());
  final EditProductController editProductController = Get.put(EditProductController());
  Vviewproductspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark background for contrast
      appBar: AppBar(
        title: const Text(
          "View Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent, // Vibrant app bar color
        elevation: 10, // Add shadow
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchUserProducts();
        },
        child: GetBuilder<ProfilePageController>(
          builder: (controller) {
            if (controller.products.isEmpty) {
              return const Center(
                child: Text(
                  "No products found.",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  crossAxisSpacing: 12.0, // Spacing between columns
                  mainAxisSpacing: 12.0, // Spacing between rows
                  childAspectRatio: 0.75, // Adjust card aspect ratio
                ),
                itemCount: controller.products.length,
                itemBuilder: (_, index) {
                  final product = controller.products[index];
                  final imagePath = product['productImage'] ?? '';
                  final price = product['productPrice'] ?? '0';
                  final brand = product['productBrand'] ?? 'No Brand';

                  return Card(
                    elevation: 5, // Add shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        // Navigate to product details page
                        Get.to( UpdateProducts(),arguments: {
                          "email": product['profileEmail'] ?? 'N/A',
                          "profile image": product['profileImage'] ?? 'N/A',
                          "profile name": product['profileName'] ?? 'N/A',
                          "active since": product['active since'] ?? 'N/A',
                          "followers": product['profileFollowers'] ?? 'N/A',
                          'phone': product['profilePhone'] ?? 'N/A',
                          "website": product['profileWebsite'] ?? 'N/A',
                          "location": product['Location'] ?? 'N/A',
                          "productsBrand": product['productBrand'] ?? 'N/A',
                          "productSize": product['productBrandSize'] ?? 'N/A',
                          "productPrice": product['productPrice'] ?? 'N/A',
                          "productColor": product['productColor'] ?? 'N/A',
                          "productType": product['productType'] ?? 'N/A',
                          "productImage": product['productImage'] ?? 'N/A',
                          "products": product ?? 'N/A',
                          "all products": product['userProduct'] ?? 'N/A',
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: FutureBuilder<bool>(
                                future: File(imagePath).exists(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (imagePath.startsWith("http")) {
                                    return Image.network(
                                      imagePath,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.network(
                                          "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg", // Placeholder image
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    );
                                  } else if (snapshot.data == true) {
                                    return Image.file(
                                      File(imagePath),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    );
                                  } else {
                                    return Image.network(
                                      "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg", // Placeholder image
                                      fit: BoxFit.cover,
                                      width: 200,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          // Product Details
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  brand,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "\$$price",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Edit and Delete Buttons
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    Map<String, dynamic> products = {
                                      'product type': product['productType'],
                                      'product Brand': product['productBrand'],
                                      'product size': product['productBrandSize'],
                                      'product Image': product['productImage'],
                                      'product color': product['productColor'],
                                      "product Price": product['productPrice'],
                                    };
                                    Get.to(UpdateProducts(), arguments: products);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    viewproductscontroller.deleteProduct(
                                      product['productBrand'],
                                      product['productPrice'],
                                      product['productType'],
                                      context,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}