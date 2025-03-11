//import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  String hintText = "xxxx xxxx xxxx xxxx";
  String SecondhintText = 'XX/XX';
  String ThirdhintText = 'XXX';
  String FourthhintText = 'YOUR NAME';
  bool useFloatingAnimation = true;
  String? cardNumber = '';
  String? expiryDate = '';
  String cardHolderName = '';
  String? cvvCode = '';
  bool isCvvFocused = false;
  RxBool isLightTheme = false.obs;
  bool useGlassMorphism = false;
  bool useBackgroundImage = true;
  bool showBackView = true;
  @override
  void onInit() {
    super.onInit();
  }

  void Validate() {
    hintText = cardNumber!;
    SecondhintText = expiryDate!;
    ThirdhintText = cardHolderName;
    FourthhintText = cvvCode!;
    update();
  }

  void onChagedFirst(bool value) {
    useGlassMorphism = value;
  }

  void onChangedSecond(bool value) {
    useBackgroundImage = value;
  }

  onPressedFirstIcon() {
    isLightTheme.value = !isLightTheme.value;
    update();
  }

  Glassmorphism? getGlassmorphismConfig() {
    if (!useGlassMorphism) {
      return null;
    }
    return null;
  }

  void onCreditCardModelChange(CreditCardModel data) {
    cardNumber = data.cardNumber;
    expiryDate = data.expiryDate;
    cardHolderName = data.cardHolderName;
    cvvCode = data.cvvCode;
    update();
  }
}
