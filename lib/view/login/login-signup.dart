import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/logincontroller.dart';
import 'package:live_app/controller/singupcontroller.dart';
import 'package:live_app/core/function/validator.dart';
import 'package:live_app/functions/ontapfunction.dart';
import 'package:live_app/view/login/reset-password.dart';
import 'package:live_app/view/widget/TextFormField.dart';
import 'package:live_app/view/widget/button.dart';
import 'package:animate_gradient/animate_gradient.dart';
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
          TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 3),
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(245, 82, 82, 84),
                  image: DecorationImage(
                    image: AssetImage("assets/login/loginpic.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
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
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GetBuilder<YourController>(
                              builder: (controller) {
                                return BottomNavigationBar(
                                  unselectedItemColor: Colors.white,
                                  backgroundColor: Colors.transparent,
                                  items: const <BottomNavigationBarItem>[
                                    BottomNavigationBarItem(
                                      icon: Icon(Icons.login),
                                      label: 'Login',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: Icon(Icons.login),
                                      label: 'Sign up',
                                    ),
                                  ],
                                  currentIndex: cont.selectedIndex,
                                   selectedItemColor: Colors.cyanAccent,
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
                                              hintcolor: Colors.cyanAccent,
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
                                                hintcolor: Colors.cyanAccent,
                                                hint: "Password*",
                                                controller:
                                                    logincontroller.password,
                                                Prefixiconbutton: false,
                                                Suffixiconbutton: false,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Button(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.cyan[800]!,
                                                  Colors.blue[800]!
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
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
                                                    "Forgot Password?",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.cyanAccent),
                                                  )),
                                            ),
                                            const Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10),
                                                      child: Divider(
                                                        color: Colors.grey,
                                                        height: 50,
                                                        indent: 120,
                                                        endIndent: 5,
                                                        thickness: 2,
                                                      ),
                                                    ),
                                                  ),

                                                  Text(
                                                    "Or",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                  // Second Divider
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Divider(
                                                        color: Colors.grey,
                                                        height: 50,
                                                        indent: 5,
                                                        endIndent: 120,
                                                        thickness: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: AnimateGradient(
                                                    primaryColors:  [
                                                      Colors.white,
                                                      Colors.blue.shade100
                                                    ],
                                                    secondaryColors: [
                                                      Colors.red.shade400,
                                                      Colors.deepPurple.shade800,
                                                    ],
                                                    child: Container(
                                                      width: 320,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        border: Border.all(
                                                          
                                                          width: 1,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black.withOpacity(0.1),
                                                            blurRadius: 4,
                                                            offset: const Offset(0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Material(
                                                        color: Colors.transparent,
                                                        child: InkWell(
                                                          borderRadius: BorderRadius.circular(20),
                                                          onTap: () {
                                                            logincontroller.Ongooglelogin();
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Image.asset(
                                                                  'assets/login/google_PNG19635.png',
                                                                  height: 25,
                                                                  width: 25,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                                const SizedBox(width: 12),
                                                                Text(
                                                                  "Continue with Google",
                                                                  style: TextStyle(
                                                                    color: Colors.grey[800],
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
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
                                              hintcolor: Colors.cyanAccent,
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
                                              hintcolor: Colors.cyanAccent,
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
                                              hintcolor: Colors.cyanAccent,
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
                                              hintcolor: Colors.cyanAccent,
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
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.cyan[
                                                        800]!, // Vibrant cyan (#0097A7)
                                                    Colors.blue[
                                                        800]! // Deep blue (#1565C0)
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
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
