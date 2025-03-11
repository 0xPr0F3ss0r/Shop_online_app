import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/ShowOrdersController.dart';
import 'package:live_app/view/orders/viewOrdersDetails.dart';

class Vieworderspage extends StatelessWidget {
  final Showorderscontroller controller = Get.put(Showorderscontroller());

  Vieworderspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View Orders",
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
          await controller.fetchUserOrders();
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(136, 45, 59, 220),
                Color.fromARGB(43, 40, 143, 232),
                Color.fromARGB(135, 220, 45, 220),
              ],
            ),
          ),
          child: GetBuilder<Showorderscontroller>(
            builder: (controller) {
              if (controller.orders.isEmpty) {
                return const Center(
                  child: Text(
                    "No orders found.",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(12.0),
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  final order = controller.orders[index];
                  final details = controller.orders[index];

                  return Card(
                    elevation: 5, // Add shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Get.to(
                          Viewordersdetails(),
                          arguments: {
                            "orders": order,
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Image and Order Number
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.greenAccent[100],
                                    child: CircleAvatar(
                                      backgroundImage: order['profile image'].isNotEmpty
                                          ? (order['profile image'].startsWith('http')
                                              ? NetworkImage(order['profile image']) as ImageProvider<Object>
                                              : (() {
                                                  final file = File(order['profile image']);
                                                  return file.existsSync()
                                                      ? FileImage(file) as ImageProvider<Object>
                                                      : const AssetImage("assets/images/error_image.jpg") as ImageProvider<Object>;
                                                })()
                                          )
                                          : const NetworkImage("https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg"),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Order #${index + 1}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Order Username
                            Text.rich(
                              TextSpan(
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                text: "Username: ",
                                children: [
                                  TextSpan(
                                    text: details['name of user'] ?? 'Username not found',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Order User Email
                            Text.rich(
                              TextSpan(
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                text: "Email: ",
                                children: [
                                  TextSpan(
                                    text: details['email user'] ?? "Email not found",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Order Shipping Address
                            Text.rich(
                              TextSpan(
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                text: "Shipping Address: ",
                                children: [
                                  TextSpan(
                                    text: order['shipping Address'] ?? "Address not found",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}