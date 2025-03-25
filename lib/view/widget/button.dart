import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color color;
  final Gradient? gradient;
  Button({super.key,this.gradient,this.color=Colors.white,required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:gradient ,
          color: color, borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      height: 50,
      child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          )),
    );
  }
}
