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
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 2,
              child: Image.asset(
            kLogoPath,
            height: 150,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Quizzed',
              style: kTextStyle().copyWith(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            const CircularProgressIndicator(
              color: Colors.blue,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
