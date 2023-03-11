import 'package:flutter/material.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/size_configuration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/app_color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kTeacherPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 2,
              child: Image.asset(
                kLogoPath,
                height: getProportionateScreenHeight(120.h),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(6.0.sp),
            ),
            Text('Quizzed', style: kBodyText8Style()),
            SizedBox(
              height: 28.h,
            ),
            const CircularProgressIndicator(
              color: whiteColor,
              strokeWidth: 2,
              // backgroundColor: whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
