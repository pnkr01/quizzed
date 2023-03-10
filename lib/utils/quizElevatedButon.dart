import 'package:flutter/material.dart';

import 'package:quiz/theme/app_color.dart';

class QuizElevatedButton extends StatelessWidget {
  final Widget label;
  final Color backgroundColor;
  final Color? borderColor;
  final Function()? function;
  final bool isBorderColorRequired;

  const QuizElevatedButton({
    Key? key,
    required this.label,
    required this.backgroundColor,
    this.borderColor,
    required this.function,
    this.isBorderColorRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isBorderColorRequired
                  ? borderColor ?? redColor
                  : Colors.transparent,
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
