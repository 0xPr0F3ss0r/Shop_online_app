import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/changePasswordcontroller.dart';
import 'package:live_app/core/function/validator.dart';
import 'package:live_app/view/widget/TextFormField.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  final changepasswordcontroller controller = Get.put(changepasswordcontroller());
  final myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: Colors.deepPurpleAccent[400],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: myKey,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Change Your Password",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        color: Color.fromARGB(255, 34, 111, 159),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  buildPasswordField(
                    "Current Password",
                    controller.currentPassword,
                  ),
                  SizedBox(height: 25),
                  buildPasswordField(
                    "New Password",
                    controller.newPassword,
                  ),
                  SizedBox(height: 25),
                  buildPasswordField(
                    "Retype New Password",
                    controller.retypeNewPassword,
                  ),
                  SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 38, 67, 213),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (myKey.currentState!.validate()) {
                          controller.updatePassword();
                        }
                      },
                      child: const Text(
                        "Update Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField(String hint, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextFormEmail(
            keyboardType: TextInputType.text,
            validator: (val) => validate(val!, 7, 40, "password"),
            prefixIcon: Icons.lock,
            hint: hint,
            hintcolor: Colors.blueAccent,
            controller: controller,
            Prefixiconbutton: false,
            Suffixiconbutton: false,
          ),
        ),
      ],
    );
  }
}
