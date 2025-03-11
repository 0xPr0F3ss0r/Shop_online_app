import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_app/functions/ontapfunction.dart';

// ignore: must_be_immutable
class TextFormEmail extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  final YourController cont = Get.put(YourController());
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  bool Prefixiconbutton = false;
  bool Suffixiconbutton = false;
  Color? hintcolor = Colors.white;
  Color? SuffixMycolor = Colors.white;
  Color? PrefixMycolor = Colors.white;
  final void Function()? onPressedprefix;
  final void Function()? onPressedsufix;
  final IconData? peifxIconOfButton;
  final IconData? sufixIconOfButton;
  final TextInputType? keyboardType;
  final String? hint;
  final String? Function(String?)? validator;
  final int? maxLines;
  final double? hintsize;
  final int? maxLength;
  final TextAlign textAlign;
  final Color bordercolor;
  final double? borderWidth;
  final Color style;
  final void Function(String)? onChanged;
  TextFormEmail({
    super.key,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.hintcolor,
    this.hintsize,
    required this.controller,
    required this.prefixIcon,
    this.maxLines,
    this.suffixIcon,
    this.PrefixMycolor,
    this.SuffixMycolor,
    required this.Prefixiconbutton,
    required this.Suffixiconbutton,
    this.peifxIconOfButton,
    this.sufixIconOfButton,
    required this.hint,
    this.validator,
    this.onPressedprefix,
    this.onPressedsufix,
    this.keyboardType,
    this.bordercolor = Colors.blueAccent,
    this.borderWidth = 2,
    this.style = Colors.white,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      textAlign: textAlign,
      style: TextStyle(color: style),
      inputFormatters: [
        if (maxLength != null)
          LengthLimitingTextInputFormatter(maxLength), // Limit input size
      ],
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: bordercolor,
            width: borderWidth!,
          ),
        ),
        suffixIcon: Suffixiconbutton
            ? IconButton(
                onPressed: onPressedsufix, icon: Icon(sufixIconOfButton),
                )
            : Icon(suffixIcon, color: PrefixMycolor),
        hintText: hint,
        hintStyle: TextStyle(color: hintcolor, fontSize: hintsize),
        prefixIcon: Prefixiconbutton
            ? IconButton(
                onPressed: onPressedprefix, icon: Icon(peifxIconOfButton))
            : Icon(prefixIcon, color: SuffixMycolor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: bordercolor,
            width: borderWidth!,
          ),
        ),
      ),
      onChanged: onChanged
    );
  }
}
