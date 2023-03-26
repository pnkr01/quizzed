import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/student/controller/student_home_controller.dart';
import 'package:quiz/src/pages/home/student/drawer/components/profile/controller/student_profile_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreenView extends StatelessWidget {
  const ProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentProfileController());
    Get.put(StudentHomeController());
    var controller = Get.find<StudentHomeController>();
    var myProfileController = Get.find<StudentProfileController>();
    return Scaffold(
      backgroundColor: kQuizPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kQuizPrimaryColor,
        title: Text(
          'Profile',
          style: kBodyText1Style().copyWith(color: whiteColor),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: kQuizPrimaryColor,
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 42.h,
                    backgroundColor: whiteColor,
                    child: CircleAvatar(
                      radius: 40.h, backgroundColor: kQuizPrimaryColor,
                      backgroundImage: const CachedNetworkImageProvider(
                          'https://img.freepik.com/free-vector/flat-design-bear-family-illustration_23-2149539189.jpg?w=740&t=st=1677930244~exp=1677930844~hmac=1ed6d9791d4c66b0f0ef74d0511b9a1ddf29643bff146eb88524829865455775'),
                      //backgroundColor: whiteColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          controller.getStudentName(),
                          style: kBodyText1Style().copyWith(color: whiteColor)),
                      Text(
                        "Student",
                        style: kBodyText3Style().copyWith(color: greyColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Obx(
                () => myProfileController.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28.h,
                                          width: 28.h,
                                          decoration: const BoxDecoration(
                                            color: kQuizLightPrimaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: whiteColor,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: Text(
                                              myProfileController
                                                      .profile[0].name ??
                                                  "Unknown",
                                              style: kBodyText9Style()),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 8,
                                    color: dividerColor,
                                  ),
                                  // const SizedBox(
                                  //   height: 15,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28.h,
                                          width: 28.h,
                                          decoration: const BoxDecoration(
                                            color: kQuizLightPrimaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.email_outlined,
                                            color: whiteColor,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: Text(
                                            myProfileController
                                                    .profile[0].email ??
                                                "Unknown",
                                            style: kBodyText9Style(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 8,
                                    color: dividerColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28.h,
                                          width: 28.h,
                                          decoration: const BoxDecoration(
                                            color: kQuizLightPrimaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.app_registration,
                                            color: whiteColor,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          myProfileController
                                                  .profile[0].regdNo ??
                                              "Unknown",
                                          style: kBodyText9Style(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 8,
                                    color: dividerColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28.h,
                                          width: 28.h,
                                          decoration: const BoxDecoration(
                                            color: kQuizLightPrimaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            myProfileController
                                                        .profile[0].gender ==
                                                    'M'
                                                ? Icons.male
                                                : Icons.female,
                                            color: whiteColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          myProfileController
                                                      .profile[0].gender ==
                                                  'M'
                                              ? "Male"
                                              : "Female",
                                          style: kBodyText9Style(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 8,
                                    color: dividerColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28.h,
                                          width: 28.h,
                                          decoration: const BoxDecoration(
                                            color: kQuizLightPrimaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.blur_on_sharp,
                                            color: whiteColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                            myProfileController
                                                    .profile[0].section ??
                                                "Unknown",
                                            style: kBodyText9Style()),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 8,
                                    color: dividerColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28.h,
                                          width: 28.h,
                                          decoration: const BoxDecoration(
                                            color: kQuizLightPrimaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.phone,
                                            color: whiteColor,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          myProfileController
                                                  .profile[0].primaryPhone ??
                                              "Unknown",
                                          style: kBodyText9Style(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 8,
                                    color: dividerColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28.h,
                                          width: 28.h,
                                          decoration: const BoxDecoration(
                                            color: kQuizLightPrimaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.date_range_outlined,
                                            color: whiteColor,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          myProfileController
                                                  .profile[0].dateOfBirth ??
                                              "Unknown",
                                          style: kBodyText9Style(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 8,
                                    color: dividerColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28.h,
                                          width: 28.h,
                                          decoration: const BoxDecoration(
                                            color: kQuizLightPrimaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.sentiment_satisfied_rounded,
                                            color: whiteColor,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "${myProfileController.profile[0].semester}th Semester",
                                          style: kBodyText9Style(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 8,
                                    color: dividerColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28.h,
                                          width: 28.h,
                                          decoration: const BoxDecoration(
                                            color: kQuizLightPrimaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.subject_outlined,
                                            color: whiteColor,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: Text(
                                            myProfileController
                                                    .profile[0].branch ??
                                                "Unknown",
                                            style: kBodyText3Style().copyWith(
                                                color: kQuizLightPrimaryColor),
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: SizedBox(
                                  height: 45,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kTeacherPrimaryColor,
                                        shape: const RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: kTeacherPrimaryColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)))),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child:
                                        Text('Okay', style: kBodyText2Style()),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kQuizPrimaryColor,
                          color: whiteColor,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
