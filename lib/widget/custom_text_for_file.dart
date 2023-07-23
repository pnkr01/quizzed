import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/gradient_theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final Color borderColor;
  final Color cursorColor;
  final Color labelColor;
  final Color? contentColor;
  final Color? hintColor;
  final bool isObscureText;
  final TextEditingController controller;
  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.borderColor,
    required this.cursorColor,
    required this.labelColor,
    this.contentColor,
    this.hintColor,
    required this.isObscureText,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style:
          kBodyText3Style().copyWith(color: widget.contentColor ?? whiteColor),
      obscureText: widget.isObscureText,
      controller: widget.controller,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle:
            kBodyText3Style().copyWith(color: widget.hintColor ?? whiteColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(14.sp),
          ),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(14.sp),
          ),
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
      ),
    );
  }
}
