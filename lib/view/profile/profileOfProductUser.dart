import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/ProfileOfProductUserController.dart';
import 'package:live_app/controller/logincontroller.dart';
import 'package:live_app/core/services/services.dart';

// ignore: must_be_immutable
class profileOfProductUser extends StatelessWidget {
  MyLoginController logincontroller = Get.put(MyLoginController());
  final User? user = FirebaseAuth.instance.currentUser;
  MyServices services = Get.find();
  profileOfProductUserController controller =
      Get.put(profileOfProductUserController());
  profileOfProductUser({super.key});
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? profileinfo = Get.arguments;
    String profileImage = profileinfo!['profile image'] ??
        'https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg';
    String profileName = profileinfo['profile name'] ?? 'Unknown';
    String email = profileinfo['email'] ?? '';
    String phone = profileinfo['phone'] ?? '';
    String website = profileinfo['website'] ?? '';
    String location = profileinfo['location'] ?? '';
    List<Map<String, dynamic>> products = profileinfo['all products'] ?? [];
    
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          shadowColor: const Color.fromARGB(255, 213, 54, 18),
          titleSpacing: 10,
          backgroundColor: Colors.deepPurpleAccent[400],
          title: Text(
            profileName,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.greenAccent[300]),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
           onRefresh: () async {
          await controller.GetNumberOfFollowers();
        },
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color.fromARGB(255, 6, 59, 101),
                              radius: 115,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 110,
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: profileImage.isNotEmpty
                                      ? (profileImage.startsWith('http')
                                          ? NetworkImage(profileImage)
                                              as ImageProvider<Object>
                                          : (() {
                                              final file = File(profileImage);
                                              return file.existsSync()
                                                  ? FileImage(file)
                                                      as ImageProvider<Object>
                                                  : const AssetImage(
                                                          "assets/images/error_image.jpg")
                                                      as ImageProvider<Object>;
                                            })())
                                      : const NetworkImage(
                                          "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profileName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Active since - Jul, 2019",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Obx(
                        () => Text(
                          "${controller.Followers.value} followers",
                          style: const TextStyle(color: Colors.black),
                        ),
                      )),
                    ),
                    const SizedBox(height: 5),
                   // Container(width: 400,height: 300,child: Obx(()=> Text("${email}")),),
                    Obx(()
                      => controller.emailuser.value != email?
                        MaterialButton(
                          onPressed: () {
                            Future.delayed(const Duration (seconds: 5));
                             controller.checkFollower(email);
                            
                          },
                          child: Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                                child: Obx(
                              () =>  controller.isFollowMap!.containsKey(controller.emailuser.value) 
                && controller.isFollowMap![controller.emailuser.value] ==true?const Text(
                               "unfollow",
                                style: TextStyle(color: Colors.black),
                              ):const Text(
                               "follow",
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                          ),
                        ):const Text("profile view",style: TextStyle(color: Colors.blue),),
                    ),
                    
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Personal Information",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: Colors.black,
                      child: ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text("Email",
                              style: TextStyle(color: Colors.white)),
                          trailing: Text(email,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 15))),
                    ),
                    Card(
                      color: Colors.black,
                      child: ListTile(
                        leading: const Icon(Icons.phone),
                        title:
                            const Text("Phone", style: TextStyle(color: Colors.white)),
                        trailing: Text(phone,
                            style: const TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    ),
                    Card(
                      color: Colors.black,
                      child: ListTile(
                          leading: const Icon(Icons.shop),
                          title: const Text("Website",
                              style: TextStyle(color: Colors.white)),
                          trailing: Text(website,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 15))),
                    ),
                    Card(
                      color: Colors.black,
                      child: ListTile(
                          leading: const Icon(Icons.location_on),
                          title: const Text("Location",
                              style: TextStyle(color: Colors.white)),
                          trailing: Text(location,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 15))),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent[400],
                          borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            "Products",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(products.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.cyan),
                          child: Column(
                            children: [
                              Text(
                                "product number ${index + 1}",
                                style:
                                    const TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              const Divider(color: Colors.black),
                              const SizedBox(height: 3),
                              Text.rich(TextSpan(
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  text: "product type: ",
                                  children: [
                                    TextSpan(
                                        text: products[index]['productType'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))
                                  ])),
                              const Divider(color: Colors.black),
                              const SizedBox(height: 3),
                              Text.rich(TextSpan(
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  text: "product Brand: ",
                                  children: [
                                    TextSpan(
                                        text: products[index]['productBrand'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))
                                  ])),
                              const Divider(color: Colors.black),
                              const SizedBox(height: 3),
                              Text.rich(TextSpan(
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  text: "product size: ",
                                  children: [
                                    TextSpan(
                                        text: products[index]['productBrandSize'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))
                                  ])),
                              const Divider(color: Colors.black),
                              const SizedBox(height: 3),
                              Text.rich(TextSpan(
                                style: const TextStyle(
                                  fontSize: 18,color: Colors.black),
                                  text: "product color: ",
                                  children: [
                                    TextSpan(
                                      text:products[index]['productColor'],
                                      style:const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)
                                    )
                                  ]
                                )
                              ),
                              const Divider(color: Colors.black),
                              const SizedBox(height: 3),
                              Text.rich(TextSpan(
                                style: const TextStyle(
                                  fontSize: 18,color: Colors.black),
                                  text: "product price: ",
                                  children: [
                                    TextSpan(
                                      text:products[index]['productPrice'],
                                      style:const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)
                                    )
                                  ]
                                )
                              ),
                              const Divider(color: Colors.black),
                              const SizedBox(height: 5),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    width: 300, products[index]['productImage']),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ]))),
        ));
  }
}
