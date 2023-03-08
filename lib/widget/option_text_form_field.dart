import 'package:flutter/material.dart';
import '../theme/gradient_theme.dart';

class OptionTextFormField extends StatefulWidget {
  final String labelText;
  final Color borderColor;
  final Color cursorColor;
  final Color labelColor;
  final Color? contentColor;
  final bool isObscureText;
  final TextEditingController controller;
  const OptionTextFormField({
    Key? key,
    required this.labelText,
    required this.borderColor,
    required this.cursorColor,
    required this.labelColor,
    this.contentColor,
    required this.isObscureText,
    required this.controller,
  }) : super(key: key);

  @override
  State<OptionTextFormField> createState() => _OptionTextFormFieldState();
}

class _OptionTextFormFieldState extends State<OptionTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: kBodyText3Style(),
      obscureText: widget.isObscureText,
      controller: widget.controller,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        focusColor: whiteColor,
        labelText: widget.labelText,
        labelStyle: kBodyText3Style(),
        enabledBorder: const OutlineInputBorder(
          // borderRadius: BorderRadius.all(
          //   Radius.circular(14.r),
          // ),
          borderSide: BorderSide(color: whiteColor, style: BorderStyle.none),
        ),
        // focusedBorder: const OutlineInputBorder(
        //   // borderRadius: BorderRadius.all(
        //   //   Radius.circular(14.r),
        //   // ),
        //   borderSide:
        //       BorderSide(color: whiteColor, style: BorderStyle.none, width: 10),
        // ),
      ),
    );
  }
}
