import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../theme/app_color.dart';
import '../../../../../../../utils/quizAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizResultView extends StatelessWidget {
  const QuizResultView({super.key});
  static const String routeName = '/studentQuizResult';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: SizedBox(
          height: 70,
          width: double.infinity,
          child: Container(
            color: kPrimaryColor,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: darkJoinColor),
              onPressed: () {
                //  controller.isTapStartJoining.value = true;
                Focus.of(context).unfocus();
                Get.back();
              },
              child: Text(
                'Okay',
                style: kElevatedButtonTextStyle().copyWith(
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: whiteColor,
        appBar: const QuizAppbar(
          appBarColor: kPrimaryColor,
          titleText: 'Result',
          preferredSize: Size.fromHeight(54),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            CachedNetworkImage(
                imageUrl:
                    'https://img.freepik.com/free-vector/business-team-looking-new-people-allegory-searching-ideas-staff-woman-with-magnifier-man-with-spyglass-flat-illustration_74855-18236.jpg?w=996&t=st=1677866505~exp=1677867105~hmac=27d845f87e695a7dcf46c8fb0e6cf64b5a4e2060b5072e4e328272a7de36924d'),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                'No Result found',
                style: kBodyText3Style().copyWith(color: blackColor),
              ),
            ),
          ],
        ));
  }
}
