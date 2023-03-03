import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:quiz/theme/app_color.dart';

import '../theme/gradient_theme.dart';
import '../utils/size_configuration.dart';

class MYElevatedButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color? textColor;
  final Function()? function;
  const MYElevatedButton({
    Key? key,
    required this.label,
    required this.backgroundColor,
    this.textColor,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(45.sp),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          backgroundColor: backgroundColor,
        ),
        onPressed: function,
        child: Text(
          label,
          style: kElevatedButtonTextStyle().copyWith(
            color: textColor ?? kOnElevatedButtonTextColor,
          ),

          //  kTitleTextStyle().copyWith(
          //   color: kOnElevatedButtonTextColor,
          //   fontSize: getProportionateScreenHeight(14.sp),
          //   fontWeight: FontWeight.w700,
          // ),
        ),
      ),
    );
  }
}
