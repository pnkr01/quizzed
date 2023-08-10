import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:quizzed/theme/app_color.dart';

import '../theme/gradient_theme.dart';

class QuizTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Color borderColor;
  final Color cursorColor;
  final Color hintColor;
  final Color? labelColor;
  final Color? contentColor;
  final bool isObscureText;
  final bool? isEnabled;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final TextEditingController controller;
  const QuizTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.borderColor,
    required this.cursorColor,
    required this.hintColor,
    this.labelColor,
    this.contentColor,
    required this.isObscureText,
    this.isEnabled,
    this.focusNode,
    this.textInputType,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuizTextFormField> createState() => _QuizTextFormFieldState();
}

class _QuizTextFormFieldState extends State<QuizTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.isEnabled ?? true,
      keyboardType: widget.textInputType,
      onSubmitted: (value) {
        widget.focusNode?.unfocus();
      },
      focusNode: widget.focusNode,
      // scrollPhysics: const NeverScrollableScrollPhysics(),

      style:
          kBodyText3Style().copyWith(color: widget.contentColor ?? whiteColor),
      obscureText: widget.isObscureText,
      controller: widget.controller,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: kBodyText3Style().copyWith(color: greyColor, fontSize: 12),
        labelText: widget.labelText,
        labelStyle: kElevatedButtonTextStyle()
            .copyWith(color: widget.labelColor ?? kTeacherPrimaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(14.r),
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
