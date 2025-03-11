import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/constant/Products.dart';
import 'package:live_app/constant/route.dart';
import 'package:live_app/controller/Editprofilecontroller.dart';
import 'package:live_app/controller/logincontroller.dart';
import 'package:live_app/controller/profilepagecontroller.dart';
import 'package:live_app/core/services/services.dart';
import 'package:live_app/credential_manage.dart/change_password.dart';
import 'package:live_app/model/user_model.dart';
import 'package:live_app/view/orders/ViewOrdersPage.dart';
import 'package:live_app/view/profile/Editprofilepage.dart';
import 'package:live_app/view/profile/ViewProductsPage.dart';
// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePageController controller = Get.put(ProfilePageController());
  MyLoginController logincontroller = Get.put(MyLoginController());
  EditProfilePageController editcontroller =
      Get.put(EditProfilePageController());
  MyServices services = Get.find();
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          shadowColor: Colors.white,
          titleSpacing: 10,
          backgroundColor: Colors.black,
          elevation: 2,
          title: const Text(
            "Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            controller.fetchUserProducts();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    FutureBuilder<UserModel?>(
                      future: controller.getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData && snapshot.data != null) {
                            UserModel userData = snapshot.data!;
                            controller.firstname = userData.firstName ?? '';
                            controller.secondName = userData.secondName ?? '';
                            controller.nameProfilePage = userData.fullName ?? '';
                            controller.emailText = userData.email ?? '';
                            controller.phone = userData.phone ?? '';
                            controller.website = userData.website ?? '';
                            controller.location = userData.location ?? '';
                            controller.Image = userData.avatar;
                            controller.followers = userData.followers ?? 0;
                            controller.type = userData.type ?? '';
                            return Column(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Stack(
                                      children: [
                                         Container(
                                           child: CircleAvatar(
                                              backgroundColor: Colors.blueAccent,
                                              radius: 110,
                                              child: CircleAvatar(
                                                radius: 107,
                                                backgroundImage:
                                                 controller.Image != null && controller.Image!.isNotEmpty
                                               ? (controller.Image!.startsWith('http')
                                                   ? NetworkImage(controller.Image!) as ImageProvider<Object>
                                                   : (() {
                                                       final file = File(controller.Image!);
                                                       return file.existsSync()
                                                           ? FileImage(file) as ImageProvider<Object>
                                                           : const AssetImage("assets/images/error_image.jpg") as ImageProvider<Object>;
                                                     })())
                                               : const NetworkImage("https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg"),
                                           
                                              ),
                                            ),
                                         ),
                                        
                                        Positioned(
                                            top: 180,
                                            left: 150,
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
                                                            Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            20)),
                                                              ),
                                                              child: MaterialButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .pickImageFromGallery(
                                                                          "profile",
                                                                          context);
                                                                },
                                                                minWidth: 300,
                                                                color: Colors.blue,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(20),
                                                                  side: const BorderSide(
                                                                      color: Colors
                                                                          .black), // Border
                                                                ),
                                                                child: const Text(
                                                                  "From Pictures",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white), 
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 20),
                                                            Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            20)),
                                                              ),
                                                              child: MaterialButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .pickImageFromCamera(
                                                                          context);
                                                                },
                                                                minWidth: 300,
                                                                color: Colors.blue,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(20),
                                                                  side: const BorderSide(
                                                                      color: Colors
                                                                          .black), // Border
                                                                ),
                                                                child: const Text(
                                                                  "From Camera",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white), // Text color for better contrast
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              decoration: const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            20)),
                                                              ),
                                                              child: MaterialButton(
                                                                onPressed: () {
                                                                  
                                                                  controller
                                                                      .removePicture();
                                                                },
                                                                minWidth: 300,
                                                                color: Colors.blue,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(20),
                                                                  side: BorderSide(
                                                                      color: Colors
                                                                          .black), // Border
                                                                ),
                                                                child: const Text(
                                                                  "Remove Picture",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white), // Text color for better contrast
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
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
                                                icon: Icon(
                                                  Icons.camera_alt,
                                                  size: 30,
                                                )))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  controller.nameProfilePage!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Active since - Jul, 2019",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 132, 170, 235),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child: controller.followers != null 
                                              
                                          ? Text(
                                              "${controller.followers}followers",
                                              style: TextStyle(color: Colors.black),
                                            )
                                          : Text(
                                              "0 followers",
                                              style: TextStyle(color: Colors.black),
                                            )),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Personal Information",
                                      style:
                                          TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        Get.to(EditProfilePage(), arguments: {
                                          'name': controller.nameProfilePage,
                                          'email': controller.emailText,
                                          'phone': controller.phone,
                                          'website': controller.website,
                                          'location': controller.location
                                        });
                                      },
                                      icon: Icon(Icons.edit, color: Colors.blue),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(EditProfilePage(), arguments: {
                                          'email': controller.emailText,
                                          'phone': controller.phone,
                                          'website': controller.website,
                                          'location': controller.location
                                        });
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Card(
                                  color: Colors.black,
                                  child: ListTile(
                                      leading: Icon(Icons.email),
                                      title: Text("Email",
                                          style: TextStyle(color: Colors.white)),
                                      trailing: controller.emailText != null
                                          ? Text(controller.emailText!,
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15))
                                          : Text('',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15))),
                                ),
                                Card(
                                  color: Colors.black,
                                  child: ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("First Name",
                                          style: TextStyle(color: Colors.white)),
                                      trailing: controller.firstname != null
                                          ? Text(controller.firstname!,
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15))
                                          : Text('',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15))),
                                ),
                                Card(
                                  color: Colors.black,
                                  child: ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("Second Name",
                                          style: TextStyle(color: Colors.white)),
                                      trailing: controller.secondName != null
                                          ? Text(controller.secondName!,
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15))
                                          : Text('',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15))),
                                ),
                                Card(
                                  color: Colors.black,
                                  child: ListTile(
                                    leading: Icon(Icons.phone),
                                    title: Text("Phone",
                                        style: TextStyle(color: Colors.white)),
                                    trailing: controller.phone != null
                                        ? Text(controller.phone!,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15))
                                        : Text('',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15)),
                                  ),
                                ),
                                Card(
                                  color: Colors.black,
                                  child: ListTile(
                                    leading: Icon(Icons.shop),
                                    title: Text("Website",
                                        style: TextStyle(color: Colors.white)),
                                    trailing: controller.website != null
                                        ? Text(controller.website!,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15))
                                        : Text('',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15)),
                                  ),
                                ),
                                Card(
                                  color: Colors.black,
                                  child: ListTile(
                                    leading: Icon(Icons.location_on),
                                    title: Text("Location",
                                        style: TextStyle(color: Colors.white)),
                                    trailing: controller.location != null
                                        ? Text(controller.location!,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15))
                                        : Text('',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15)),
                                  ),
                                ),
                                SizedBox(height: 20),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Privacy Settings",
                                      style:
                                          TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                                Card(
                                  color: Colors.black,
                                  child: ListTile(
                                    leading: Icon(Icons.lock_outline),
                                    title: Text("change your password",
                                        style: TextStyle(color: Colors.white)),
                                    trailing: IconButton(
                                        onPressed: () {
                                          Get.to(() => ChangePassword());
                                        },
                                        icon: Icon(
                                          Icons.lock_person,
                                          color: Colors.blue,
                                        )),
                                  ),
                                ),
                                SizedBox(height: 20),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Utilities",
                                      style:
                                          TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                                Card(
                                  color: Colors.black,
                                  child: ListTile(
                                    leading: Icon(Icons.question_answer),
                                    title: Text("Ask Help-Desk",
                                        style: TextStyle(color: Colors.white)),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.forward,
                                          color: Colors.blue,
                                        )),
                                  ),
                                ),
                                Card(
                                  color: Colors.black,
                                  child: ListTile(
                                    leading: Icon(Icons.logout),
                                    title: Text("Log-Out",
                                        style: TextStyle(color: Colors.white)),
                                    trailing: IconButton(
                                        onPressed: () {
                                          controller.signOut();
                                          services.sharedpreferences
                                              .setString("step", "1");
                                          Get.offAllNamed(AppRoute.Login);
                                        },
                                        icon: Icon(
                                          Icons.forward,
                                          color: Colors.blue,
                                        )),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    controller.type == "seller"
                                        ? Text(
                                            "Add Products",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 18),
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                                const SizedBox(height: 5),
                                controller.type == "seller"
                                    ? Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.white)),
                                      child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            children: [    
                                            Column(
                                              children: [
                                                Products(),
                                              ],
                                            )
                                          ]
                                          )
                                          ),
                                    )
                                    : const SizedBox.shrink(),
                                        const SizedBox(height: 5),
                    controller.type == "seller"?
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black
                        ),
                        child: ElevatedButton(onPressed: (){Get.to(Vviewproductspage());},child:const Text("Show All Products",style: TextStyle(color: Colors.blue),) ,)),
                    ):const SizedBox.shrink(),
                    const SizedBox(height: 10),
                    controller.type == "seller"?
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black
                        ),
                        child: ElevatedButton(onPressed: (){Get.to(Vieworderspage());},child:const Text("Show All Orders",style: TextStyle(color: Colors.blue),) ,)),
                    ):const SizedBox.shrink()
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                snapshot.error.toString(),
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text("No user data found.",style: TextStyle(color: Colors.white,fontSize: 15),),
                            );
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return const Center(
                            child: Text("error"),
                          );
                        }
                      },
                    ),
                    
                  ],
                ),
              ),
              
            ),
          ),
        ));
  }
}
