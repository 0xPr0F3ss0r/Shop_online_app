import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/emailVerificationController.dart';
import 'package:live_app/controller/singupcontroller.dart';

class SendEmailVerification extends StatelessWidget {
  final SendEmailVerificationController controller = Get.put(SendEmailVerificationController());
  final MySignupController signupController = Get.put(MySignupController());
  
  @override
  Widget build(BuildContext context) {
    String email = signupController.email.text;
    return Scaffold(
      body: Stack(
        children: [
          // Background with gradient overlay
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login/emailverif.jpg"),
                fit: BoxFit.cover,
              ),
            
            ),
          ),
          
          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Email Icon Animation
                  const Icon(
                    Icons.mark_email_unread_outlined,
                    size: 100,
                    color: Colors.cyanAccent,
                  ),
                  const SizedBox(height: 30),
                  
                  // Title
                  const Text(
                    "Confirm Your Email",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Instruction Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.cyanAccent.withOpacity(0.5),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                         Text(
                          "We've sent a confirmation email to:",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          email,
                          style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Please check your inbox and click the verification link to activate your account.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Check Verification Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => controller.checkEmailVerified(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "CHECK VERIFICATION STATUS",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Resend Email Section
                  Column(
                    children: [
                      const Text(
                        "Didn't receive the email?",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          signupController.sendemailverification();
                          Get.snackbar(
                            "Email Sent",
                            "Verification email has been resent",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          "RESEND VERIFICATION EMAIL",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}