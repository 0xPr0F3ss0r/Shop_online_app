import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Profileofuser extends GetxController{
  String? email;
  String? name ;
  String? pictureUrl;




  @override
  void onInit() {
    email = Get.arguments["email"];
    name = Get.arguments["name"];
    pictureUrl = Get.arguments["pictureUrl"];
    super.onInit();
  }
}