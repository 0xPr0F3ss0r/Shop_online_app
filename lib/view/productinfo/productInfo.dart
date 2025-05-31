import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/controller/productinfoController.dart';
import 'package:live_app/controller/profileOfUser.dart';
import 'package:live_app/controller/profilepagecontroller.dart';
import 'package:live_app/view/payment/paypale.dart';
import 'package:live_app/view/profile/profileOfProductUser.dart';
import 'package:live_app/view/profile/profileOfUser.dart';
import 'package:live_app/view/widget/TextFormField.dart';

// ignore: must_be_immutable
class Productinfo extends StatelessWidget {
  Productinfo({super.key});

  @override
  Widget build(BuildContext context) {
    Productinfocontroller controller = Get.put(Productinfocontroller());
    ProfilePageController profileController = Get.put(ProfilePageController());
    final Map<String, dynamic>? productinfo = Get.arguments;
    String profileImage = productinfo!['profile image'] ??
        'https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg';
    String productImage = productinfo['productImage'] ??
        "https://www.pinterest.com/pin/19281104650773307/";
    String email = productinfo['email'].toString().isEmpty
        ? 'empty'
        : productinfo['email'];
    String productBrand = productinfo['productsBrand'].toString().isEmpty
        ? 'empty'
        : productinfo['productsBrand'];
    String productSize = productinfo['productSize'].toString().isEmpty
        ? 'empty'
        : productinfo['productSize'];
    String productsPrice = productinfo['productPrice'].toString().isEmpty
        ? 'empty'
        : productinfo['productPrice'];
    String productcolor = productinfo['productColor'].toString().isEmpty
        ? 'empty'
        : productinfo['productColor'];
    List size = productSize.split(",").toList();

    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 213, 54, 18),
        titleSpacing: 10,
        backgroundColor: Colors.deepPurpleAccent[400],
        title: Text(
          "Product info",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.greenAccent[300]),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white54,
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                      fit: BoxFit.cover,
                      height: 400,
                      width: 300,
                      productImage)),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 30),
                  Text(
                    productBrand,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 150),
                  Text(
                    "\$$productsPrice",
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  size.contains("no size")
                      ? const Text("Chose size")
                      : const SizedBox.shrink(),
                  const SizedBox(
                    width: 200,
                  ),
                  GestureDetector(
                      onTap: () {
                        controller.GoToProfileProductInfo(email);
                        // print(controller.UserWithProduct);
                        // Get.to(() => profileOfProductUser(),
                        //     arguments: controller.UserWithProduct);
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CircleAvatar(
                            child: Image.network(
                                height: 200, width: 200, profileImage),
                          )))
                ],
              ),
              const SizedBox(height: 10),
              !size.contains("no size ")
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          ...List.generate(
                            size.length,
                            (int index) => GestureDetector(
                              onTap: () {
                                controller.selectedIndex(index, size[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Obx(
                                  () => ClipOval(
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: controller.index.value == index
                                            ? Colors.blue
                                            : Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          size[index],
                                          style: const TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    profileController.emailText == email
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text("you can't buy from yourself!"),
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.blue,
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height - 200,
                                left: 20,
                                right: 20,
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          )
                        : Get.bottomSheet(
                            backgroundColor: Colors.blue[200],
                            Container(
                              height: 200,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 100),
                                      IconButton(
                                          onPressed: () {
                                            controller.decreasequantity();
                                          },
                                          icon: const Icon(
                                              Icons.remove_circle_outline,
                                              color: Colors.black)),
                                      Container(
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.blueAccent)),
                                        child: Center(
                                          child: Obx(() => Text(
                                              "${controller.quantity.value}")),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            controller.incresequantity();
                                          },
                                          icon: const Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                      width: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: MaterialButton(
                                        onPressed: () {
                                          controller.quantity.value == 0
                                              ? ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                  SnackBar(
                                                    content: const Text(
                                                        "Quantity is 0, it should be greater than 0"),
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    backgroundColor: Colors.red,
                                                    margin: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height -
                                                              200,
                                                      left: 20,
                                                      right: 20,
                                                    ),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                  ),
                                                )
                                              : Get.bottomSheet(
                                                  backgroundColor:
                                                      Colors.blue[200],
                                                  Container(
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height /
                                                        3,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Center(
                                                          child: Text(
                                                            "Payment method",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 16),
                                                          child: const Text(
                                                            "Deliver to",
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        MaterialButton(
                                                          onPressed: () {
                                                            Get.bottomSheet(
                                                                backgroundColor:
                                                                    Colors
                                                                        .black,
                                                                Container(
                                                                  height: 200,
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            const SizedBox(height: 15),
                                                                            TextFormEmail(
                                                                              controller: controller.ShippingAddress,
                                                                              prefixIcon: Icons.location_on_outlined,
                                                                              Prefixiconbutton: false,
                                                                              Suffixiconbutton: false,
                                                                              hint: 'Your Shipping address',
                                                                              style: Colors.white,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      Container(
                                                                          width:
                                                                              120,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.black,
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              border: Border.all(color: const Color.fromARGB(255, 74, 163, 236))),
                                                                          child: MaterialButton(
                                                                            onPressed:
                                                                                () {
                                                                              controller.Onsave();
                                                                            },
                                                                            child:
                                                                                const Text(
                                                                              "Save",
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ));
                                                          },
                                                          child: controller
                                                                      .Shippingaddress !=
                                                                  null
                                                              ? Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .location_on_outlined,
                                                                          color:
                                                                              Colors.black),
                                                                      const SizedBox(
                                                                          width:
                                                                              4),
                                                                      Text(
                                                                        "${controller.Shippingaddress}",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 15),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              150),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                          Get.bottomSheet(
                                                                              backgroundColor: Colors.black,
                                                                              Container(
                                                                                height: 200,
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      child: Column(
                                                                                        children: [
                                                                                          const SizedBox(height: 15),
                                                                                          TextFormEmail(
                                                                                            controller: controller.ShippingAddress,
                                                                                            prefixIcon: Icons.location_on_outlined,
                                                                                            Prefixiconbutton: false,
                                                                                            Suffixiconbutton: false,
                                                                                            hint: 'Your Shipping address',
                                                                                            style: Colors.white,
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(height: 10),
                                                                                    Container(
                                                                                        width: 120,
                                                                                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color.fromARGB(255, 74, 163, 236))),
                                                                                        child: MaterialButton(
                                                                                          onPressed: () {
                                                                                            controller.Onsave();
                                                                                            Get.back();
                                                                                          },
                                                                                          child: const Text(
                                                                                            "Save",
                                                                                            style: TextStyle(color: Colors.white),
                                                                                          ),
                                                                                        ))
                                                                                  ],
                                                                                ),
                                                                              ));
                                                                        },
                                                                        icon: const Icon(
                                                                            Icons
                                                                                .arrow_forward_ios_rounded,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .location_on_outlined,
                                                                          color:
                                                                              Colors.black),
                                                                      const SizedBox(
                                                                          width:
                                                                              4),
                                                                      const Text(
                                                                          "add shipping address"),
                                                                      const SizedBox(
                                                                          width:
                                                                              15),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.bottomSheet(
                                                                              exitBottomSheetDuration: const Duration(seconds: 5),
                                                                              backgroundColor: Colors.black,
                                                                              Container(
                                                                                height: 200,
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      child: Column(
                                                                                        children: [
                                                                                          const SizedBox(height: 15),
                                                                                          TextFormEmail(
                                                                                            controller: controller.ShippingAddress,
                                                                                            prefixIcon: Icons.location_on_outlined,
                                                                                            Prefixiconbutton: false,
                                                                                            Suffixiconbutton: false,
                                                                                            hint: 'Your Shipping address',
                                                                                            style: Colors.white,
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(height: 10),
                                                                                    Container(
                                                                                        width: 120,
                                                                                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color.fromARGB(255, 74, 163, 236))),
                                                                                        child: MaterialButton(
                                                                                          onPressed: () {
                                                                                            controller.Onsave();
                                                                                          },
                                                                                          child: const Text(
                                                                                            "Save",
                                                                                            style: TextStyle(color: Colors.white),
                                                                                          ),
                                                                                        ))
                                                                                  ],
                                                                                ),
                                                                              ));
                                                                        },
                                                                        icon: const Icon(
                                                                            Icons
                                                                                .arrow_forward_ios_rounded,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                        ),
                                                        const SizedBox(
                                                            height: 13),
                                                        Container(
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          child: MaterialButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      CheckoutPage(
                                                                    quantity: controller
                                                                        .quantity
                                                                        .value,
                                                                    price:
                                                                        productsPrice,
                                                                    shippingaddress:
                                                                        controller.Shippingaddress ??
                                                                            'shipping address not found',
                                                                    productname:
                                                                        productBrand,
                                                                    productcolor:
                                                                        productcolor,
                                                                    productimage:
                                                                        productImage,
                                                                    email:
                                                                        email,
                                                                    profileImage: profileController
                                                                            .Image ??
                                                                        profileController
                                                                            .avatarDefault,
                                                                    productsize:
                                                                        productSize,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: const Center(
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .paypal,
                                                                      color: Colors
                                                                          .blue,
                                                                      size: 30),
                                                                  SizedBox(
                                                                      width: 8),
                                                                  Text(
                                                                    "Paypal",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            30),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                        },
                                        child: const Text(
                                          "Get",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ))
                                ],
                              ),
                            ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AnimateGradient(
                      primaryColors: [Colors.white, Colors.blue],
                      secondaryColors: [
                        Colors.red.shade200,
                        Colors.deepPurple.shade800,
                      ],
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                            child: Text(
                          "Add to cart",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
