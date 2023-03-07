import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:quiz/theme/app_color.dart';
import 'package:quiz/utils/size_configuration.dart';

import '../theme/gradient_theme.dart';

class QuizTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Color borderColor;
  final Color cursorColor;
  final Color hintColor;
  final Color? contentColor;
  final bool isObscureText;
  final FocusNode focusNode;
  final TextEditingController controller;
  const QuizTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.borderColor,
    required this.cursorColor,
    required this.hintColor,
    this.contentColor,
    required this.isObscureText,
    required this.focusNode,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuizTextFormField> createState() => _QuizTextFormFieldState();
}

class _QuizTextFormFieldState extends State<QuizTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      // scrollPhysics: const NeverScrollableScrollPhysics(),
      // scrollPadding: const EdgeInsets.only(bottom: ),
      style:
          kBodyText3Style().copyWith(color: widget.contentColor ?? whiteColor),
      obscureText: widget.isObscureText,
      controller: widget.controller,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: kBodyText3Style().copyWith(color: greyColor, fontSize: 12),
        labelText: widget.labelText,
        labelStyle: kBodyText3Style()
            .copyWith(color: widget.hintColor, fontSize: 14.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(getProportionateScreenHeight(14.sp)),
          ),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(getProportionateScreenHeight(14.sp)),
          ),
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
      ),
    );
  }
}
