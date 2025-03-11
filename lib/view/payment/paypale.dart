import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_app/controller/paypalController.dart';

class CheckoutPage extends StatefulWidget {
  final String email;
  final int quantity;
  final String price;
  final String shippingaddress;
  final String productname;
  final String productimage;
  final String productcolor;
  final String profileImage;
  final String productsize;
  const CheckoutPage({required this.email,
    required this.quantity,
    required this.price,
    required this.shippingaddress,
    required this.productname, super.key, required this.productimage, required this.productcolor, required this.profileImage, required this.productsize});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    Map order ={};
    Paypalcontroller controller = Get.put(Paypalcontroller());
    return UsePaypal(
        sandboxMode: true,
        clientId:
            "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
        secretKey:
            "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
        returnURL: "https://samplesite.com/return",
        cancelURL: "https://samplesite.com/cancel",
        transactions:  [
          {
            "amount": {
              "total": widget.price*widget.quantity,
              "currency": "USD",
              "details": {
                "subtotal": widget.price*widget.quantity,
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            // "payment_options": {
            //   "allowed_payment_method":
            //       "INSTANT_FUNDING_SOURCE"
            // },
            "item_list": {
              "items": [
                {
                  "name": "${widget.productname}",
                  "quantity": "${widget.quantity}",
                  "price": '${widget.price}',
                  "currency": "USD",
                }
              ],

              // shipping address is not required though
              // "shipping_address": {
              //   "recipient_name": "Jane Foster",
              //   "line1": "Travis County",
              //   "line2": "",
              //   "city": "Austin",
              //   "country_code": "US",
              //   "postal_code": "73301",
              //   "phone": "+00000000",
              //   "state": "Texas"
              // },
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          controller.Getparams(params,widget.email,widget.productsize,widget.productcolor,widget.productimage,widget.shippingaddress,widget.profileImage);
        },
        onError: (error) {
          Get.snackbar('info', "operation stopped , please try again later",colorText: Colors.red);
        },
        onCancel: (params) {
          Get.snackbar('info', "operation cancelled",colorText: Colors.blue);
        });
  }
}
