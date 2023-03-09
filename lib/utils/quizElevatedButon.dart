import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:quiz/theme/app_color.dart';

import 'size_configuration.dart';

class QuizElevatedButton extends StatelessWidget {
  final Widget label;
  final Color backgroundColor;
  final Function()? function;
  final bool isBorderColorRequired;

  const QuizElevatedButton({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.function,
    this.isBorderColorRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isBorderColorRequired ? redColor : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          backgroundColor: backgroundColor,
        ),
        onPressed: function,
        child: label,
      ),
    );
  }
}
