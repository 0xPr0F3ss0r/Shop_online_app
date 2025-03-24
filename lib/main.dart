import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/onboardingcontroller.dart';
import 'package:live_app/core/services/services.dart';
import 'package:live_app/route.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Check if Firebase is already initialized
  if (Firebase.apps.isEmpty) {
    await initialServices();
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCZeR8MShJOxUaxnrGi9lgrjcUJdQrFBM4",
          appId: "1:911088896171:android:64e6f454b391ee77018fee",
          messagingSenderId: "911088896171",
          projectId: "shoponline-44470",
          storageBucket: "shoponline-44470.appspot.com",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  }

  // String? token = await FirebaseMessaging.instance.getToken();

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      Get.snackbar("info", "user is signin out",colorText: Colors.red);
    } else {
      Get.snackbar("info", "user is signin",colorText: Colors.blue);
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(onboardingContollerImp());
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: routes,
    );
  }
}

