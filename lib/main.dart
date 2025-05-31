import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/onboardingcontroller.dart';
import 'package:live_app/core/services/services.dart';
import 'package:live_app/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Get the default storage instance
final storageRef = FirebaseStorage.instance.ref();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    Get.snackbar("ERROR", "problem when get some data, please try again later",
        colorText: Colors.red); // Print error if any
  }
  // Check if Firebase is already initialized
  if (Firebase.apps.isEmpty) {
    await initialServices();
    if (Platform.isAndroid) {
      try {
        await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: dotenv.env['API_KEY'] ?? 'default_key',
              appId: dotenv.env['APP_ID'] ?? 'default_appid',
              messagingSenderId: dotenv.env['MESSAGING_SENDER_ID'] ??
                  'default_messagingsenderid',
              projectId: dotenv.env['PROJECT_ID'] ?? 'default_projectid',
              storageBucket:
                  dotenv.env['STORAGE_BUCKET'] ?? 'default_storagebucket'),
        );
      } catch (e) {
        Get.snackbar("ERROR", "error initializing", colorText: Colors.red);
      }
    } else {
      await Firebase.initializeApp();
    }
  }

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      Get.snackbar("info", "user is signin out", colorText: Colors.red);
    } else {
      Get.snackbar("info", "user is signin", colorText: Colors.blue);
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
      //home: LoginPage(),
    );
  }
}
