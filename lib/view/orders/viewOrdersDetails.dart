import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Viewordersdetails extends StatelessWidget {
  Viewordersdetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Map orders = Get.arguments;
    final Map<dynamic, dynamic> ordersDetails = orders['orders']['details'];
    final Map<String, dynamic> userInfo = orders['orders'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent, // Vibrant app bar color
        elevation: 10, // Add shadow
      ),
      body: Container(
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  ordersDetails['Productimage'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/placeholder.jpg", // Placeholder image
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Order Details Card
              Card(
                elevation: 5, // Add shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          text: "Product Name: ",
                          children: [
                            TextSpan(
                              text: ordersDetails['name'] ?? 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Quantity
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          text: "Quantity: ",
                          children: [
                            TextSpan(
                              text: ordersDetails['quantity'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Price
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          text: "Price: ",
                          children: [
                            TextSpan(
                              text: "\$${ordersDetails['price']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Currency
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          text: "Currency: ",
                          children: [
                            TextSpan(
                              text: ordersDetails['currency'] ?? 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Tax
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          text: "Tax: ",
                          children: [
                            TextSpan(
                              text: "\$${ordersDetails['tax']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Product Color
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          text: "Product Color: ",
                          children: [
                            TextSpan(
                              text: ordersDetails['Productcolor'] ?? 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Product Size
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          text: "Product Size: ",
                          children: [
                            TextSpan(
                              text: ordersDetails['Productsize'] ?? 'N/A',
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
              const SizedBox(height: 20),
              // User Info Card
              Card(
                elevation: 5, // Add shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Name
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          text: "User Name: ",
                          children: [
                            TextSpan(
                              text: userInfo['name of user'] ?? 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // User Email
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          text: "User Email: ",
                          children: [
                            TextSpan(
                              text: userInfo['email user'] ?? 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Shipping Address
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          text: "Shipping Address: ",
                          children: [
                            TextSpan(
                              text: userInfo['shipping Address'] ?? 'N/A',
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
            ],
          ),
        ),
      ),
    );
  }
}