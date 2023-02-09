import 'package:flutter/material.dart';

import '../theme/gradient_theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final Color borderColor;
  final Color cursorColor;
  final Color labelColor;
  final Color? contentColor;
  final bool isObscureText;
  final TextEditingController controller;
  const CustomTextFormField({
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
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: kTextStyle().copyWith(
        color: widget.contentColor ?? Colors.white,
      ),
      obscureText: widget.isObscureText,
      controller: widget.controller,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: widget.labelColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
      ),
    );
  }
}
