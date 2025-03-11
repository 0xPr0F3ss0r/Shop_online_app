import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/view/homepage/homepage.dart';
import 'package:live_app/view/profile/profile.dart';
import 'package:live_app/view/searchpage/searchpage.dart';
import 'package:live_app/view/storepage/storepage.dart';

class NavigationBarC extends GetxController{
  int index = 0;


  void onTap(int selectedindex){
    index = selectedindex;
    update();
  }


    var pages =  [
    HomePage(),
    Searchpage(),
    Storepage(),
    ProfilePage(),
  ];
}

class CustomNavigationbar extends StatelessWidget {
  CustomNavigationbar({super.key});

  final items = const [
  Icon(Icons.home, size: 30,color: Colors.greenAccent,),
  Icon(Icons.search_outlined, size: 30,color: Colors.greenAccent),
  Icon(Icons.store, size: 30,color: Colors.greenAccent),
  Icon(Icons.person, size: 30,color: Colors.greenAccent)
];
  


  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> key = GlobalKey();
    Get.put(NavigationBarC());
    return GetBuilder<NavigationBarC>(
      builder: (controller){      
      return Scaffold(
        body:  controller.pages[controller.index],
        bottomNavigationBar: CurvedNavigationBar(
          key: key,
          items: items,
          index: controller.index,
          color: Colors.blueAccent,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 300),
          onTap: controller.onTap
          ),
      );
      }
    );
  }
}