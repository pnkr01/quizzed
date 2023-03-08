import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/utils/quizElevatedButon.dart';
import 'package:quiz/src/pages/home/teacher/home/controller/teacher_home_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});
  static const String routeName = '/teacherHome';

  @override
  Widget build(BuildContext context) {
    Get.put(TeacherHomeController());
    var controller = Get.find<TeacherHomeController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kTeacherPrimaryLightColor,
      appBar: QuizAppbar(
        tariling: IconButton(
          onPressed: () {
            log('teacher side notifi tap');
          },
          icon: const Icon(Icons.notifications_active_outlined),
        ),
        appBarColor: kTeacherPrimaryLightColor,
        titleText: 'Quizzed',
        preferredSize: const Size.fromHeight(56),
        leading: IconButton(
          onPressed: () {
            log('teacher side menu tap');
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 45.h,
                            backgroundColor: kTeacherPrimaryColor,
                            child: CircleAvatar(
                              radius: 44.h, backgroundColor: kPrimaryColor,
                              backgroundImage: const CachedNetworkImageProvider(
                                  'https://img.freepik.com/free-vector/flat-design-bear-family-illustration_23-2149539189.jpg?w=740&t=st=1677930244~exp=1677930844~hmac=1ed6d9791d4c66b0f0ef74d0511b9a1ddf29643bff146eb88524829865455775'),
                              //backgroundColor: whiteColor,
                            ),
                          ),
                          SizedBox(
                            width: 8.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  'Prof. ${controller.teacherName}',
                                  style: kBodyText1Style()
                                      .copyWith(color: kTeacherPrimaryColor),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    'ID : ',
                                    style: kBodyText3Style()
                                        .copyWith(color: kTeacherPrimaryColor),
                                  ),
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    controller.teacherRegdNo,
                                    style: kBodyText3Style()
                                        .copyWith(color: kTeacherPrimaryColor),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Your Quizes',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Card(
                      margin: const EdgeInsets.only(top: 0, left: 8, right: 8),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: kTeacherPrimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        height: 180,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.circle,
                              color: whiteColor,
                              size: 15,
                            ),
                            Icon(
                              Icons.circle,
                              color: whiteColor,
                              size: 15,
                            ),
                            Icon(
                              Icons.circle,
                              color: whiteColor,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: [
                          QuizElevatedButton(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 5),
                                Text(
                                  'Profile',
                                  style: kBodyText3Style(),
                                ),
                              ],
                            ),
                            backgroundColor: kTeacherPrimaryColor,
                            function: () {},
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          QuizElevatedButton(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.create),
                                const SizedBox(width: 5),
                                Text(
                                  'Create Quiz',
                                  style: kBodyText3Style(),
                                ),
                              ],
                            ),
                            backgroundColor: kTeacherPrimaryColor,
                            function: () {
                              controller.navigateToCreateQuizScreen();
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          QuizElevatedButton(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.history),
                                const SizedBox(width: 5),
                                Text(
                                  'Past Quiz',
                                  style: kBodyText3Style(),
                                ),
                              ],
                            ),
                            backgroundColor: kTeacherPrimaryColor,
                            function: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
