import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/logincontroller.dart';
import 'package:live_app/controller/singupcontroller.dart';
import 'package:live_app/core/function/validator.dart';
import 'package:live_app/functions/ontapfunction.dart';
import 'package:live_app/view/login/reset-password.dart';
import 'package:live_app/view/widget/TextFormField.dart';
import 'package:live_app/view/widget/button.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  MyLoginController logincontroller = Get.put(MyLoginController());
  MySignupController Signupcontroller = Get.put(MySignupController());
  final YourController cont = Get.put(YourController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(245, 82, 82, 84),
              image: DecorationImage(
                image: AssetImage("assets/login/loginpic.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 128, 206, 206)
                        .withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(4, 6),
                  ),
                ],
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.cyan, width: 2),
              ),
              child: MaterialButton(
                onPressed: () {
                  Get.bottomSheet(
                    SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        height: 540,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GetBuilder<YourController>(
                              builder: (controller) {
                                return BottomNavigationBar(
                                  items: const <BottomNavigationBarItem>[
                                    BottomNavigationBarItem(
                                      backgroundColor: Colors.blueAccent,
                                      icon: Icon(Icons.login),
                                      label: 'Login',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: Icon(Icons.login),
                                      label: 'Sign up',
                                    ),
                                  ],
                                  currentIndex: cont.selectedIndex,
                                  selectedItemColor: Colors.amber[800],
                                  onTap: cont.onItemTapped,
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            GetBuilder<YourController>(
                              builder: (controller) => controller
                                          .selectedIndex ==
                                      0
                                  ? Form(
                                      key: formKey,
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            SingleChildScrollView(
                                                child: TextFormEmail(
                                              validator: (val) => validate(
                                                  val!, 7, 40, "email"),
                                              prefixIcon: Icons.email_outlined,
                                              hint: "Email*",
                                              controller: logincontroller.email,
                                              Prefixiconbutton: false,
                                              Suffixiconbutton: false,
                                            )),
                                            const SizedBox(height: 15),
                                            SingleChildScrollView(
                                              child: TextFormEmail(
                                                validator: (val) => validate(
                                                    val!, 7, 20, "password"),
                                                prefixIcon: Icons.lock_outline,
                                                hint: "Password*",
                                                controller:
                                                    logincontroller.password,
                                                Prefixiconbutton: false,
                                                Suffixiconbutton: false,
                                              ),
                                            ),
                                            const SizedBox(height: 10),

                                            Button(
                                              onPressed: () {
                                                if (formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  logincontroller
                                                      .onlogin(context);
                                                  // Proceed with login
                                                }
                                              },
                                              text: "Login",
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 180),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Get.to(ResetPassword());
                                                  },
                                                  child: const Text(
                                                      "Reset Password?")),
                                            ),

                                            const Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // First Divider
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right:
                                                              10), // Adjust spacing before the text
                                                      child: Divider(
                                                        color: Colors.grey,
                                                        height:
                                                            50, // Height of the divider
                                                        indent:
                                                            120, // Space before the start of the divider
                                                        endIndent:
                                                            5, // Space after the end of the divider
                                                        thickness:
                                                            2, // Thickness of the divider
                                                      ),
                                                    ),
                                                  ),
                                                  // Text in the middle
                                                  Text(
                                                    "Or",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            16), // Adjust fontSize as needed
                                                  ),
                                                  // Second Divider
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left:
                                                              10), // Adjust spacing after the text
                                                      child: Divider(
                                                        color: Colors.grey,
                                                        height:
                                                            50, // Height of the divider
                                                        indent:
                                                            5, // Space before the start of the divider
                                                        endIndent:
                                                            120, // Space after the end of the divider
                                                        thickness:
                                                            2, // Thickness of the divider
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //const SizedBox(height:5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 320,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 2),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/login/google_PNG19635.png', // Path to the image
                                                          height: 25,
                                                          width:
                                                              25, // Adjusted to make it square for better appearance
                                                          fit: BoxFit.cover,
                                                        ),
                                                        const SizedBox(
                                                            width:
                                                                8), // Added spacing between icon and text
                                                        TextButton(
                                                          onPressed: () {
                                                            logincontroller
                                                                .Ongooglelogin();
                                                            // Add your Google sign-in logic here
                                                          },
                                                          child: const Text(
                                                            "Google",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,fontStyle: FontStyle.italic), // Ensures text color matches the theme
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // const SizedBox(width: 10),
                                                // Container(
                                                //   width: 150,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             20),
                                                //     border: Border.all(
                                                //         color: Colors.white,
                                                //         width: 2),
                                                //   ),
                                                //   child: const Center(
                                                //     child: Row(
                                                //       mainAxisAlignment:
                                                //           MainAxisAlignment
                                                //               .center,
                                                //       children: [
                                                //         Icon(
                                                //           Icons.facebook,
                                                //           color: Colors.white,
                                                //           size:
                                                //               25, // Adjust size if needed
                                                //         ),
                                                //         SizedBox(
                                                //             width:
                                                //                 8), // Added spacing between icon and text
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),

                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Form(
                                      key: formKey,
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            TextFormEmail(
                                              controller:
                                                  Signupcontroller.firstName,
                                              prefixIcon: Icons.person,
                                              hint: "First Name*",
                                              validator: (val) => validate(
                                                  val!, 7, 20, "username"),
                                              Prefixiconbutton: false,
                                              Suffixiconbutton: false,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            TextFormEmail(
                                              controller:
                                                  Signupcontroller.secondName,
                                              prefixIcon: Icons.person_outline,
                                              hint: "Second Name*",
                                              validator: (val) => validate(
                                                  val!, 7, 20, "username"),
                                              Prefixiconbutton: false,
                                              Suffixiconbutton: false,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            TextFormEmail(
                                              controller:
                                                  Signupcontroller.email,
                                              prefixIcon: Icons.email_outlined,
                                              hint: "Email*",
                                              validator: (val) => validate(
                                                  val!, 7, 40, "email"),
                                              Prefixiconbutton: false,
                                              Suffixiconbutton: false,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            TextFormEmail(
                                              controller:
                                                  Signupcontroller.password,
                                              prefixIcon: Icons.lock_outline,
                                              hint: "Password*",
                                              validator: (val) => validate(
                                                  val!, 7, 20, "password"),
                                              Prefixiconbutton: false,
                                              Suffixiconbutton: false,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Button(
                                                onPressed: () {
                                                  if (formKey.currentState
                                                          ?.validate() ??
                                                      false) {
                                                    Signupcontroller.Onsignup(
                                                        context);
                                                  }
                                                },
                                                text: "Sign up"),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                minWidth: double.infinity,
                height: 50,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  logincontroller.userdata != null ? 'LOGOUT' : 'LOGIN/SIGNUP',
                  style: const TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
