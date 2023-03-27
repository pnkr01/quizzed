import 'package:flutter/material.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/size_configuration.dart';
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
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text('Quizzed', style: kBodyText8Style()),
            const SizedBox(height: 28),
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
