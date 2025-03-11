import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_app/constant/AppColor.dart';
import 'package:live_app/controller/paymentPage.dart';
class Payment extends StatelessWidget {
  Payment({super.key});

  @override
  Widget build(BuildContext context) {
    PaymentController controller = Get.put(PaymentController());
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(255, 213, 54, 18),
        titleSpacing: 10,
        backgroundColor: Colors.deepPurpleAccent[400],
        title: Text(
          "Payment",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.greenAccent[300]),
        ),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       print("is light theme : ${controller.isLightTheme.value}");
      //     },
      //     child: Text("")),
      body: Builder(
        builder: (BuildContext context) {
          return Obx(() {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(
                    controller.isLightTheme.value
                        ? 'assets/paymentCardPictures/bg-light.png'
                        : 'assets/paymentCardPictures/bg-dark.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => controller.onPressedFirstIcon(),
                      icon: Icon(
                        controller.isLightTheme.value
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                    ),
                    CreditCardWidget(
                      enableFloatingCard: controller.useFloatingAnimation,
                      glassmorphismConfig: controller.getGlassmorphismConfig(),
                      cardNumber: controller.cardNumber!,
                      expiryDate: controller.expiryDate!,
                      cardHolderName:controller.cardHolderName,
                      cvvCode: controller.cvvCode!,
                      bankName: 'Axis Bank',
                      frontCardBorder: controller.useGlassMorphism
                          ? null
                          : Border.all(color: Colors.grey),
                      backCardBorder: controller.useGlassMorphism
                          ? null
                          : Border.all(color: Colors.grey),
                      showBackView: controller.isCvvFocused,
                      obscureCardNumber: true,
                      obscureCardCvv: true,
                      isHolderNameVisible: true,
                      cardBgColor: controller.isLightTheme.value
                          ? AppColors.cardBgLightColor
                          : AppColors.cardBgColor,
                      backgroundImage: controller.useBackgroundImage
                          ? 'assets/paymentCardPictures/card_bg.png'
                          : null,
                      isSwipeGestureEnabled: true,
                      onCreditCardWidgetChange:
                          (CreditCardBrand creditCardBrand) {},
                      customCardTypeIcons: <CustomCardTypeIcon>[
                        CustomCardTypeIcon(
                          cardType: CardType.otherBrand,
                          cardImage: Image.asset(
                            'assets/paymentCardPictures/mastercard.png',
                            height: 30,
                            width:30,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            CreditCardForm(
                              formKey: formKey,
                              obscureCvv: false,
                              obscureNumber: false,
                              cardNumber: controller.cardNumber!,
                              autovalidateMode:AutovalidateMode.onUserInteraction,
                              cvvCode: controller.cvvCode!,
                              isHolderNameVisible: true,
                              isCardNumberVisible: true,
                              isExpiryDateVisible: true,
                              cardHolderName: controller.cardHolderName,
                              expiryDate: controller.expiryDate!,
                              inputConfiguration:  InputConfiguration(
                                cardNumberDecoration: InputDecoration(
                                  labelText: 'Number',
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                  hintStyle: TextStyle(color: controller.isLightTheme.value?Colors.black:const Color.fromARGB(255, 72, 69, 69))
                                ),
                                expiryDateDecoration: InputDecoration(
                                  labelText: 'Expired Date',
                                  hintText: 'XX/XX',
                                  hintStyle: TextStyle(color: controller.isLightTheme.value?Colors.black:const Color.fromARGB(255, 72, 69, 69))
                                ),
                                cvvCodeDecoration: InputDecoration(
                                  labelText: 'CVV',
                                  hintText: 'XXX',
                                  hintStyle: TextStyle(color: controller.isLightTheme.value?Colors.black:const Color.fromARGB(255, 72, 69, 69))
                                ),
                                cardHolderDecoration: InputDecoration(
                                  labelText: 'Card Holder',
                                ),
                              ),
                              onCreditCardModelChange: (CreditCardModel brand){},
                            ),
                            const SizedBox(height: 20),
                          
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: (){
                                controller.Validate();
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      AppColors.colorB58D67,
                                      AppColors.colorB58D67,
                                      AppColors.colorE5D1B2,
                                      AppColors.colorF9EED2,
                                      AppColors.colorEFEFED,
                                      AppColors.colorF9EED2,
                                      AppColors.colorB58D67,
                                    ],
                                    begin: Alignment(-1, -4),
                                    end: Alignment(1, 4),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Validate',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'halter',
                                    fontSize: 14,
                                    package: 'flutter_credit_card',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}