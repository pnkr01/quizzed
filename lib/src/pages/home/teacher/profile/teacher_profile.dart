import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/teacher/profile/controller/teacher_profile_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherProfileScreen extends GetView<TeacherProfileController> {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTeacherPrimaryLightColor,
      appBar: const QuizAppbar(
        appBarColor: kTeacherPrimaryLightColor,
        titleText: 'Profile',
        preferredSize: Size.fromHeight(56),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    CircleAvatar(
                      radius: 48.r,
                      backgroundColor: kTeacherPrimaryColor,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:
                                'https://img.freepik.com/free-vector/flat-design-bear-family-illustration_23-2149539189.jpg?w=740&t=st=1677930244~exp=1677930844~hmac=1ed6d9791d4c66b0f0ef74d0511b9a1ddf29643bff146eb88524829865455775'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => controller.isFetching == false
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kTeacherPrimaryColor,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    'Pawan Kumar',
                                    style: kBodyText4Style().copyWith(
                                        color: kTeacherPrimaryLightColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 100,
                                    decoration: const BoxDecoration(
                                        color: kTeacherPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14))),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
