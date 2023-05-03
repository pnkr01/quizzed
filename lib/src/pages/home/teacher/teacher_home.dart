import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/show_all_quiz.dart';
import 'package:quiz/src/pages/home/teacher/profile/teacher_profile.dart';
import 'package:quiz/src/pages/home/teacher/home/controller/teacher_home_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';

import '../../../db/local/local_db.dart';
import '../../../global/global.dart';
import '../../auth/components/login/common_auth_login_screen.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});
  static const String routeName = '/teacherHome';

  @override
  Widget build(BuildContext context) {
    Get.put(TeacherHomeController());
    var controller = Get.find<TeacherHomeController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kTeacherPrimaryColor,
      appBar: QuizAppbar(
        tariling: IconButton(
          onPressed: () {
            quizDebugPrint('logout');
            LocalDB.removeLoacalDb();
            Get.offAllNamed(CommmonAuthLogInRoute.routeName);
          },
          icon: const Icon(Icons.logout_outlined),
        ),
        appBarColor: kTeacherPrimaryColor,
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
            height: 20.h,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          'Notice',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      margin: const EdgeInsets.only(top: 0, left: 8, right: 8),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: const BoxDecoration(
                            color: kTeacherPrimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      height: 140,
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      decoration: const BoxDecoration(
                                          color: whiteColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.circle,
                                      size: 14,
                                      color: kTeacherPrimaryColor,
                                    ),
                                    Icon(
                                      Icons.circle,
                                      size: 14,
                                      color: kTeacherPrimaryColor,
                                    ),
                                    Icon(
                                      Icons.circle,
                                      size: 14,
                                      color: kTeacherPrimaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Actions',
                        style: kBodyText3Style()
                            .copyWith(color: kTeacherPrimaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GridView.count(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / (1.5 * 100)),
                      // crossAxisCount: 2,
                      children: [
                        GestureDetector(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: kTeacherPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: whiteColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Profile',
                                  style: kBodyText3Style(),
                                ),
                              ],
                            ),
                          ),
                          onTap: () =>
                              Get.to(() => const TeacherProfileScreen()),
                        ),
                        InkWell(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: kTeacherPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.create,
                                  color: whiteColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Create Quiz',
                                  style: kBodyText3Style(),
                                ),
                              ],
                            ),
                          ),
                          onTap: () => controller.navigateToCreateQuizScreen(),
                        ),
                        InkWell(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: kTeacherPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.history,
                                  color: whiteColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'All Quiz',
                                  style: kBodyText3Style(),
                                ),
                              ],
                            ),
                          ),
                          onTap: () => Get.to(() => const ShowAllCreatedQuiz()),
                        ),
                        InkWell(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: kTeacherPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.support_agent_outlined,
                                  color: whiteColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Support',
                                  style: kBodyText3Style(),
                                ),
                              ],
                            ),
                          ),
                          //   onTap: () => Get.to(() => const ShowAllCreatedQuiz()),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: kTeacherPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                        child: Text(
                          'Welcome to ITER QUIZ PORTAL',
                          style: kBodyText3Style(),
                        ),
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
