import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:live_app/controller/Editprofilecontroller.dart';
import 'package:live_app/controller/profilepagecontroller.dart';
import 'package:live_app/model/user_model.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create an instance of EditProfilePageController and ProfilePageController
    EditProfilePageController editProfileController =
        Get.put(EditProfilePageController());
    ProfilePageController profileController = Get.put(ProfilePageController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.deepPurpleAccent[400],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<UserModel?>(
          future: profileController.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != null) {
                UserModel userData = snapshot.data!;
                // Initialize controllers with the received user data
                editProfileController.firstName.text = userData.firstName ?? '';
                editProfileController.secondName.text =
                    userData.secondName ?? '';
                editProfileController.name.text = userData.fullName ?? '';
                editProfileController.email.text = userData.email ?? '';
                editProfileController.phone.text = userData.phone ?? '';
                editProfileController.website.text = userData.website ?? '';
                editProfileController.location.text = userData.location ?? '';

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 5),

                      // Name Field
                      TextField(
                        controller: editProfileController.firstName,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue),
                          labelText: "First Name",
                          icon: Icon(Icons.person, color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: editProfileController.secondName,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue),
                          labelText: "Second Name",
                          icon: Icon(Icons.person, color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),

                      // Email Field
                      TextField(
                        controller: editProfileController.email,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue),
                          labelText: "Email",
                          icon: Icon(Icons.email, color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),

                      // Phone Field
                      TextField(
                        controller: editProfileController.phone,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue),
                          labelText: "Phone",
                          icon: Icon(Icons.phone, color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),

                      // Website Field
                      TextField(
                        controller: editProfileController.website,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue),
                          labelText: "Website",
                          icon: Icon(Icons.web, color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.url,
                      ),
                      const SizedBox(height: 20),

                      // Location Field
                      TextField(
                        controller: editProfileController.location,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue),
                          labelText: "Location",
                          icon: Icon(Icons.location_on, color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Save Button
                      ElevatedButton(
                        onPressed: () {
                          // Validate fields
                          if (editProfileController.email.text.isEmpty &&
                              editProfileController.phone.text.isEmpty &&
                              editProfileController.website.text.isEmpty &&
                              editProfileController.location.text.isEmpty&&
                              editProfileController.name.text.isEmpty &&
                              editProfileController.firstName.text.isEmpty &&
                              editProfileController.secondName.text.isEmpty
                              ) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text:
                                  'Save Failed!, Please fill in all fields',
                              autoCloseDuration: const Duration(seconds: 5),
                              showConfirmBtn: false,
                            );
                            // Get.snackbar("Error", "Please fill in all fields",
                            //     snackPosition: SnackPosition.BOTTOM);
                            return;
                          }
                          editProfileController.updateProfile(context);
                        },
                        child: const Text("Save"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
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
                  child: Text("No user data found."),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(
                child: Text("error"),
              );
            }
          },
        ),
      ),
    );
  }
}
