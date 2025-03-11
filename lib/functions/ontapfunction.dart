import 'package:get/get.dart';

class YourController extends GetxController {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

  int get SelectedIndex => selectedIndex;
}
