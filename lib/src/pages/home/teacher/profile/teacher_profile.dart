import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quizzed/src/pages/home/teacher/profile/controller/teacher_profile_controller.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';
import 'package:quizzed/utils/quizAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzed/utils/quizElevatedButon.dart';

import '../../../../../utils/shimmer.dart';
import '../../../../global/global.dart';

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
                            placeholder: (context, url) =>
                                const NewsCardSkelton(),
                            fit: BoxFit.fill,
                            imageUrl:
                                'https://img.freepik.com/free-vector/flat-design-bear-family-illustration_23-2149539189.jpg?w=740&t=st=1677930244~exp=1677930844~hmac=1ed6d9791d4c66b0f0ef74d0511b9a1ddf29643bff146eb88524829865455775'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => controller.isFetching == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kTeacherPrimaryColor,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SingleChildScrollView(
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
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: whiteColor,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '5 Star',
                                                  style: kBodyText3Style(),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.north_east_outlined,
                                                  color: whiteColor,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '25+ Subject',
                                                  style: kBodyText3Style(),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.thumb_up,
                                                  color: whiteColor,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '1st CR',
                                                  style: kBodyText3Style(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GridView.count(
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      crossAxisCount: 2,
                                      childAspectRatio:
                                          (MediaQuery.of(context).size.width /
                                              (2 * 100)),
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: kTeacherPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller.title[0],
                                                style: kBodyText3Style(),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '${controller.profileList[0].RegdNo}',
                                                  style: kBodyText3Style(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: kTeacherPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller.title[1],
                                                style: kBodyText3Style(),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '${controller.profileList[0].Email}',
                                                  style: kBodyText3Style(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: kTeacherPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller.title[3],
                                                style: kBodyText3Style(),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '+91 ${controller.profileList[0].Phone}',
                                                  style: kBodyText3Style(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: kTeacherPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller.title[2],
                                                style: kBodyText3Style(),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  DateFormat(
                                                          'dd-mm-yyyy  hh : mm a')
                                                      .format(DateTime.tryParse(
                                                          '${controller.profileList[0].createdAt}')!),
                                                  style: kBodyText3Style(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Your Subjects',
                                        style: kBodyText7Style().copyWith(
                                            color: kTeacherPrimaryColor),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          7,
                                          (index) => Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            child: Chip(
                                              onDeleted: () {},
                                              deleteIconColor: whiteColor,
                                              backgroundColor:
                                                  controller.color[index],
                                              label: Text(
                                                controller.subject[index],
                                                style: kBodyText3Style(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Your Section',
                                        style: kBodyText7Style().copyWith(
                                            color: kTeacherPrimaryColor),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          7,
                                          (index) => Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            child: Chip(
                                              onDeleted: () {
                                                quizDebugPrint('deleted');
                                              },
                                              deleteIconColor: whiteColor,
                                              backgroundColor:
                                                  controller.color[6 - index],
                                              label: Text(
                                                controller.sec[index],
                                                style: kBodyText3Style(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    QuizElevatedButton(
                                      label: Text(
                                        'Back',
                                        style: kBodyText3Style(),
                                      ),
                                      backgroundColor:
                                          kTeacherPrimaryLightColor,
                                      function: () => Get.back(),
                                    )
                                  ],
                                ),
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
