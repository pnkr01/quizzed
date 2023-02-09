import 'package:flutter/material.dart';
import 'package:quiz/theme/app_color.dart';

import '../theme/gradient_theme.dart';
import '../utils/size_configuration.dart';

class MYElevatedButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Function()? function;
  const MYElevatedButton({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: backgroundColor,
        ),
        onPressed: function,
        child: Text(
          label,
          style: kTextStyle().copyWith(
            color: kOnElevatedButtonTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
