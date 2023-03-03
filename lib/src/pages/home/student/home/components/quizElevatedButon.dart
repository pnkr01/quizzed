import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/size_configuration.dart';

class QuizElevatedButton extends StatelessWidget {
  final Widget label;
  final Color backgroundColor;
  final Function()? function;
  const QuizElevatedButton({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(45.sp),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: backgroundColor,
        ),
        onPressed: function,
        child: label,
      ),
    );
  }
}
