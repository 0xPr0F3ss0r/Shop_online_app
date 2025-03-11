import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  Button({super.key,required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
